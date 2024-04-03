using System.ComponentModel.DataAnnotations;

namespace PreClinic.Dto
{
    public class BranchDto
    {
        public int? branchId { get; set; }

        [Required(ErrorMessage = "Branch Name is required.")]
        public string? branchNameE { get; set; }

        [Required(ErrorMessage = "Branch Name is required.")]
        public string? branchNameA { get; set; }
    }
}
