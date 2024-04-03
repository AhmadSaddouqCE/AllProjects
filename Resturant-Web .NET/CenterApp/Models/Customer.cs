using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations;

namespace CenterApp.Models
{
    [Index(nameof(Name), IsUnique = true), ProducesResponseType(404)]
    [Index(nameof(Email), IsUnique = true), ProducesResponseType(404)]
    [Index(nameof(Phone), IsUnique = true), ProducesResponseType(404)]
    public class Customer
    {
        [Key]
        public int CustomerId { get; set; }
        public string? Name { get; set; }
        public string? Password { get; set; }

        public string? Email { get; set; }
        public string? Phone { get; set; }
        public string? Address { get; set; }
        public string? City { get; set; }
        public string Role { get; set; } = "Customer";
        public string? Country { get; set; }
        [RegularExpression(@"^\d{4}-\d{2}-\d{2}$", ErrorMessage = "Invalid Date Format. Use yyyy-mm-dd")]
        public DateTime DateOfBirth { get; set; }
        public string? PhotoPath { get; set; }
        public ICollection<ShoppingCart>? Carts { get; set; }
        public ICollection<Orders>? Orders { get; set; }
        public DateTime CreatedAt { get; set; }
        public DateTime UpdatedAt { get; set; }




    }
}
