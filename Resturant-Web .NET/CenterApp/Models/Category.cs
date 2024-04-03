using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CenterApp.Models
{
    [Index(nameof(categoryName), IsUnique = true), ProducesResponseType(404)]
    public class Category
    {
        [Key]
        public int categoryId { get; set; }
        public string? categoryName { get; set; }
        [NotMapped]
        public IFormFile? CategoryImage { get; set; }
        public string? ImageUrl { get; set; }
        public DateTime CreatedAt { get; set; }
        public DateTime UpdatedAt { get; set; }
        public ICollection<Product>? Products { get; set; }


    }
}
