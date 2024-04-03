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
    [Route("Cart")]
    [ApiController]
    [EnableCors("AllowOrigin")]
    public class CartController : Controller
    {
        private readonly CartServices _cartServices;
        private readonly IMapper _mapper;

        public CartController(CartServices cartServices, IMapper mapper)
        {
            _cartServices = cartServices;
            _mapper = mapper;
        }

        [HttpPost("newCart")]
        public async Task<IActionResult> addNewCart([FromForm] CartDto cart)
        {
            try
            {
                var mappingcart = _mapper.Map<ShoppingCart>(cart);
                if (await _cartServices.newCart(mappingcart, mappingcart.ProductId,
                    mappingcart.CustomerId,
                    mappingcart.Quantity,
                    mappingcart.Price,
                    mappingcart.imageUrl))
                {
                    return Ok("New Cart Added Succefully");
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }

            return StatusCode(500, "Something Error Happened While Adding New Cart");

        }
        [HttpDelete("DeleteFromCart/{customerCartId}")]
        [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme, Roles = "Customer")]
        public async Task<IActionResult> DeleteCart(int customerCartId)
        {
            try
            {
                var userId = HttpContext.User.Claims.FirstOrDefault(c => c.Type == "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/CustomerId")?.Value;
                if (int.TryParse(userId, out int id))
                {
                    var deleteCart = await _cartServices.DeleteFromCartByCartId(customerCartId);
                    return Ok("Deleted Succefully");
                }


            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
            return BadRequest("An Error Happened");

        }
        [HttpPost("editCartQuantity")]
        [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme, Roles = "Customer")]
        public async Task<IActionResult> editCartQuantity([FromForm] EditCartDto cart)
        {
            try
            {

                if (cart.Quantity <= 0 || cart.cartId <= 0)
                {
                    throw new Exception("Invalid Quantity");
                }
                if (await _cartServices.editCartQuantity(cart.cartId, cart.Quantity))
                {
                    return Ok("Edited Succefully");
                }

            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
            return StatusCode(500, "Something wrong Happened");

        }
        [HttpGet("getUserCarts")]
        [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme, Roles = "Customer")]

        public async Task<IActionResult> getCarts()
        {
            try
            {
                var userId = HttpContext.User.Claims.FirstOrDefault(c => c.Type == "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/CustomerId")?.Value;

                if (int.TryParse(userId, out int customerId))
                {
                    var getUserCarts = await _cartServices.getUserCartsById(customerId);
                    return Ok(getUserCarts);
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
            return BadRequest("Invalid User");

        }
    }
}
