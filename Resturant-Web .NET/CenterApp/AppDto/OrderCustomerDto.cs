using Microsoft.EntityFrameworkCore.ValueGeneration.Internal;

namespace CenterApp.AppDto
{
    public class OrderCustomerDto
    {
        public int? orderId { get; set; }
        public int? customerId { get; set; }
        public string Status {  get; set; }
    }
}
