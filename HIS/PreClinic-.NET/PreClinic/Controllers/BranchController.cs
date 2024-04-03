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
    public class BranchController : Controller
    {
        private readonly BranchService _branchService;
        private readonly IMapper _mapper;
        public BranchController(BranchService branchService, IMapper mapper)
        {
            _branchService = branchService;
            _mapper = mapper;
        }
        [HttpPost]
        public async Task<IActionResult> addBranch([FromForm] BranchDto branch)
        {
            var errorMessage = await _branchService.ValidateModelAsync(ModelState);
            if (!string.IsNullOrEmpty(errorMessage)) return BadRequest(errorMessage);

            var mappingBranch = _mapper.Map<Branch>(branch);
            var (isSuccess, newBranchId) = await _branchService.addBranch(mappingBranch);
            if (isSuccess)
            {
                return Ok(new
                {
                    message = "Branch Added Succefully",
                    branchId = newBranchId
                });
            }
            return BadRequest("Something Wrong Happened");
        }
        [HttpGet]
        public async Task<IActionResult> getBranches()
        {
            try
            {
                var branchesList = await _branchService.getBranches();
                if (branchesList.Count <= 0) throw new Exception("No Branches Available");
                return Ok(branchesList);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
        [HttpPost]
        public async Task<IActionResult> getDepartmentInBranches([FromForm] int? branchId)
        {
            try
            {
                var getDepartments = await _branchService.getDepartmentInBranches(branchId);
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
