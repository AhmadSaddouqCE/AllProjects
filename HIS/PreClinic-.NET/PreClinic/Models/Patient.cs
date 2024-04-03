using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace PreClinic.Services
{
    [Index(nameof(Phone), IsUnique = true), ProducesResponseType(404)]
    [Index(nameof(Email), IsUnique = true), ProducesResponseType(404)]
    [Index(nameof(cardId), IsUnique = true), ProducesResponseType(404)]
    public class Patient
    {
        [Key]
        public int PateintId { get; set; }

        [Required(ErrorMessage = "Patient Name is required.")]
        public int? cardId { get; set; }

        [Required(ErrorMessage = "Patient Name is required.")]
        public string? patientNameE1 { get; set; }

        [Required(ErrorMessage = "Patient Name is required.")]
        public string? patientNameE2 { get; set; }

        [Required(ErrorMessage = "Patient Name is required.")]
        public string? patientNameE3 { get; set; }

        [Required(ErrorMessage = "Patient Name is required.")]
        public string? patientNameE4 { get; set; }

        [Required(ErrorMessage = "Patient Name is required.")]
        public string? patientNameA1 { get; set; }

        [Required(ErrorMessage = "Patient Name is required.")]
        public string? patientNameA2 { get; set; }

        [Required(ErrorMessage = "Patient Name is required.")]
        public string? patientNameA3 { get; set; }

        [Required(ErrorMessage = "Patient Name is required.")]
        public string? patientNameA4 { get; set; }

        [Required(ErrorMessage = "Phone number is required.")]
        public string? Phone { get; set; }

        [Required(ErrorMessage = "Address is required.")]
        public string? AddressE { get; set; }
        public string? AddressA { get; set; }
        [Required(ErrorMessage = "Email is required.")]
        public string? Email { get; set; }

        [Required(ErrorMessage = "Date Of Birth is required.")]
        public DateTime? dateOfBirth { get; set; }

        [Required(ErrorMessage = "Gender is required.")]
        public string? Gender { get; set; }
        public int? doctorId { get; set; }
        public Doctor? Doctor { get; set; }

        [NotMapped]
        public IFormFile? patientImage { get; set; }
        public string? ImageUrl { get; set; }
    }
}
