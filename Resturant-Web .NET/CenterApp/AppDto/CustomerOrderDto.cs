namespace CenterApp.AppDto
{
    public class CustomerOrderDto
    {
        public int? OrderId { get; set; }
        public int Quantity { get; set; }
        public decimal Price { get; set; }
        public int? customerId { get; set; }
        public int? productId { get; set; }
    }
}
