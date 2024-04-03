using System.ComponentModel.DataAnnotations;

namespace CenterApp.Models
{
    public class ShoppingCart
    {
        [Key]
        public int ShoppingCartId { get; set; }
        public int? CustomerId { get; set; }
        public int? ProductId { get; set; }
        public Product? Product { get; set; }

        public int? Quantity { get; set; }
        public int? Price { get; set; }
        public ICollection<CartProducts>? CartProducts { get; set; }
        public Customer? Customer { get; set; }
        public string? imageUrl { get; set; }
        public decimal? TotalPrice { get; set; }
    }
}
