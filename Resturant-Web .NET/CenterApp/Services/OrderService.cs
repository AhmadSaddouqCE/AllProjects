using CenterApp.AppDto;
using CenterApp.Data;
using CenterApp.Models;
using Microsoft.EntityFrameworkCore;

namespace CenterApp.Services
{
    public class OrderService
    {
        private readonly DataContext _context;

        public OrderService(DataContext context)
        {
            _context = context;
        }
        public async Task<List<CustomerOrderDto>> getCustomerOrder(int? customerId)
        {
            var getOrderId = await _context
                .Orders
                .Where(o => o.Customer.CustomerId == customerId)
                .FirstOrDefaultAsync();
            if (getOrderId == null)
            {
                throw new Exception("No Order Found");
            }
            var getProductId = await _context
                .OrderDetails
                .Where(i => i.orderId == getOrderId.OrderId)
                .FirstOrDefaultAsync();
            if (getProductId == null)
            {
                throw new Exception("No Product Found");

            }
            return await _context.Orders
                .Include(o => o.Customer)
                .Where(o => o.Customer.CustomerId == customerId)
                .Select(o => new CustomerOrderDto
                {
                    OrderId = o.OrderId,
                    productId = getProductId.productId,
                    customerId = customerId

                })
                .ToListAsync();
        }
        public async Task<List<CustomerOrderProductDto>> getCustomerProdcutCustomerById(int? customerId)
        {
            var getCustomer = await _context.Orders
                             .Include(o => o.Customer)
                             .Where(c => c.Customer.CustomerId == customerId).ToListAsync();
            var customerOrderProductDtos = new List<CustomerOrderProductDto>();
            foreach (var customerOrder in getCustomer)
            {
                var orderDetails = await _context
                    .OrderDetails
                    .Where(od => od.orderId == customerOrder.OrderId)
                    .ToListAsync();


                foreach (var orderDetail in orderDetails)
                {
                    var product = await _context
                        .Products
                        .FirstOrDefaultAsync(p => p.ProductId == orderDetail.productId);

                    if (product == null)
                    {
                        throw new Exception($"No Product Found for ProductId: {orderDetail.productId}");
                    }
                    var customerOrderProductDto = new CustomerOrderProductDto
                    {
                        OrderId = customerOrder.OrderId,
                        CustomerId = customerOrder.Customer.CustomerId,
                        CustomerName = customerOrder.Customer.Name,
                        ProductId = product.ProductId,
                        ProductName = product.Name,
                        Price = product.Price,
                        Quantitiy = orderDetail.Quantity,
                        categoryId = product.categoryId,
                        totalPrice = orderDetail.totalPrice,
                        orderDate = customerOrder.OrderDate,
                        orderStatus = customerOrder.Status,
                        Address = customerOrder.Customer.Address,
                        City = customerOrder.Customer.City,
                    };

                    customerOrderProductDtos.Add(customerOrderProductDto);

                }
            }

            return customerOrderProductDtos;
        }

        public async Task<bool> DeleteOrder(int orderId)
        {
            var getOrderId = await _context
                .Orders
                .Where(id => id.OrderId == orderId)
                .FirstOrDefaultAsync();
            if (getOrderId == null)
            {
                throw new Exception("This Order Doesn't Exist");
            }
            _context.Orders.Remove(getOrderId);
            var getProductId = await _context
                .OrderDetails
                .Where(id => id.orderId == orderId)
                .ToListAsync();
            foreach (var item in getProductId)
            {
                var productId = await _context
                    .Products
                    .Where(id => id.ProductId == item.productId)
                    .FirstOrDefaultAsync();
                if (productId == null)
                {
                    throw new Exception("This Product Doesn't Exist");
                }
                productId.Quantity += item.Quantity;
                _context.OrderDetails.Remove(item);
            }

            return await Save();
        }
        public async Task<List<CustomerOrderProductDto>> getOrderDetailsById(int orderId, int? customerId)
        {

            var orderDetails = await _context.OrderDetails
            .Include(od => od.Order.Customer)
            .Include(od => od.Product)
            .Where(od => od.orderId == orderId && od.Order.Customer.CustomerId == customerId)
            .ToListAsync();

            if (!orderDetails.Any())
            {
                throw new Exception($"No order details found for OrderId: {orderId} and CustomerId: {customerId}");
            }

            var customerOrderProductDtos = orderDetails.Select(od => new CustomerOrderProductDto
            {
                OrderId = od.orderId,
                CustomerId = od.Order.Customer.CustomerId,
                CustomerName = od.Order.Customer.Name,
                ProductId = od.productId,
                ProductName = od.Product.Name,
                Quantitiy = od.Quantity,
                categoryId = od.Product.categoryId,
                totalPrice = od.totalPrice,
                orderDate = od.Order.OrderDate,
                orderStatus = od.Order.Status,
            }).ToList();

            return customerOrderProductDtos;


        }
        public async Task<ICollection<CustomerOrderProductDto>> getOrderProductOwnerById(int? customerId)
        {
            var orders = await _context.Orders
                .Where(o => o.Customer.CustomerId == customerId)
                .SelectMany(o => o.OrderDetail)
                .Select(od => new CustomerOrderProductDto
                {
                    CustomerId = customerId,
                    OrderId = od.orderId,
                    ProductId = od.Product.ProductId,
                    ProductName = od.Product.Name,
                    CustomerName = od.Order.Customer.Name

                })
                .ToListAsync();

            return orders;
        }
        public async Task<List<CustomerOrderProductDto>> getOrderProductCustomer()
        {
            var data = await _context.Orders
                .SelectMany(o => o.OrderDetail)
                .Select(od => new CustomerOrderProductDto
                {
                    CustomerId = od.Order.Customer.CustomerId,
                    CustomerName = od.Order.Customer.Name,
                    OrderId = od.Order.OrderId,
                    ProductId = od.Product.ProductId,
                    ProductName = od.Product.Name
                }).ToListAsync();
            return data;
        }
        public async Task<bool> DeleteProductFromOrder(int customerId, int orderId, int productId)
        {
            var checkCustomer = await _context.Customers
                .Where(id => id.CustomerId == customerId)
                .FirstOrDefaultAsync();
            if (checkCustomer is null) throw new Exception("This Customer Doens't Exist");
            var checkUserOwnOrder = await _context.Orders
            .Include(o => o.Customer)
            .Where(order => order.OrderId == orderId && order.Customer.CustomerId == customerId)
            .FirstOrDefaultAsync();
            if (checkUserOwnOrder == null) throw new Exception("This Order Doesn't Exist");
            var getProduct = await _context.Products.Where(id => id.ProductId == productId).FirstOrDefaultAsync();
            if (getProduct == null) throw new Exception("This Product Doesn't Exist");
            var deleteProduct = await _context.OrderDetails.Where(id => id.orderId == orderId && id.productId == productId).FirstOrDefaultAsync();
            if (deleteProduct == null) throw new Exception("This Product Doesn't Exist In This Order");
            var getQuantity = deleteProduct.Quantity;
            var addQuantityToProduct = getProduct.Quantity + getQuantity;
            getProduct.Quantity = addQuantityToProduct;
            _context.OrderDetails.Remove(deleteProduct);
            return await Save();
        }
        public async Task<bool> modifyProductToTheCart(Orders order, int customerId, int? productId, int Quantity)
        {
            var getOrder = await _context.Orders
                .Where(id => id.OrderId == order.OrderId)
                .FirstOrDefaultAsync();
            if (getOrder == null) throw new Exception("This Order Doesn't Exist");
            var getProduct = await _context.Products.Where(p => p.ProductId == productId).FirstOrDefaultAsync();
            if (getProduct == null) throw new Exception("This Prdouct Doesn't Exist");
            var getOrderIdOrderDetails = await _context.OrderDetails.Where(id => id.orderId == order.OrderId &&
            id.productId == productId).
            FirstOrDefaultAsync();
            if (getOrderIdOrderDetails == null)
            {
                var newOrderDetails = new OrderDetails()
                {
                    orderId = order.OrderId,
                    productId = getProduct.ProductId,
                    Quantity = Quantity,
                    totalPrice = Quantity * getProduct.Price
                };
                getProduct.Quantity -= Quantity;
                if (getProduct.Quantity < 0) throw new Exception("No Available Quantity");
                await _context.OrderDetails.AddAsync(newOrderDetails);
            }
            else
            {
                var getOrderQuantity = getOrderIdOrderDetails.Quantity;
                var getProductPrice = getProduct.Price;
                var ChangeQuantity = getProduct.Quantity + getOrderQuantity - Quantity;
                if (ChangeQuantity < 0) throw new Exception("No Available Quantity");
                getProduct.Quantity = ChangeQuantity;
                getOrderIdOrderDetails.Quantity = Quantity;
                getOrderIdOrderDetails.totalPrice = Quantity * getProductPrice;
            }
            return await Save();
        }
        public async Task<bool> addOrders(int customerId)
        {
            var getCustomer = await _context
                .Customers
                .FindAsync(customerId);
            if (getCustomer == null)
            {
                throw new Exception("No User Found");
            }
            var getCustomerCart = await _context
                .Carts
                .Where(id => id.CustomerId == customerId)
                .ToListAsync();
            if (getCustomerCart.Count == 0)
            {
                throw new Exception("No Carts Available");
            }

            var addToOrder = new Orders()
            {
                OrderDate = DateTime.Now,
                Status = "Pending",
                CreatedAt = DateTime.Now,
                UpdatedAt = DateTime.Now,
                Customer = getCustomer,

            };
            await _context.Orders.AddAsync(addToOrder);
            await Save();
            foreach (var cart in getCustomerCart)
            {
                var getProduct = await _context
                    .Products
                    .FindAsync(cart.ProductId);
                var getCartsProducts = await _context
                    .CartProducts
                    .Where(id => id.ProductId == cart.ProductId)
                    .FirstOrDefaultAsync();
                if (getProduct == null || getCartsProducts == null)
                {
                    throw new Exception("This Product Doesn't Exist");
                }
                var orderdetails = new OrderDetails()
                {
                    orderId = addToOrder.OrderId,
                    productId = cart.ProductId,
                    totalPrice = cart.TotalPrice,
                    Quantity = cart.Quantity,
                    Product = getProduct,
                    Order = addToOrder
                };
                _context.CartProducts.RemoveRange(getCartsProducts);
                _context.Carts.RemoveRange(cart);
                await _context.OrderDetails.AddAsync(orderdetails);
            }

            return await Save();
        }
        public async Task<bool> addOrder(Orders order, int? customerId, int productId, int quantity, decimal price)
        {
            var existingCustomer = await _context
                .Customers
                .FindAsync(customerId);
            var existingProduct = await _context
                .Products
                .FindAsync(productId);
            if (existingCustomer == null || existingProduct == null)
            {
                return false;
            }
            var saveQuantity = existingProduct.Quantity;
            var remain = saveQuantity - quantity;
            if (remain < 0)
            {
                throw new Exception("Your Ordered Quantity is not available.");
            }
            var newOrder = new Orders()
            {
                OrderDate = DateTime.Now,
                Status = "Processing",
                CreatedAt = DateTime.Now,
                Customer = existingCustomer
            };
            var newOrderDetails = new OrderDetails()
            {
                orderId = newOrder.OrderId,
                productId = productId,
                Quantity = quantity,
                totalPrice = price * quantity,
                Order = newOrder,
                Product = existingProduct,

            };

            existingProduct.Quantity = remain;
            await _context.Orders.AddAsync(newOrder);
            await _context.OrderDetails.AddAsync(newOrderDetails);
            return await Save();
        }
        /* public async Task<bool> editOrder(Orders order,int orderId, int customerId, int productId)
         {
             var getOrder = await _context.Orders.FindAsync(orderId);
             if(getOrder == null)
             {
                 throw new Exception("This Order Doesn't Exists");
             }
             getOrder.OrderDate = order.OrderDate;
             getOrder.Status = order.Status;
             getOrder.TotalAmount = order.TotalAmount;

         } */
        public async Task<bool> Save()
        {
            var saved = await _context.SaveChangesAsync();
            return saved > 0 ? true : false;
        }
    }
}
