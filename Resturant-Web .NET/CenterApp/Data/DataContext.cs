using CenterApp.Models;
using Microsoft.EntityFrameworkCore;

namespace CenterApp.Data
{
    public class DataContext : DbContext
    {
        public DataContext(DbContextOptions<DataContext> options) : base(options)
        {

        }
        public DbSet<Customer> Customers { get; set; }
        public DbSet<Product> Products { get; set; }
        public DbSet<Orders> Orders { get; set; }
        public DbSet<ShoppingCart> Carts { get; set; }
        public DbSet<CartProducts> CartProducts { get; set; }
        public DbSet<OrderDetails> OrderDetails { get; set; }
        public DbSet<Category> Categories { get; set; }
        public DbSet<Admin> Admins { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<OrderDetails>()
    .HasKey(pc => new { pc.orderId, pc.productId });
            modelBuilder.Entity<OrderDetails>()
           .HasOne(p => p.Order)
           .WithMany(pc => pc.OrderDetail)
           .HasForeignKey(c => c.orderId)
           .OnDelete(DeleteBehavior.Cascade);

            modelBuilder.Entity<OrderDetails>()
                .HasOne(p => p.Product)
                .WithMany(pc => pc.OrderDetail)
                .HasForeignKey(c => c.productId)
                .OnDelete(DeleteBehavior.Cascade);

            modelBuilder.Entity<ShoppingCart>()
               .HasMany(sc => sc.CartProducts)
                .WithOne(cp => cp.ShoppingCart)
                .OnDelete(DeleteBehavior.Cascade);



            modelBuilder.Entity<CartProducts>()
                    .HasKey(pe => new { pe.ProductId, pe.ShoppingCartId });

            modelBuilder.Entity<CartProducts>()
                     .HasOne(pw => pw.Product)
                     .WithMany(r => r.CartProducts)
                     .HasForeignKey(t => t.ProductId)
                     .OnDelete(DeleteBehavior.Cascade);


            modelBuilder.Entity<CartProducts>()
                .HasOne(y => y.ShoppingCart)
                .WithMany(u => u.CartProducts)
                .HasForeignKey(i => i.ShoppingCartId)
                .OnDelete(DeleteBehavior.Cascade);

            modelBuilder.Entity<Product>()
               .HasOne(p => p.Category)
               .WithMany(c => c.Products)
               .HasForeignKey(p => p.categoryId)
               .OnDelete(DeleteBehavior.SetNull);

        }


    }
}