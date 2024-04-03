using AutoMapper;
using Microsoft.AspNetCore.Cors;
using Microsoft.AspNetCore.Mvc;
using PreClinic.Dto;
using PreClinic.Services;

namespace PreClinic.Controllers
{
    [Route("api/[controller]/[action]")]
    [ApiController]
    [EnableCors("AllowOrigin")]
    public class SystemlookupsCategoryController : Controller
    {
        private readonly SystemlookupsCategoryService _systemlookupsCategoryService;
        private readonly IMapper _mapper;
        public SystemlookupsCategoryController(SystemlookupsCategoryService systemlookupsCategoryService, IMapper mapper)
        {
            _systemlookupsCategoryService = systemlookupsCategoryService;
            _mapper = mapper;
        }
        [HttpGet]
        public async Task<IActionResult> getCategories()
        {
            try
            {
                var getCategories = await _systemlookupsCategoryService.getCategories();
                if (getCategories.Count <= 0) throw new Exception("No Categories Available");
                return Ok(getCategories);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
        [HttpPost]
        public async Task<IActionResult> addCategory([FromForm] SystemlookupsCategoryDto category)
        {
            try
            {
                var errorMessage = await _systemlookupsCategoryService.ValidateModelAsync(ModelState);
                if (!string.IsNullOrEmpty(errorMessage)) return BadRequest(errorMessage);

                var mappingCategory = _mapper.Map<SystemLookupsCategory>(category);
                if (await _systemlookupsCategoryService.addCategory(mappingCategory)) return Ok("Category Added Succefully");
            }
            catch (Exception ex)
            {
                var errorMessage = "";
                if (ex.InnerException is not null)
                {
                    errorMessage = "This Category Exist";
                    return BadRequest(errorMessage);
                }

                return BadRequest(ex.Message);
            }
            return BadRequest("Something Wrong Happened");

        }
    }
}
