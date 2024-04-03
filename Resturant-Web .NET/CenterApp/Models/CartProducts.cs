namespace CenterApp.Models
{
    public class CartProducts
    {
        public int? ShoppingCartId { get; set; }
        public ShoppingCart? ShoppingCart { get; set; }
        public int? ProductId { get; set; }
        public Product? Product { get; set; }
    }
}
