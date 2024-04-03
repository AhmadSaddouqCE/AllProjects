using CenterApp.Data;
using CenterApp.Models;
using Microsoft.EntityFrameworkCore;

namespace CenterApp.Services
{
    public class CartServices
    {
        private readonly DataContext _context;
        public CartServices(DataContext context)
        {
            _context = context;
        }

        public async Task<List<ShoppingCart>> getAllCarts()
        {
            return await _context.Carts.ToListAsync();
        }


        public async Task<bool> newCart(ShoppingCart Cart, int? productId, int? customerId, int? Quantity, int? Price, string? imageUrl)
        {
            if (Cart == null
                || productId <= 0
                || customerId <= 0
                || Price <= 0
                || Quantity <= 0
                || imageUrl == null)
            {
                throw new Exception("Error Happened");

            }

            var CheckExistsingPrdouct = await _context.Products.Where(id => id.ProductId == productId).FirstOrDefaultAsync();
            var checkInCart = await _context.Carts.Where(i => i.ProductId == CheckExistsingPrdouct.ProductId).FirstOrDefaultAsync();
            var checkQuantity = CheckExistsingPrdouct.Quantity - Quantity;
            if (checkQuantity < 0)
            {
                throw new Exception("There is No Enough Quantity");
            }
            if (checkInCart != null)
            {
                checkInCart.Quantity += Quantity;
                checkInCart.TotalPrice = Price * checkInCart.Quantity;
                CheckExistsingPrdouct.Quantity = checkQuantity;
                return await Save();
            }

            var addCart = new ShoppingCart()
            {
                CustomerId = customerId,
                ProductId = productId,
                Price = Price,
                Quantity = Quantity,
                TotalPrice = Price * Quantity,
                imageUrl = imageUrl
            };

            await _context.Carts.AddAsync(addCart);
            await _context.SaveChangesAsync();

            var addProductCart = new CartProducts()
            {
                ProductId = productId,
                ShoppingCartId = addCart.ShoppingCartId
            };

            await _context.CartProducts.AddAsync(addProductCart);
            CheckExistsingPrdouct.Quantity = checkQuantity;

            return await Save();
        }

        public async Task<bool> DeleteFromCartByCartId(int cartId)
        {
            var getCart = await _context.Carts.Where(Id => Id.ShoppingCartId == cartId).FirstOrDefaultAsync();
            if (getCart == null)
            {
                throw new Exception("User Not Found");
            }
            var getCartsProduct = await _context.CartProducts.Where(i => i.ShoppingCartId == cartId).FirstOrDefaultAsync();
            if (getCartsProduct == null)
            {
                throw new Exception("No Carts Found");
            }
            var getProduct = await _context.Products.Where(id => id.ProductId == getCart.ProductId).FirstOrDefaultAsync();
            if (getProduct == null)
            {
                throw new Exception("No Products Found");

            }

            getProduct.Quantity += getCart.Quantity;
            _context.CartProducts.RemoveRange(getCartsProduct);
            _context.Carts.RemoveRange(getCart);

            return await Save();
        }
        public async Task<bool> editCartQuantity(int cartId, int quantity)
        {
            var getCart = await _context.Carts.Where(id => id.ShoppingCartId == cartId).FirstOrDefaultAsync();
            if (getCart == null)
            {
                throw new Exception("No Cart Found");
            }
            if (getCart.Quantity == quantity)
            {
                return true;
            }
            var getProduct = await _context.Products.Where(id => id.ProductId == getCart.ProductId).FirstOrDefaultAsync();
            if (getProduct == null)
            {
                throw new Exception("No Product Found");
            }
            var TotalQuantity = getProduct.Quantity;
            var CartQuantity = getCart.Quantity;
            getProduct.Quantity = getProduct.Quantity + CartQuantity - quantity;
            getCart.Quantity = quantity;
            if (getProduct.Quantity < 0)
            {
                throw new Exception("Invalid Quantity");
            }

            return await Save();
        }
        public async Task<Object> getUserCartsById(int customerId)
        {
            if (customerId <= 0)
            {
                throw new Exception("User Not Found");
            }
            var getCustomer = await _context.Carts.Where(c => c.CustomerId == customerId).ToListAsync();
            var getCarts = new List<object>();

            foreach (var customer in getCustomer)
            {
                var getProduct = await _context.Products.Where(p => p.ProductId == customer.ProductId).FirstOrDefaultAsync();
                var getCartId = await _context.CartProducts.Where(p => p.ProductId == getProduct.ProductId).FirstOrDefaultAsync();
                var cartid = getCartId.ShoppingCartId;
                if (getProduct == null)
                {
                    throw new Exception("No Product Found");
                }
                var getProductName = getProduct.Name;
                var getProductImage = getProduct.ImageUrl;
                getCarts.Add(new
                {
                    cartid,
                    customer.CustomerId,
                    customer.ProductId,
                    customer.Quantity,
                    customer.Price,
                    TotalPrice = customer.Quantity * customer.Price,
                    productName = getProductName,
                    imageUrl = getProductImage
                });
            }

            return getCarts;
        }
        public async Task<bool> Save()
        {
            var saved = await _context.SaveChangesAsync();
            return saved > 0 ? true : false;
        }

    }
}
