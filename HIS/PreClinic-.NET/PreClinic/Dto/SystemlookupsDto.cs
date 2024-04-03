using System.ComponentModel.DataAnnotations;

namespace PreClinic.Dto
{
    public class SystemlookupsDto
    {
        public int? LookupId { get; set; }
        public int? categoryId { get; set; }

        [Required(ErrorMessage = "Lookup Name is required.")]

        public string? lookupNameE { get; set; }

        [Required(ErrorMessage = "Lookup Name is required.")]
        public string? lookupNameA { get; set; }
    }
}
