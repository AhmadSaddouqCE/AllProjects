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
    public class PatientController : Controller
    {
        private readonly PatientService _patientService;
        private readonly IMapper _mapper;
        public PatientController(PatientService patientService, IMapper mapper)
        {
            _patientService = patientService;
            _mapper = mapper;
        }
        [HttpGet]
        public async Task<IActionResult> getPatientsPagination(int page = 1, int pageSize = 5)
        {
            try
            {
                var getPatients = await _patientService.getPatientsPagination(page, pageSize);
                if (getPatients == null || getPatients.Count <= 0) return BadRequest("No Doctors Available");
                var totalCount = await _patientService.getPatientsCount();
                return Ok(new { TotalCount = totalCount, Patients = getPatients });
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
        [HttpPost]
        public async Task<IActionResult> addPatient([FromForm] PatientDto patient)
        {
            try
            {
                var errorMessage = await _patientService.ValidateModelAsync(ModelState);
                if (!string.IsNullOrEmpty(errorMessage)) return BadRequest(errorMessage);

                var mappingPatient = _mapper.Map<Patient>(patient);
                if (await _patientService.addPatient(mappingPatient)) return Ok("New Patient Added");
            }
            catch (Exception ex)
            {
                var errorMessage = "";
                if (ex.InnerException is not null)
                {
                    errorMessage = "This Patient Exists";
                    return BadRequest(errorMessage);
                }
                return BadRequest(ex.Message);
            }
            return BadRequest("Something Wrong Happened");
        }

    }
}
