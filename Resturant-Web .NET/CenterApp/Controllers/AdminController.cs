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
    [Route("Admin")]
    [ApiController]
    [EnableCors("AllowOrigin")]
    public class AdminController : Controller
    {
        private readonly AdminService _adminService;
        private readonly IMapper _mapper;
        private readonly TokenService _tokenService;

        public AdminController(AdminService adminService, IMapper mapper, TokenService tokenService)
        {
            _adminService = adminService;
            _mapper = mapper;
            _tokenService = tokenService;
        }
        [HttpPost("addNewAdmin")]
        public async Task<IActionResult> newAdmin([FromQuery] AdminDto admin)
        {
            try
            {
                var mapp = _mapper.Map<Admin>(admin);
                if (await _adminService.newAdmin(mapp))
                {
                    return Ok("New Admin Added Succefully");
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
        [HttpPost("loginAdmin")]
        public async Task<IActionResult> LoginUser([FromForm] AdminLogIn admin)
        {
            try
            {
                var mappingadmin = _mapper.Map<AdminLogIn>(admin);
                var adminservices = await _adminService.loginAdmin(mappingadmin.Name, mappingadmin.Password);

                if (adminservices.Item1)
                {
                    var token = _tokenService.GenerateJwtTokenAdmin(adminservices.Item2);

                    return Ok(new { Status = 200, Token = token });
                }
            }
            catch (Exception ex)
            {

                return StatusCode(500, ex.Message);
            }
            return BadRequest("Invalid username or password");
        }
        [HttpPost("editCustomerDetails")]
        [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme, Roles = "Admin")]
        public async Task<IActionResult> editUser([FromForm] CustomerDto Customer)
        {
            try
            {
                var mappingCustomer = _mapper.Map<Customer>(Customer);
                if (await _adminService.editCustomerDetails(mappingCustomer))
                {
                    return Ok("Updated Succefully");
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

    }
}
