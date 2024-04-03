using AutoMapper;
using Microsoft.AspNetCore.Cors;
using Microsoft.AspNetCore.Mvc;
using PreClinic.Dto;
using PreClinic.Models;
using PreClinic.Services;

namespace PreClinic.Controllers
{
    [Route("api/[controller]/[action]")]
    [ApiController]
    [EnableCors("AllowOrigin")]
    public class DepartmentsBranhcesController : Controller
    {
        private readonly DepartmentsBranhcesService _departmentsBranhcesService;
        private readonly IMapper _mapper;
        public DepartmentsBranhcesController(DepartmentsBranhcesService departmentsBranhcesService, IMapper mapper)
        {
            _departmentsBranhcesService = departmentsBranhcesService;
            _mapper = mapper;
        }
        [HttpPost]
        public async Task<IActionResult> addDepartmentToBranch([FromForm] DepartmentBranchesDto departmentBranchesDto)
        {
            try
            {
                var mappingDepartmentBranches = _mapper.Map<DepartmentBranches>(departmentBranchesDto);
                int? departmentId = mappingDepartmentBranches.departmentId;
                int? branchId = mappingDepartmentBranches.branchId;
                if (await _departmentsBranhcesService.addDeparmentToBranch(departmentId, branchId))
                {
                    return Ok("Added Succefully");
                }
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
            return BadRequest("Something Error Happened");
        }
        [HttpGet]
        public async Task<IActionResult> getDepartmentByBranchId(int? branchId)
        {
            try
            {
                var getDepartments = await _departmentsBranhcesService.getDepartmentsByBranchId(branchId);
                return Ok(getDepartments);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
        [HttpPost]
        public async Task<IActionResult> getDoctorsInBranches([FromForm] DoctorsInDepartmentAndBranchesDto departmentsInBranchesDto)
        {
            try
            {
                var doctorsNameList = await _departmentsBranhcesService.getDoctorsInBranchAndDepartment(departmentsInBranchesDto);
                if (doctorsNameList.Count <= 0) throw new Exception("No Doctors Available");
                return Ok(doctorsNameList);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
            return BadRequest("Something Wrong Happened");
        }
    }
}
