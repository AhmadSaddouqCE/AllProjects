using Azure.Storage.Blobs;
using CenterApp.Data;
using CenterApp.Models;
using Microsoft.EntityFrameworkCore;

namespace CenterApp.Services
{
    public class CategoryServices
    {
        private readonly DataContext _context;
        public CategoryServices(DataContext context)
        {
            _context = context;
        }
        public async Task<(bool, Category)> addCategory(Category category, int catId)
        {
            var categoryId = await _context.Categories.FindAsync(catId);
            if (categoryId != null) throw new Exception("This Category Exist");
            // string connectionString = @"DefaultEndpointsProtocol=https;AccountName=centercontainerapp;AccountKey=1cJ8BE0WIm8ZLPRNHLc/At9LW1uHcme42IaSue2U/kh7h+lm+fpT1o41B15XsaYwA/XAyqeGsaGq+AStsir7XA==;EndpointSuffix=core.windows.net";
            // string containerName = "image";
            // BlobContainerClient blobContainerClient = new BlobContainerClient(connectionString, containerName);
            // string uniqueBlobName = Guid.NewGuid().ToString() + "_" + category.CategoryImage.FileName;
            // BlobClient blobClient = blobContainerClient.GetBlobClient(uniqueBlobName);
            // var memoryStream = new MemoryStream();
            // await category.CategoryImage.CopyToAsync(memoryStream);
            // memoryStream.Position = 0;
            // await blobClient.UploadAsync(memoryStream);
            var newCategory = new Category()
            {
                categoryName = category.categoryName,
                // ImageUrl = blobClient.Uri.AbsoluteUri,
                CreatedAt = DateTime.Now,
                UpdatedAt = DateTime.Now,
            };


            await _context.Categories.AddAsync(newCategory);
            return (await Save(), newCategory);
        }
        public async Task<IEnumerable<Category>> getAllCategories()
        {
            return await _context.Categories.ToListAsync();
        }
        public async Task<bool> deleteCategory(int? categoryId)
        {
            var getCategory = await _context.Categories.FindAsync(categoryId);
            if (getCategory == null) throw new Exception("This Category Doesn't Exist");
            var getProducts_CategoryId = await _context.Products
                .Where(id => id.categoryId == categoryId)
                .ToListAsync();
            foreach (var product in getProducts_CategoryId)
            {
                product.categoryId = null;
            }
            _context.Categories.Remove(getCategory);
            return await Save();
        }
        public async Task<bool> editCategory(Category category)
        {
            var catId = await _context.Categories
                .Where(id => id.categoryId == category.categoryId)
                .FirstOrDefaultAsync();
            if (catId is null) throw new Exception("This Category Doesn't Exist");
            var getImage = catId.ImageUrl;
            if (category.CategoryImage != null)
            {
                string connectionString = @"DefaultEndpointsProtocol=https;AccountName=centercontainerapp;AccountKey=1cJ8BE0WIm8ZLPRNHLc/At9LW1uHcme42IaSue2U/kh7h+lm+fpT1o41B15XsaYwA/XAyqeGsaGq+AStsir7XA==;EndpointSuffix=core.windows.net";
                string containerName = "image";
                BlobContainerClient blobContainerClient = new BlobContainerClient(connectionString, containerName);

                string uniqueBlobName = Guid.NewGuid().ToString() + "_" + category.CategoryImage.FileName;
                BlobClient blobClient = blobContainerClient.GetBlobClient(uniqueBlobName);
                var memoryStream = new MemoryStream();
                await category.CategoryImage.CopyToAsync(memoryStream);
                memoryStream.Position = 0;
                await blobClient.UploadAsync(memoryStream);
                catId.ImageUrl = blobClient.Uri.AbsoluteUri;
            }
            else
            {
                catId.ImageUrl = getImage;
            }

            if (catId.categoryName is not null
                &&
                catId.categoryName.Equals(category.categoryName))
            {
                await Save();
                return true;
            }
            catId.categoryName = category.categoryName;
            var getProduct_CategoryId = await _context.Products
                .Where(id => id.categoryId == category.categoryId)
                .ToListAsync();
            foreach (var product in getProduct_CategoryId)
            {
                product.categoryId = null;
            }

            return await Save();
        }
        public async Task<List<Product>> getProductsInCategoryId(int categoryId)

        {
            var getCategory = await _context.Categories.FindAsync(categoryId);
            if (getCategory == null) throw new Exception("This Category Doesn't Exist");
            var getProducts_CategoryId = await _context.Products.Where(id => id.categoryId == categoryId).ToListAsync();
            return getProducts_CategoryId;
        }
        public async Task<bool> Save()
        {
            var saved = await _context.SaveChangesAsync();
            return saved > 0 ? true : false;
        }
    }
}
