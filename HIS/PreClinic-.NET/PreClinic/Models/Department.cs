using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PreClinic.Models;
using System.ComponentModel.DataAnnotations;

namespace PreClinic.Services
{
    [Index(nameof(departmentNameE), IsUnique = true), ProducesResponseType(404)]
    [Index(nameof(departmentNameA), IsUnique = true), ProducesResponseType(404)]
    public class Department
    {
        [Key]
        public int departmentId { get; set; }

        [Required(ErrorMessage = "Department Name is required.")]
        public string? departmentNameE { get; set; }

        [Required(ErrorMessage = "Department Name is required.")]
        public string? departmentNameA { get; set; }
        public ICollection<DepartmentBranches>? DepartmentBranches { get; set; }
        public ICollection<DoctorDepartment>? DoctorDepartments { get; set; }

    }
}
