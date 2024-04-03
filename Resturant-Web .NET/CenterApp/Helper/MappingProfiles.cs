using AutoMapper;
using CenterApp.AppDto;
using CenterApp.Models;

namespace CenterApp.Helper
{
    public class MappingProfiles : Profile
    {
        public MappingProfiles()
        {
            CreateMap<Customer, CustomerDto>();
            CreateMap<CustomerDto, Customer>();
            {
                CreateMap<Customer, CustomerPasswordDto>();
                CreateMap<CustomerPasswordDto, Customer>();

                CreateMap<CustomerLoginDto, Customer>();
                CreateMap<Customer, CustomerLoginDto>();

                CreateMap<CustomerOrderDto, Orders>();
                CreateMap<ProductDto, Product>();

                CreateMap<CartDto, ShoppingCart>();
                CreateMap<ShoppingCart, CartDto>();

                CreateMap<Admin, AdminDto>();
                CreateMap<AdminDto, Admin>();

                CreateMap<AdminLogIn, Admin>();
                CreateMap<Admin, AdminLogIn>();


                CreateMap<addProductsToCart, Orders>();
                CreateMap<Orders, addProductsToCart>();

                CreateMap<Category, CategoryDto>();
                CreateMap<CategoryDto, Category>();




            }
        }
    }
}