namespace CenterApp.Models
{
    public class OrderDetails
    {

        public int orderId { get; set; }
        public int? productId { get; set; }
        public decimal? totalPrice { get; set; }
        public int? Quantity { get; set; }
        public Orders? Order { get; set; }
        public Product? Product { get; set; }

    }
}