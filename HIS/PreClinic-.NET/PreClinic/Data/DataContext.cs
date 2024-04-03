using Microsoft.EntityFrameworkCore;
using PreClinic.Models;
using PreClinic.Services;

namespace PreClinic.Data
{
    public class DataContext : DbContext
    {
        public DataContext(DbContextOptions<DataContext> options) : base(options)
        {

        }
        public DbSet<Patient> Patients { get; set; }
        public DbSet<Doctor> Doctors { get; set; }
        public DbSet<Branch> Branches { get; set; }
        public DbSet<Department> Department { get; set; }
        public DbSet<SystemLookups> SystemLookups { get; set; }
        public DbSet<SystemLookupsCategory> SystemLookupsCategory { get; set; }
        public DbSet<DoctorAppointmentSetup> DoctorAppointmentSetups { get; set; }
        public DbSet<DoctorBranches> DoctorBranches { get; set; }
        public DbSet<DoctorDepartment> DoctorDepartments { get; set; }
        public DbSet<DepartmentBranches> DepartmentBranches { get; set; }
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {

            modelBuilder.Entity<DepartmentBranches>()
                .HasKey(db => new { db.departmentId, db.branchId });

            modelBuilder.Entity<DepartmentBranches>()
                .HasOne(db => db.Department)
                .WithMany(d => d.DepartmentBranches)
                .HasForeignKey(db => db.departmentId)
                .OnDelete(DeleteBehavior.Cascade);

            modelBuilder.Entity<DepartmentBranches>()
                .HasOne(db => db.Branch)
                .WithMany(b => b.DepartmentBranches)
                .HasForeignKey(db => db.branchId)
                .OnDelete(DeleteBehavior.Cascade);

            modelBuilder.Entity<DoctorBranches>()
                .HasKey(db => new { db.doctorId, db.branchId });

            modelBuilder.Entity<DoctorBranches>()
                .HasOne(db => db.Doctor)
                .WithMany(d => d.DoctorBranches)
                .HasForeignKey(db => db.doctorId)
                .OnDelete(DeleteBehavior.Cascade);

            modelBuilder.Entity<DoctorBranches>()
                .HasOne(db => db.Branch)
                .WithMany(b => b.DoctorBranches)
                .HasForeignKey(db => db.branchId)
                .OnDelete(DeleteBehavior.Cascade);

            modelBuilder.Entity<DoctorDepartment>()
              .HasKey(db => new { db.doctorId, db.departmentId });

            modelBuilder.Entity<DoctorDepartment>()
                .HasOne(db => db.Doctor)
                .WithMany(d => d.DoctorDepartment)
                .HasForeignKey(db => db.doctorId)
                .OnDelete(DeleteBehavior.Cascade);

            modelBuilder.Entity<DoctorDepartment>()
                .HasOne(db => db.Department)
                .WithMany(b => b.DoctorDepartments)
                .HasForeignKey(db => db.departmentId)
                .OnDelete(DeleteBehavior.Cascade);



            modelBuilder.Entity<Patient>()
                .HasOne(D => D.Doctor)
                .WithMany(P => P.Patients)
                .OnDelete(DeleteBehavior.SetNull);


            modelBuilder.Entity<SystemLookups>()
                .HasOne(S => S.Category)
                .WithMany(S => S.SystemLookups)
                .OnDelete(DeleteBehavior.SetNull);






            base.OnModelCreating(modelBuilder);
        }


    }
}
