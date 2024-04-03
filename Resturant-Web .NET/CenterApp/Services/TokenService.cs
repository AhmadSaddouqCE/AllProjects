using CenterApp.Models;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

public class TokenService
{
    private readonly IConfiguration _configuration;

    public TokenService(IConfiguration configuration)
    {
        _configuration = configuration;
    }

    public string GenerateJwtToken(Customer customer)
    {
        var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_configuration["Jwt:Key"]));
        var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

        var claims = new[]
        {   new Claim("http://schemas.xmlsoap.org/ws/2005/05/identity/claims/CustomerId", customer.CustomerId.ToString()),
            new Claim(ClaimTypes.Name, customer.Name),
            new Claim(ClaimTypes.Email, customer.Email),
            new Claim(ClaimTypes.HomePhone, customer.Phone),
            new Claim(ClaimTypes.DateOfBirth, customer.DateOfBirth.ToString("yyyy-MM-dd"), ClaimValueTypes.Date),
            new Claim(ClaimTypes.StreetAddress, customer.Address),
            new Claim(ClaimTypes.Country, customer.Country),
            new Claim(ClaimTypes.Locality, customer.City),
            new Claim(ClaimTypes.Role, customer.Role),
        };
        var token = new JwtSecurityToken(
            issuer: _configuration["Jwt:Issuer"],
            audience: _configuration["Jwt:Audience"],
            claims: claims,
            expires: DateTime.UtcNow.AddDays(7),
            signingCredentials: creds);

        return new JwtSecurityTokenHandler().WriteToken(token);
    }
    public string GenerateJwtTokenAdmin(Admin admin)
    {
        var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_configuration["Jwt:Key"]));
        var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);
        var claims = new[]
        {   new Claim("http://schemas.xmlsoap.org/ws/2005/05/identity/claims/AdminId", admin.AdminId.ToString()),
            new Claim(ClaimTypes.Name, admin.Name),
            new Claim(ClaimTypes.Email, admin.Email),
            new Claim(ClaimTypes.MobilePhone, admin.PhoneNumber.ToString()),
            new Claim(ClaimTypes.StreetAddress, admin.Address),
            new Claim(ClaimTypes.Role, admin.Role),
        };
        var token = new JwtSecurityToken(
            issuer: _configuration["Jwt:Issuer"],
            audience: _configuration["Jwt:Audience"],
            claims: claims,
            expires: DateTime.UtcNow.AddDays(7),
            signingCredentials: creds);
        return new JwtSecurityTokenHandler().WriteToken(token);
    }
}
