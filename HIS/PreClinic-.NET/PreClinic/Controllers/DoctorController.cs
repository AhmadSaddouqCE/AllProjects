using AutoMapper;
using Microsoft.AspNetCore.Cors;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using PreClinic.Dto;
using PreClinic.Services;

namespace PreClinic.Controllers
{
    [Route("api/[controller]/[action]")]
    [ApiController]
    [EnableCors("AllowOrigin")]
    public class DoctorController : Controller
    {
        private readonly DoctorService _doctorService;
        private readonly IMapper _mapper;
        public DoctorController(DoctorService doctorService, IMapper mapper)
        {
            _doctorService = doctorService;
            _mapper = mapper;
        }
        [HttpGet]
        public async Task<IActionResult> getDoctorsPagination(int page = 1, int pageSize = 5)
        {
            try
            {
                var getDoctors = await _doctorService.getDoctorsPagination(page, pageSize);
                if (getDoctors == null || getDoctors.Count <= 0) return BadRequest("No Doctors Available");
                var totalCount = await _doctorService.getDoctorsCount();
                return Ok(new { TotalCount = totalCount, Doctors = getDoctors });
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
        [HttpPost]
        public async Task<IActionResult> addDoctor([FromForm] DoctorDto doctor)
        {
            try
            {
                var errorMessage = await _doctorService.ValidateModelAsync(ModelState);
                if (!string.IsNullOrEmpty(errorMessage)) return BadRequest(errorMessage);
                if (string.IsNullOrEmpty(doctor.BranchesDepartments)) throw new Exception("Please Select Branches/Departments");
                doctor.BranchesDepartmentsJson = JsonConvert
                    .DeserializeObject<Dictionary<string, List<Departments>>>
                    (doctor.BranchesDepartments);
                if (doctor.BranchesDepartmentsJson is null) throw new Exception("Error Deserializing Data");
                var mappingDoctor = _mapper.Map<Doctor>(doctor);
                if (await _doctorService.addDoctor(mappingDoctor, doctor.BranchesDepartmentsJson)) return Ok("New doctor added Succefully");
            }
            catch (Exception ex)
            {
                var errorMessage = "";
                if (ex.InnerException is not null)
                {
                    errorMessage = "This Doctor Exists";
                    return BadRequest(errorMessage);
                }
                return BadRequest(ex.Message);
            }
            return BadRequest("Something Wrong Happened");
        }
        [HttpGet]
        public async Task<IActionResult> getAllDoctors()
        {
            try
            {
                var listDoctors = await _doctorService.getAllDoctors();
                return Ok(listDoctors);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
    }
}
