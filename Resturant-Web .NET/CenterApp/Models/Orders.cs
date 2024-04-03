using System.ComponentModel.DataAnnotations;

namespace CenterApp.Models
{
    public class Orders
    {
        [Key]
        public int OrderId { get; set; }
        public DateTime? OrderDate { get; set; }
        public string? Status { get; set; }
        public ICollection<OrderDetails>? OrderDetail { get; set; }
        public int? customerId { get; set; }
        public Customer? Customer { get; set; }
        public DateTime CreatedAt { get; set; }
        public DateTime UpdatedAt { get; set; }
    }
}
