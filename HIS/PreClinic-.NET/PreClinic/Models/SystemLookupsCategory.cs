using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations;

namespace PreClinic.Services
{
    [Index(nameof(categoryCode), IsUnique = true), ProducesResponseType(404)]
    [Index(nameof(categoryNameE), IsUnique = true), ProducesResponseType(404)]
    [Index(nameof(categoryNameA), IsUnique = true), ProducesResponseType(404)]
    public class SystemLookupsCategory
    {
        [Key]
        public int CategoryId { get; set; }

        [Required(ErrorMessage = "Category Code is required.")]
        public string? categoryCode { get; set; }

        [Required(ErrorMessage = "Category Name is required.")]
        public string? categoryNameE { get; set; }

        [Required(ErrorMessage = "Category Name is required.")]

        public string? categoryNameA { get; set; }
        public ICollection<SystemLookups>? SystemLookups { get; set; }
    }
}
