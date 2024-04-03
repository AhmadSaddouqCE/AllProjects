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
    [ApiController]
    [Route("Category")]
    [EnableCors]
    public class CategoryController : Controller
    {
        private readonly CategoryServices _categoryServices;
        private readonly IMapper _mapper;
        public CategoryController(CategoryServices categoryServices, IMapper mapper)
        {
            _categoryServices = categoryServices;
            _mapper = mapper;
        }
        [HttpPost("addCategory")]
        [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme, Roles = "Admin")]
        public async Task<IActionResult> addCategory([FromForm] CategoryDto categoryDto)
        {
            try
            {
                var mapping = _mapper.Map<Category>(categoryDto);
                var (iscategoryAdded, newCategory) = await _categoryServices.addCategory(mapping, mapping.categoryId);
                if (iscategoryAdded)
                {
                    return Ok(new
                    {
                        Message = "New Category Added",
                        Category = newCategory
                    });
                }
            }
            catch (Exception ex)
            {
                if (ex.InnerException != null)
                {
                    return StatusCode(500, "This Category Name Does Exist");

                }
                return StatusCode(500, ex.Message);
            }
            return BadRequest("Something Wrong Happened");
        }
        [HttpDelete("deleteCategory/{categoryId}")]
        public async Task<IActionResult> deleteCategory(int categoryId)
        {
            try
            {
                if (await _categoryServices.deleteCategory(categoryId))
                {
                    return Ok("Category Deleted Succefully");
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
            return BadRequest("Something wrong happened");
        }
        [HttpPost("modifyCategory")]
        public async Task<IActionResult> modifyCategory([FromForm] CategoryDto category)
        {
            try
            {
                if (category.categoryId is null || category.categoryName is null)
                    return BadRequest("Fill All The Fields");
                var mapping = _mapper.Map<Category>(category);
                if (await _categoryServices.editCategory(mapping))
                {
                    return Ok("Category Updated Succefully");
                }
            }
            catch (Exception ex)
            {
                if (ex.InnerException != null)
                {
                    return StatusCode(500, "This Category Name Does Exist");

                }
                return StatusCode(500, ex.Message);
            }
            return BadRequest("Something Wrong Happened");

        }
        [HttpGet("getAllCategories")]
        [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme, Roles = "Admin, Customer")]

        public async Task<IActionResult> getAllCategories()
        {
            try
            {
                var getAll = await _categoryServices.getAllCategories();
                if (getAll == null) throw new Exception("No Categories Found");
                return Ok(getAll);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
        [HttpGet("getProductByCategoryId/{categoryId}")]
        [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme, Roles = "Customer")]

        public async Task<IActionResult> getProductByCategoryId(int categoryId)
        {
            try
            {
                var getProducts = await _categoryServices.getProductsInCategoryId(categoryId);
                return Ok(getProducts);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }

        }
    }
}
