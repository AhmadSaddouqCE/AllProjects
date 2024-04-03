
using Azure.Storage.Blobs;
using CenterApp.Data;
using CenterApp.Models;
using Microsoft.EntityFrameworkCore;

namespace CenterApp.Services
{
    public class ProductService
    {
        private readonly DataContext _context;
        private readonly IWebHostEnvironment _webHostEnvironment;

        public ProductService(DataContext context, IWebHostEnvironment webHostEnvironment)
        {
            _context = context;
            _webHostEnvironment = webHostEnvironment;
        }



        public async Task<(bool, Product)> addProduct(Product product, int categoryId)
        {
            // string connectionString = @"DefaultEndpointsProtocol=https;AccountName=centercontainerapp;AccountKey=1cJ8BE0WIm8ZLPRNHLc/At9LW1uHcme42IaSue2U/kh7h+lm+fpT1o41B15XsaYwA/XAyqeGsaGq+AStsir7XA==;EndpointSuffix=core.windows.net";
            // string containerName = "image";
            // BlobContainerClient blobContainerClient = new BlobContainerClient(connectionString, containerName);
            // string uniqueBlobName = Guid.NewGuid().ToString() + "_" + product.ProductImage.FileName;
            // BlobClient blobClient = blobContainerClient.GetBlobClient(uniqueBlobName);
            // var memoryStream = new MemoryStream();
            // await product.ProductImage.CopyToAsync(memoryStream);
            // memoryStream.Position = 0;
            // await blobClient.UploadAsync(memoryStream);
            var getCategory = await _context.Categories.FindAsync(categoryId);
            if (getCategory is null) throw new Exception("This Category Doesn't Exist");
            var newProduct = new Product()
            {
                Name = product.Name,
                Quantity = product.Quantity,
                Price = product.Price,
                Description = product.Description,
                CreatedAt = DateTime.Now,
                UpdatedAt = DateTime.Now,
                // ImageUrl = blobClient.Uri.AbsoluteUri,
                categoryId = categoryId,
            };
            await _context.Products.AddAsync(newProduct);
            return (await Save(), newProduct);
        }
        public async Task<bool> deleteProduct(int productId)
        {
            var getProduct = await _context.Products.FindAsync(productId);
            if (getProduct is null) throw new Exception("This Product Doesn't Exist");
            var getProductCart = await _context.Carts.Where(id => id.ProductId == productId).FirstOrDefaultAsync();
            if (getProductCart != null) _context.Carts.Remove(getProductCart);
            _context.Products.Remove(getProduct);
            return await Save();

        }

        public async Task<List<Product>> getAllProducts()
        {
            var Products = await _context.Products
                .Where(categoryId => categoryId.categoryId != null)
                .ToListAsync();
            return Products;
        }
        public async Task<List<Product>> getAllProductsAdmin()
        {
            return await _context.Products.ToListAsync();
        }
        public async Task<bool> editProduct(Product product, int? productId)
        {
            var getProduct = await _context.Products.FindAsync(productId);
            if (getProduct is null) throw new Exception("This Product Doesn't Exist");
            var getImageUrl = getProduct.ImageUrl;
            var getCategory = await _context.Categories.FindAsync(product.categoryId);
            if (getCategory is null) throw new Exception("This Category Doesn't Exist");
            if (product.Quantity < 0 || product.Quantity is null || product.Price is null
                || product.Price <= 0 ||
                product.Description is null || product.Name is null) throw new Exception("Wrong Entries");
            var getCart_ProductId = await _context.Carts.Where(id => id.ProductId == productId).FirstOrDefaultAsync();
            if (getCart_ProductId != null) getCart_ProductId.Price = (int?)product.Price;
            if (product.ProductImage != null)
            {
                string connectionString = @"DefaultEndpointsProtocol=https;AccountName=centercontainerapp;AccountKey=1cJ8BE0WIm8ZLPRNHLc/At9LW1uHcme42IaSue2U/kh7h+lm+fpT1o41B15XsaYwA/XAyqeGsaGq+AStsir7XA==;EndpointSuffix=core.windows.net";
                string containerName = "image";
                BlobContainerClient blobContainerClient = new BlobContainerClient(connectionString, containerName);

                string uniqueBlobName = Guid.NewGuid().ToString() + "_" + product.ProductImage.FileName;
                BlobClient blobClient = blobContainerClient.GetBlobClient(uniqueBlobName);
                var memoryStream = new MemoryStream();
                await product.ProductImage.CopyToAsync(memoryStream);
                memoryStream.Position = 0;
                await blobClient.UploadAsync(memoryStream);
                getProduct.ImageUrl = blobClient.Uri.AbsoluteUri;
            }
            else
            {
                getProduct.ImageUrl = getImageUrl;
            }
            if (getProduct.Name != null)
            {
                if (getProduct.Name.Equals(product.Name))
                {

                    getProduct.Price = product.Price;
                    getProduct.Description = product.Description;
                    getProduct.Quantity = product.Quantity;
                    getProduct.UpdatedAt = DateTime.Now;
                    getProduct.categoryId = product.categoryId;
                    return await Save();
                }
            }
            getProduct.Name = product.Name;
            getProduct.Price = product.Price;
            getProduct.Description = product.Description;
            getProduct.Quantity = product.Quantity;
            getProduct.UpdatedAt = DateTime.Now;
            getProduct.categoryId = product.categoryId;
            return await Save();

        }
        public async Task<bool> Save()
        {
            var saved = await _context.SaveChangesAsync();
            return saved > 0 ? true : false;
        }
    }

}
