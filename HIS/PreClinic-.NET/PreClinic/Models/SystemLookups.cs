using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations;

namespace PreClinic.Services
{
    [Index(nameof(lookupNameA), IsUnique = true), ProducesResponseType(404)]
    [Index(nameof(lookupNameE), IsUnique = true), ProducesResponseType(404)]

    public class SystemLookups
    {
        [Key]
        public int LookupId { get; set; }
        public int? categoryId { get; set; }
        public SystemLookupsCategory? Category { get; set; }

        [Required(ErrorMessage = "Lookup Name is required.")]
        public string? lookupNameE { get; set; }

        [Required(ErrorMessage = "Lookup Name is required.")]
        public string? lookupNameA { get; set; }
    }
}
