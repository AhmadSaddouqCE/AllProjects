using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace PreClinic.Services
{
    [Index(nameof(Phone), IsUnique = true), ProducesResponseType(404)]
    [Index(nameof(Email), IsUnique = true), ProducesResponseType(404)]
    [Index(nameof(userName), IsUnique = true), ProducesResponseType(404)]
    public class Doctor
    {

        [Key]
        public int doctorId { get; set; }

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
        public ICollection<DoctorBranches>? DoctorBranches { get; set; }
        public ICollection<Patient>? Patients { get; set; }

        [NotMapped]
        public IFormFile? doctorImage { get; set; }
        public string? ImageUrl { get; set; }
        public ICollection<DoctorDepartment>? DoctorDepartment { get; set; }

        [Required(ErrorMessage = "Username is required.")]
        public string? userName { get; set; }

        [Required(ErrorMessage = "Password is required.")]
        public string? Password { get; set; }

    }
}