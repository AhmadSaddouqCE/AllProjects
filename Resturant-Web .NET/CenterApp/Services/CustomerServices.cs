using CenterApp.AppDto;
using CenterApp.Data;
using CenterApp.Models;
using Microsoft.EntityFrameworkCore;

namespace CenterApp.Services
{
    public class CustomerServices
    {
        private readonly DataContext _context;
        private readonly ProductService _productService;
        private readonly IWebHostEnvironment _webHostEnvironment;

        public CustomerServices(DataContext context, ProductService productService, IWebHostEnvironment webHostEnvironment)
        {
            _context = context;
            _productService = productService;
            _webHostEnvironment = webHostEnvironment;
        }

        public async Task<Customer> getUserById(int? id)
        {
            var customer = await _context.Customers.FirstOrDefaultAsync(i => i.CustomerId == id);
            if (customer == null) throw new Exception("No Customer Found");

            return customer;
        }
        public async Task<bool> editCustomerPassword(int? id, string? oldPassword, string? newPassword)
        {
            var getUser = await _context.Customers
                .Where(i => i.CustomerId == id)
                .FirstOrDefaultAsync();
            if (getUser == null) throw new Exception("This User Doesn't Exist");
            bool passwordsMatch = BCrypt.Net.BCrypt.Verify(oldPassword, getUser.Password);
            if (!passwordsMatch) throw new Exception("Incorrect Password");
            var hash_newPassword = BCrypt.Net.BCrypt.HashPassword(newPassword);
            getUser.Password = hash_newPassword;
            return await Save();
        }
        public async Task<bool> editUser_NoPassword(int? id, Customer customer)
        {
            var getUser = await _context
                .Customers
                .Where(i => i.CustomerId == id)
                .FirstOrDefaultAsync();
            if (getUser is null) throw new Exception("This User Doesn't Exist");
            var CheckUserUpdateName = getUser.Name;
            var CheckUserUpdateEmail = getUser.Email;
            var CheckUserUpdatePhone = getUser.Phone;
            if (CheckUserUpdateName.Equals(customer.Name) &&
                CheckUserUpdateEmail.Equals(customer.Email) &&
                CheckUserUpdatePhone.Equals(customer.Phone))
            {
                getUser.Address = customer.Address;
                getUser.City = customer.City;
                getUser.Country = customer.Country;
                getUser.DateOfBirth = customer.DateOfBirth;
                getUser.UpdatedAt = DateTime.Now;
                return await Save();
            }
            else
            {
                getUser.Name = customer.Name;
                getUser.Email = customer.Email;
                getUser.Address = customer.Address;
                getUser.City = customer.City;
                getUser.Country = customer.Country;
                getUser.DateOfBirth = customer.DateOfBirth;
                getUser.Phone = customer.Phone;
                getUser.UpdatedAt = DateTime.Now;
            }
            return await Save();
        }
        public async Task<(bool, Customer)> editUser(int? id, Customer customer)
        {
            var getUser = await _context.Customers.Where(i => i.CustomerId == id).FirstOrDefaultAsync();
            if (getUser == null) throw new Exception("This User Doesn't Exist");
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
                await _context.SaveChangesAsync();
                return (true, getUser);

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
            return (await Save(), getUser);
        }
        public async Task<List<SearchDTO>> getBySearch(string Name)
        {
            List<SearchDTO> results = new List<SearchDTO>();

            var productsWithSubstring = await _context.Products.Where(p => p.Name.Contains(Name)).ToListAsync();
            var customersWithSubstring = await _context.Customers.Where(c => c.Name.Contains(Name)).ToListAsync();
            if (productsWithSubstring.Count > 0 || customersWithSubstring.Count > 0)
            {

                foreach (var product in productsWithSubstring)
                {
                    results.Add(new SearchDTO { Product = product });
                }
                foreach (var customer in customersWithSubstring)
                {
                    results.Add(new SearchDTO { Customer = customer });
                }

                return results;
            }
            else
            {
                throw new Exception("Not Found");
            }
        }
        public async Task<(bool, Customer)> loginUser(string? customerName, string? customerPassword)
        {
            var username = await _context.Customers
                .Where(name => name.Name == customerName)
                .FirstOrDefaultAsync();
            if (username == null)
            {
                throw new Exception("Wrong Credintials, Try Again.");
            }
            bool passwordMatch = BCrypt.Net.BCrypt.Verify(customerPassword, username.Password);
            if (!passwordMatch)
            {
                throw new Exception("Wrong Credentials, Try Again.");
            }

            return (true, username);
        }

        public async Task<List<Customer>> getAllUsers()
        {
            var getAll = await _context.Customers.ToListAsync();
            return getAll;
        }


        public async Task<bool> newCustomer(Customer customer)
        {
            string hashedPassword = BCrypt.Net.BCrypt.HashPassword(customer.Password);

            var addCustomer = new Customer()
            {
                Name = customer.Name,
                Email = customer.Email,
                Password = hashedPassword,
                City = customer.City,
                Country = customer.Country,
                Phone = customer.Phone,
                Address = customer.Address,
                DateOfBirth = customer.DateOfBirth,
                CreatedAt = DateTime.Now,
                UpdatedAt = DateTime.Now,
            };
            await _context.AddAsync(addCustomer);
            return await Save();
        }


        public async Task<bool> Save()
        {
            var saved = await _context.SaveChangesAsync();
            return saved > 0 ? true : false;
        }

    }
}
