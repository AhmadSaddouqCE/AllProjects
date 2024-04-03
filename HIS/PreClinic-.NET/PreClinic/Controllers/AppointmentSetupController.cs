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
    public class AppointmentSetupController : Controller
    {
        private readonly AppointmentSetupService _appointmentSetupService;
        private readonly IMapper _mapper;
        public AppointmentSetupController(AppointmentSetupService appointmentSetupService, IMapper mapper)
        {
            _appointmentSetupService = appointmentSetupService;
            _mapper = mapper;
        }
        [HttpPost]
        public async Task<IActionResult> addDoctorAppointmentSetup([FromBody] List<DoctorAppointmentSetupsDto> doctorAppointmentSetups)
        {
            try
            {
                var mappingDoctorAppointments = _mapper.Map<List<DoctorAppointmentSetup>>(doctorAppointmentSetups);
                if (await _appointmentSetupService.addDoctorAppointmentSetups(mappingDoctorAppointments))
                {
                    return Ok("New Setup Added");
                }
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
            return BadRequest("Something Wrong Happened");
        }
        [HttpPost]
        public async Task<IActionResult> getDoctorDetails([FromForm] DoctorAppointmentSetupsDto doctorAppointmentSetups)

        {
            try
            {
                var getList = await _appointmentSetupService
                    .getSetupDetails(doctorAppointmentSetups.BranchId, doctorAppointmentSetups.DepartmentId, doctorAppointmentSetups.DoctorId);
                if (getList.Count <= 0) throw new Exception("No Details Available");
                return Ok(getList);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }

        }
    }
}

