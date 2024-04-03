using AutoMapper;
using CenterApp.AppDto;
using CenterApp.Models;
using CenterApp.Services;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Cors;
using Microsoft.AspNetCore.Mvc;

namespace CenterApp.Controllers
{
    [Route("Products")]
    [ApiController]
    [EnableCors("AllowOrigin")]
    public class ProductController : Controller
    {
        private readonly ProductService _productService;
        private readonly IMapper _mapper;
        public ProductController(ProductService productService, IMapper mapper)
        {
            _productService = productService;
            _mapper = mapper;
        }
        [HttpPost("editProduct")]
        [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme, Roles = "Admin")]
        public async Task<IActionResult> editProduct([FromForm] ProductDto product)
        {
            try
            {
                var mapping = _mapper.Map<Product>(product);
                if (await _productService.editProduct(mapping, product.Id))
                {
                    return Ok("Product Updated Succefully");
                }

            }
            catch (Exception ex)
            {
                if (ex.InnerException != null)
                {
                    return StatusCode(500, "This Product Name Does Exist");

                }
                return StatusCode(500, ex.Message);
            }
            return BadRequest("Something Error Happened");
        }
        [HttpDelete("deleteProduct/{productId}")]
        [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme, Roles = "Admin")]
        public async Task<IActionResult> deleteProduct(int productId)
        {
            try
            {
                if (await _productService.deleteProduct(productId))
                {
                    return Ok("Product Deleted Succefully");
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
            return BadRequest("Something wrong happened");
        }

        [HttpPost("addProduct")]
        [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme, Roles = "Admin")]
        public async Task<IActionResult> addProducts([FromForm] ProductDto product)
        {
            try
            {
                var mappingProduct = _mapper.Map<Product>(product);
                var (isProductAdded, newProduct) = await _productService.addProduct(mappingProduct, product.categoryId);
                if (isProductAdded)
                {
                    return Ok(new
                    {
                        Message = "New Product Is Created Successfully",
                        Products = newProduct
                    });
                }
            }
            catch (Exception ex)
            {
                string errorMessage = "An error occurred.";
                if (ex.InnerException != null)
                {
                    if (ex.InnerException.Message.Contains("Name"))
                    {
                        errorMessage = "This Product already exists";
                    }

                }

                return StatusCode(500, errorMessage);
            }



            return NoContent();
        }
        [HttpGet("getAllProducts")]
        [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme, Roles = "Customer")]
        public async Task<IActionResult> getAllProducts()
        {
            try
            {
                var getProducts = await _productService.getAllProducts();
                if (getProducts.Count == 0)
                {
                    return BadRequest("No Products Found");
                }
                return Ok(getProducts);
            }
            catch (Exception ex)
            {
                StatusCode(500, ex.Message);
            }
            return BadRequest("Something Wrong Happened");
        }
        [HttpGet("getAllProductsAdmin")]
        [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme, Roles = "Admin")]
        public async Task<IActionResult> getAllProductsAdmin()
        {
            try
            {
                var getProducts = await _productService.getAllProductsAdmin();
                if (getProducts.Count == 0)
                {
                    return BadRequest("No Products Found");
                }
                return Ok(getProducts);
            }
            catch (Exception ex)
            {
                StatusCode(500, ex.Message);
            }
            return BadRequest("Something Wrong Happened");
        }
        [HttpGet("productPagination/{page}/{pageSize}")]
        public async Task<IActionResult> GetPages(int page, int pageSize)
        {

            List<Product> productList = await _productService.getAllProducts();
            int totalCount = productList.Count;
            int itemsToSkip = page * pageSize;
            var ProductsPerPage = productList
                .Skip(itemsToSkip)
                .Take(pageSize)
                .ToList();
            return Ok(ProductsPerPage);
        }

    }
}
