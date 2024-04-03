using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations;

namespace CenterApp.Models
{
    [Index(nameof(Name), IsUnique = true), ProducesResponseType(404)]
    [Index(nameof(Email), IsUnique = true), ProducesResponseType(404)]
    [Index(nameof(PhoneNumber), IsUnique = true), ProducesResponseType(404)]
    public class Admin
    {
        [Key]
        public int AdminId { get; set; }
        public string Name { get; set; }
        public string Password { get; set; }
        public string Email { get; set; }
        public int PhoneNumber { get; set; }
        public string Address { get; set; }
        public string Role { get; set; }
    }
}
