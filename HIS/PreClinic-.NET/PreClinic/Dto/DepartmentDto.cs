using System.ComponentModel.DataAnnotations;

namespace PreClinic.Dto
{
    public class DepartmentDto
    {
        public int? departmentId { get; set; }

        [Required(ErrorMessage = "Department Name is required.")]
        public string? departmentNameE { get; set; }

        [Required(ErrorMessage = "Department Name is required.")]
        public string? departmentNameA { get; set; }
    }
}
