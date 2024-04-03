namespace CenterApp.AppDto
{
    public class CustomerOrderProductDto
    {
        public int? CustomerId { get; set; }
        public string? CustomerName { get; set; }
        public int? Quantitiy { get; set; }
        public int? OrderId { get; set; }
        public int? ProductId { get; set; }
        public decimal? Price { get; set; }
        public decimal? totalPrice { get; set; }
        public string? ProductName { get; set; }
        public string? Address { get; set; }
        public string? City { get; set; }
        public int? categoryId { get; set; }
        public DateTime? orderDate { get; set; }
        public string? orderStatus { get; set; }
    }
}
