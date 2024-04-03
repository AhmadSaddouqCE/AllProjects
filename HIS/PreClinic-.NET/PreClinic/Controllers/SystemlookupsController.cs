using AutoMapper;
using Microsoft.AspNetCore.Cors;
using Microsoft.AspNetCore.Mvc;
using PreClinic.Services;

namespace PreClinic.Controllers
{
    [Route("api/[controller]/[action]")]
    [ApiController]
    [EnableCors]
    public class SystemlookupsController : Controller
    {
        private readonly SystemlookupsService _lookupsService;
        private readonly IMapper _mapper;
        public SystemlookupsController(SystemlookupsService lookupsService, IMapper mapper)
        {
            _lookupsService = lookupsService;
            _mapper = mapper;
        }
        [HttpGet]
        public async Task<IActionResult> getAllLookups()
        {
            try
            {
                var getLookups = await _lookupsService.getSystemlookups();
                if (getLookups.Count <= 0) throw new Exception("No Lookups Found");
                return Ok(getLookups);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
        [HttpGet]
        public async Task<IActionResult> getItemsBasedOnCode(int? categoryId)
        {
            try
            {
                var getList = await _lookupsService.getItemsBasedOnCode(categoryId);
                if (getList.Count <= 0) throw new Exception("No Items Available");
                return Ok(getList);

            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
    }
}
