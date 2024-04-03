using AutoMapper;
using Microsoft.AspNetCore.Cors;
using Microsoft.AspNetCore.Mvc;
using PreClinic.Dto;
using PreClinic.Services;
using RouteAttribute = Microsoft.AspNetCore.Mvc.RouteAttribute;

namespace PreClinic.Controllers
{
    [Route("api/[controller]/[action]")]
    [ApiController]
    [EnableCors("AllowOrigin")]

    public class DepartmentController : Controller
    {
        private readonly DepartmentService _departmentService;
        private readonly IMapper _mapper;
        public DepartmentController(DepartmentService departmentService, IMapper mapper)
        {
            _departmentService = departmentService;
            _mapper = mapper;
        }
        [HttpPost]
        public async Task<IActionResult> addDepartment([FromForm] DepartmentDto departmentDto)
        {
            var errorMessage = await _departmentService.ValidateModelAsync(ModelState);
            if (!string.IsNullOrEmpty(errorMessage)) return BadRequest(errorMessage);

            var mappingDepartment = _mapper.Map<Department>(departmentDto);
            var (isSuccess, newDepartmentId) = await _departmentService.addDepartment(mappingDepartment);

            if (isSuccess)
            {
                return Ok(new
                {
                    message = "New Department Added Succefully",
                    departmentId = newDepartmentId
                });
            }
            return BadRequest("Something Error Happened");
        }
        [HttpGet]
        public async Task<IActionResult> getAllDepartments()
        {
            try
            {
                var getDepartments = await _departmentService.getAllDepartments();
                if (getDepartments.Count <= 0) throw new Exception("No Departments Available");
                return Ok(getDepartments);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }

        }
    }
}
