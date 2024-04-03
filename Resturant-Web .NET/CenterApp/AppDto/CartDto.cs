namespace CenterApp.AppDto
{
    public class CartDto
    {
        public int CartId { get; set; }
        public int? CustomerId { get; set; }
        public int? ProductId { get; set; }
        public int? Quantity { get; set; }
        public decimal? Price { get; set; }
        public decimal? TotalPrice { get; set; }
        public string? ImageUrl { get; set; }


    }
}
