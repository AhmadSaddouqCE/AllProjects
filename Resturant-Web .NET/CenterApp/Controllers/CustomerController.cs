using AutoMapper;
using CenterApp.AppDto;
using CenterApp.Models;
using CenterApp.Services;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Cors;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;

namespace CenterApp.Controllers
{
    [Route("Customer")]
    [ApiController]
    [EnableCors("AllowOrigin")]
    public class CustomerController : Controller
    {
        private readonly CustomerServices _CustomerServices;
        private readonly IMapper _mapper;
        private readonly TokenService _tokenService;

        public CustomerController(CustomerServices customerServices, TokenService tokenService, IMapper mapper, IConfiguration configuration)
        {
            _CustomerServices = customerServices;
            _mapper = mapper;
            _tokenService = tokenService;
        }
        [HttpGet("getUserById")]
        public async Task<IActionResult> getUserById()
        {
            var userId = HttpContext.User.Claims.FirstOrDefault(c => c.Type ==
               "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/CustomerId")
                   ?.Value;
            if (int.TryParse(userId, out int customerId))
            {
                var user = await _CustomerServices.getUserById(customerId);
                return Ok(user);
            }
            return StatusCode(500, "Something Wrong Happened");
        }
        [HttpPost("editCustomerPassword")]
        [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme, Roles = "Customer")]
        public async Task<IActionResult> editCustomerPassword([FromForm] CustomerPasswordDto customer)
        {
            try
            {
                var userId = HttpContext.User.Claims.FirstOrDefault(c => c.Type ==
                "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/CustomerId")
                      ?.Value;
                if (int.TryParse(userId, out int customerId))
                {
                    var updateCustomer = await _CustomerServices.editCustomerPassword(customerId, customer.Password, customer.newPassword);
                    return Ok("Password Updated Succefully");
                }

            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
            return BadRequest("Invalid Connection");
        }

        [HttpPost("editCustomer_noPassword")]
        [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme, Roles = "Customer")]
        public async Task<IActionResult> editCustomer_noPassword([FromForm] CustomerDto customer)
        {
            try
            {
                var userId = HttpContext.User.Claims.FirstOrDefault(c => c.Type ==
                "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/CustomerId")
                      ?.Value;
                if (int.TryParse(userId, out int customerId))
                {
                    var mapping = _mapper.Map<Customer>(customer);
                    var updateCustomer = await _CustomerServices.editUser_NoPassword(customerId, mapping);
                    return Ok("Updated Succefully");
                }

            }
            catch (Exception ex)
            {
                if (ex.InnerException != null) return StatusCode(500, ex.InnerException.Message);
            }
            return BadRequest("Invalid User");
        }
        [HttpPost("editCustomer")]
        [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme, Roles = "Customer")]

        public async Task<IActionResult> editUser([FromForm] CustomerDto Customer)
        {
            try
            {
                var mappingCustomer = _mapper.Map<Customer>(Customer);
                var updatecustomer = await _CustomerServices.editUser(Customer.customerId, mappingCustomer);
                if (updatecustomer.Item1)
                {
                    return Ok(new { message = "Updated Succefully", updatecustomer.Item2 });
                }
            }
            catch (Exception ex)
            {
                string errorMessage = "An error occurred.";
                if (ex.InnerException != null)
                {
                    if (ex.InnerException.Message.Contains("Name"))
                    {
                        errorMessage = "This name already exists";
                    }
                    else if (ex.InnerException.Message.Contains("Email"))
                    {
                        errorMessage = "This email already exists";
                    }
                    else if (ex.InnerException.Message.Contains("Phone"))
                    {
                        errorMessage = "This Phone already exists";
                    }

                    else
                    {
                        errorMessage += " Inner Exception: " + ex.InnerException.Message;
                    }
                }

                return StatusCode(500, errorMessage);
            }
            return BadRequest("Something Went Wrong");
        }

        [HttpPost("loginUser")]
        public async Task<IActionResult> LoginUser([FromBody] CustomerLoginDto customer)
        {
            try
            {
                var mappingcustomer = _mapper.Map<CustomerLoginDto>(customer);
                var customerservices = await _CustomerServices.loginUser(mappingcustomer.Name, mappingcustomer.Password);

                if (customerservices.Item1)
                {
                    var token = _tokenService.GenerateJwtToken(customerservices.Item2);

                    return Ok(new { Status = 200, Token = token });
                }
            }
            catch (Exception ex)
            {

                return StatusCode(500, ex.Message);
            }
            return BadRequest("Invalid username or password");
        }

        [HttpGet("getAllUsers")]
        [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme, Roles = "Admin")]
        public async Task<IActionResult> getUsers()
        {
            try
            {
                var getAll = await _CustomerServices.getAllUsers();
                if (getAll.Count == 0)
                {
                    return BadRequest("No Users Found");

                }
                return Ok(getAll);
            }
            catch (SqlException ex)
            {
                if (ex.InnerException != null)
                {
                    return StatusCode(500, ex.InnerException.Message);
                }
            }
            return BadRequest("An Error Happened While Finishing The Operation");

        }
        [HttpPost("SearchForElement")]
        public async Task<IActionResult> Search([FromQuery] string Name)
        {
            try
            {
                if (Name == null)
                {
                    throw new Exception("Name Not Found");
                }
                return Ok(await _CustomerServices.getBySearch(Name));
            }
            catch (Exception e)
            {
                if (e.Message != null)
                {
                    return StatusCode(404, e.Message);
                }
            }
            return NoContent();
        }
        [HttpGet("Pagination")]
        public async Task<IActionResult> GetPages(int page = 1, int pageSize = 10)
        {
            List<Customer> userList = await _CustomerServices.getAllUsers();
            int totalCount = userList.Count;
            int totalPages = (int)Math.Ceiling((decimal)totalCount / pageSize);
            var customersPerPage = userList
                .Skip(page - 1)
                .Take(pageSize)
                .ToList();

            return Ok(customersPerPage);
        }

        [HttpPost("newCustomer")]
        public async Task<IActionResult> addCustomer([FromForm] CustomerDto customer)
        {
            try
            {
                var CustomerMapping = _mapper.Map<Customer>(customer);
                if (await _CustomerServices.newCustomer(CustomerMapping))
                {
                    return Ok("Created");

                }

            }
            catch (Exception ex)
            {
                string errorMessage = "An error occurred.";
                if (ex.InnerException != null)
                {
                    if (ex.InnerException.Message.Contains("Name"))
                    {
                        errorMessage = "This name already exists";
                    }
                    else if (ex.InnerException.Message.Contains("Email"))
                    {
                        errorMessage = "This email already exists";
                    }
                    else if (ex.InnerException.Message.Contains("Phone"))
                    {
                        errorMessage = "This Phone already exists";
                    }
                    else
                    {
                        errorMessage += " Inner Exception: " + ex.InnerException.Message;
                    }
                }

                return StatusCode(500, errorMessage);
            }
            return BadRequest("Something Wrong Happened");


        }
        [HttpPost("Files")]

        public Task UploadFile(IFormFile file)
        {
            return Task.CompletedTask;
        }

    }
}
