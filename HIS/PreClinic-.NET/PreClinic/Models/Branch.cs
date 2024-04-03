using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PreClinic.Models;
using System.ComponentModel.DataAnnotations;

namespace PreClinic.Services
{
    [Index(nameof(branchNameE), IsUnique = true), ProducesResponseType(404)]
    [Index(nameof(branchNameA), IsUnique = true), ProducesResponseType(404)]

    public class Branch
    {
        [Key]
        public int branchId { get; set; }

        [Required(ErrorMessage = "Branch Name is required.")]
        public string? branchNameE { get; set; }

        [Required(ErrorMessage = "Branch Name is required.")]
        public string? branchNameA { get; set; }
        public ICollection<DepartmentBranches>? DepartmentBranches { get; set; }
        public ICollection<DoctorBranches>? DoctorBranches { get; set; }
    }
}
