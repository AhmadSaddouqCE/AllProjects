using Newtonsoft.Json;
using System.ComponentModel.DataAnnotations;

namespace PreClinic.Dto
{
    public class DoctorDto
    {
        public int? doctorId { get; set; }

        [Required(ErrorMessage = "Doctor Name is required.")]
        public string? doctorNameE1 { get; set; }

        [Required(ErrorMessage = "Doctor Name is required.")]
        public string? doctorNameE2 { get; set; }

        [Required(ErrorMessage = "Doctor Name is required.")]
        public string? doctorNameE3 { get; set; }

        [Required(ErrorMessage = "Doctor Name is required.")]
        public string? doctorNameE4 { get; set; }

        [Required(ErrorMessage = "Doctor Name is required.")]
        public string? doctorNameA1 { get; set; }

        [Required(ErrorMessage = "Doctor Name is required.")]
        public string? doctorNameA2 { get; set; }

        [Required(ErrorMessage = "Doctor Name is required.")]
        public string? doctorNameA3 { get; set; }

        [Required(ErrorMessage = "Doctor Name is required.")]
        public string? doctorNameA4 { get; set; }

        [Required(ErrorMessage = "Doctor Name is required.")]
        public string? Phone { get; set; }

        public string? AddressE { get; set; }
        public string? AddressA { get; set; }

        public string? Email { get; set; }

        [Required(ErrorMessage = "Email is required.")]
        public DateTime? dateOfBirth { get; set; }

        [Required(ErrorMessage = "Date Of Birth is required.")]
        public string? Gender { get; set; }
        public IFormFile? doctorImage { get; set; }

        [Required(ErrorMessage = "Username is required.")]
        public string? userName { get; set; }

        [Required(ErrorMessage = "Password is required.")]
        public string? Password { get; set; }
        public Dictionary<string, List<Departments>>? BranchesDepartmentsJson { get; set; }
        public string? BranchesDepartments { get; set; }

    }
    public class Departments
    {
        public string? itemId { get; set; }
        public string? departmentName { get; set; }
    }
}
