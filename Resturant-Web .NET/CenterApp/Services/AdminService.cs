using CenterApp.Data;
using CenterApp.Models;
using Microsoft.EntityFrameworkCore;

namespace CenterApp.Services
{
    public class AdminService
    {
        public readonly DataContext _context;
        public AdminService(DataContext context)
        {
            _context = context;
        }
        public async Task<bool> editCustomerDetails(Customer customer)
        {
            var getUser = await _context.Customers.Where(i => i.CustomerId == customer.CustomerId).FirstOrDefaultAsync();
            if (getUser == null)
            {
                throw new Exception("This User Doesn't Exist");
            }
            var CheckUserUpdateName = getUser.Name;
            var CheckUserUpdateEmail = getUser.Email;
            var CheckUserUpdatePhone = getUser.Phone;
            string hashedPassword = BCrypt.Net.BCrypt.HashPassword(customer.Password);
            if (CheckUserUpdateName.Equals(customer.Name) &&
                CheckUserUpdateEmail.Equals(customer.Email) && CheckUserUpdatePhone.Equals(customer.Phone))
            {

                getUser.Password = hashedPassword;
                getUser.Address = customer.Address;
                getUser.City = customer.City;
                getUser.Country = customer.Country;
                getUser.DateOfBirth = customer.DateOfBirth;
                getUser.UpdatedAt = DateTime.Now;

            }
            else
            {
                getUser.Name = customer.Name;
                getUser.Email = customer.Email;
                getUser.Password = hashedPassword;
                getUser.Address = customer.Address;
                getUser.City = customer.City;
                getUser.Country = customer.Country;
                getUser.DateOfBirth = customer.DateOfBirth;
                getUser.Phone = customer.Phone;
                getUser.UpdatedAt = DateTime.Now;
            }
            return await Save();
        }
        public async Task<(bool, Admin)> loginAdmin(string? adminName, string? adminPassword)
        {
            var username = await _context.Admins
                .Where(name => name.Name == adminName)
                .FirstOrDefaultAsync();
            if (username == null)
            {
                throw new Exception("Wrong Credintials, Try Again.");
            }
            bool passwordMatch = BCrypt.Net.BCrypt.Verify(adminPassword, username.Password);
            if (!passwordMatch)
            {
                throw new Exception("Wrong Credentials, Try Again.");
            }

            return (true, username);
        }
        public async Task<bool> newAdmin(Admin admin)
        {
            string hashedPassword = BCrypt.Net.BCrypt.HashPassword(admin.Password);

            var newadmin = new Admin()
            {
                Name = admin.Name,
                Password = hashedPassword,
                Email = admin.Email,
                Address = admin.Address,
                PhoneNumber = admin.PhoneNumber,
                Role = "Admin"
            };
            await _context.Admins.AddAsync(newadmin);
            return await Save();
        }
        public async Task<bool> Save()
        {
            var saved = await _context.SaveChangesAsync();
            return saved > 0 ? true : false;
        }

    }
}
