using AutoMapper;
using CenterApp.AppDto;
using CenterApp.Models;
using CenterApp.Services;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Cors;
using Microsoft.AspNetCore.Mvc;

namespace CenterApp.Controllers
{
    [Route("Order")]
    [ApiController]
    [EnableCors("AllowOrigin")]
    public class OrderController : Controller
    {
        private readonly OrderService _orderServices;
        private readonly IMapper _mapper;
        public OrderController(OrderService orderServices, IMapper mapper)
        {
            _orderServices = orderServices;
            _mapper = mapper;
        }
        [HttpPost("AddOrder")]
        [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme, Roles = "Customer")]
        public async Task<IActionResult> addOrders()
        {
            try
            {
                var userId = HttpContext.User.Claims.FirstOrDefault(c => c.Type ==
                "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/CustomerId")
                      ?.Value;
                if (int.TryParse(userId, out int customerId))
                {
                    var addTheOrder = await _orderServices.addOrders(customerId);
                    return Ok("Order Added Succefully");
                }

            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.InnerException);
            }
            return BadRequest("Invalid User");

        }

        [HttpGet("getOrderProductCustomerById")]
        [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme, Roles = "Customer")]
        public async Task<IActionResult> getOrderProductCustomerById()
        {
            try
            {
                var userId = HttpContext.User.Claims.FirstOrDefault(c => c.Type == "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/CustomerId")?.Value;
                if (int.TryParse(userId, out int customerId))
                {
                    var getData = await _orderServices.getOrderProductOwnerById(customerId);
                    return Ok(getData);
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
            return BadRequest("Invalid User");

        }

        [HttpGet("getCustomerOrderProduct")]
        public async Task<IActionResult> getCustomerOrderProduct()
        {
            try
            {
                var getData = await _orderServices.getOrderProductCustomer();
                if (getData.Count == 0)
                {
                    return BadRequest("No Orders Found");
                }
                return Ok(getData);
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
        }
        [HttpGet("getCustomerOrders")]
        public async Task<IActionResult> getCustomerOrders([FromQuery] int customerId)
        {
            try
            {
                if (customerId == 0)
                {
                    return BadRequest("Something wrong happened");

                }

                return Ok(await _orderServices.getCustomerOrder(customerId));
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
        }
        [HttpPost("deleteProductFromOrder")]
        [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme, Roles = "Customer")]
        public async Task<IActionResult> deleteProductFromOrder([FromForm] deleteProductFromOrderDto orderProduct)
        {
            try
            {
                var userId = HttpContext.User.Claims.FirstOrDefault(c => c.Type == "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/CustomerId")?.Value;
                if (int.TryParse(userId, out int id))
                {
                    if (await _orderServices.DeleteProductFromOrder(id, orderProduct.orderId, orderProduct.productId))
                    {
                        return Ok("Deleted Succefully");
                    }
                }
            }
            catch (Exception e)
            {
                return StatusCode(500, e.Message);
            }
            return StatusCode(500, "Something Wrong Happened");
        }
        [HttpDelete("DeleteOrder/{OrderId}")]
        [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme, Roles = "Customer")]
        public async Task<IActionResult> deleteCustomerOrder(int orderId)
        {
            try
            {
                var userId = HttpContext.User.Claims.FirstOrDefault(c => c.Type == "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/CustomerId")?.Value;
                if (int.TryParse(userId, out int id))
                {
                    var deleteOrder = await _orderServices.DeleteOrder(orderId);
                    return Ok("Deleted Succefully");
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);

            }
            return BadRequest("Something Wrong Happened");
        }
        [HttpPost("modifyNewProductToTheCart")]
        [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme, Roles = "Customer")]
        public async Task<IActionResult> modifyProductsInTheOrderList([FromForm] addProductsToCart order)
        {
            try
            {
                var userId = HttpContext.User.Claims.FirstOrDefault(c => c.Type == "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/CustomerId")?.Value;
                if (int.TryParse(userId, out int customerId))
                {
                    var mapping = _mapper.Map<Orders>(order);
                    var orderDetails = await _orderServices.modifyProductToTheCart(mapping, customerId, order.productId, order.selectedQuantity);
                    return Ok("New Product Added To Cart");

                }
            }
            catch (Exception e)
            {
                return StatusCode(500, e.Message);
            }
            return BadRequest("Something Wrong Happened");
        }
        [HttpPost("getOrderDetailsById")]
        [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme, Roles = "Customer")]
        public async Task<IActionResult> getOrderDetailsById([FromBody] int orderId)
        {
            try
            {
                var userId = HttpContext.User.Claims.FirstOrDefault(c => c.Type == "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/CustomerId")?.Value;
                if (int.TryParse(userId, out int customerId))
                {
                    var orderDetails = await _orderServices.getOrderDetailsById(orderId, customerId);
                    return Ok(orderDetails);

                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
            return BadRequest("No Customer Found");

        }
        [HttpGet("GetOrderDetails")]
        [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme, Roles = "Customer")]
        public async Task<IActionResult> getOrderDetails()
        {
            try
            {
                var userId = HttpContext.User.Claims.FirstOrDefault(c => c.Type == "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/CustomerId")?.Value;

                if (int.TryParse(userId, out int customerId))
                {
                    var orderDetails = await _orderServices.getCustomerProdcutCustomerById(customerId);
                    return Ok(orderDetails);

                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }


            return BadRequest("No Customer Found");
        }


    }
}
