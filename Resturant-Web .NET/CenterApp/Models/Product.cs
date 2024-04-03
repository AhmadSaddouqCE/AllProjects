using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CenterApp.Models
{
    [Index(nameof(Name), IsUnique = true), ProducesResponseType(404)]

    public class Product
    {
        [Key]
        public int ProductId { get; set; }
        public string? Name { get; set; }
        [NotMapped]
        public IFormFile? ProductImage { get; set; }
        public string? ImageUrl { get; set; }
        public int? Quantity { get; set; }
        public decimal? Price { get; set; }
        public string? Description { get; set; }
        public DateTime CreatedAt { get; set; }
        public DateTime UpdatedAt { get; set; }
        public ICollection<OrderDetails>? OrderDetail { get; set; }
        public ICollection<CartProducts>? CartProducts { get; set; }
        public int? categoryId { get; set; }
        public Category? Category { get; set; }


    }
}
