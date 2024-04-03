using System.ComponentModel.DataAnnotations;

namespace PreClinic.Dto
{
    public class SystemlookupsCategoryDto
    {
        public int? CategoryId { get; set; }

        [Required(ErrorMessage = "Category Code is required.")]
        public string? categoryCode { get; set; }

        [Required(ErrorMessage = "Category Name is required.")]
        public string? categoryNameE { get; set; }

        [Required(ErrorMessage = "Category Name is required.")]

        public string? categoryNameA { get; set; }
    }
}
