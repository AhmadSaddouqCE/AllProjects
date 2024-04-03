﻿// <auto-generated />
using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using PreClinic.Data;

#nullable disable

namespace PreClinic.Migrations
{
    [DbContext(typeof(DataContext))]
    [Migration("20240330072548_UpdateSystemLookupsTable")]
    partial class UpdateSystemLookupsTable
    {
        /// <inheritdoc />
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "8.0.3")
                .HasAnnotation("Relational:MaxIdentifierLength", 128);

            SqlServerModelBuilderExtensions.UseIdentityColumns(modelBuilder);

            modelBuilder.Entity("PreClinic.Models.DepartmentBranches", b =>
                {
                    b.Property<int?>("departmentId")
                        .HasColumnType("int");

                    b.Property<int?>("branchId")
                        .HasColumnType("int");

                    b.HasKey("departmentId", "branchId");

                    b.HasIndex("branchId");

                    b.ToTable("DepartmentBranches");
                });

            modelBuilder.Entity("PreClinic.Services.Branch", b =>
                {
                    b.Property<int>("branchId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("branchId"));

                    b.Property<string>("branchNameA")
                        .HasColumnType("nvarchar(450)");

                    b.Property<string>("branchNameE")
                        .HasColumnType("nvarchar(450)");

                    b.HasKey("branchId");

                    b.HasIndex("branchNameA")
                        .IsUnique()
                        .HasFilter("[branchNameA] IS NOT NULL");

                    b.HasIndex("branchNameE")
                        .IsUnique()
                        .HasFilter("[branchNameE] IS NOT NULL");

                    b.ToTable("Branches");
                });

            modelBuilder.Entity("PreClinic.Services.Department", b =>
                {
                    b.Property<int>("departmentId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("departmentId"));

                    b.Property<string>("departmentNameA")
                        .HasColumnType("nvarchar(450)");

                    b.Property<string>("departmentNameE")
                        .HasColumnType("nvarchar(450)");

                    b.HasKey("departmentId");

                    b.HasIndex("departmentNameA")
                        .IsUnique()
                        .HasFilter("[departmentNameA] IS NOT NULL");

                    b.HasIndex("departmentNameE")
                        .IsUnique()
                        .HasFilter("[departmentNameE] IS NOT NULL");

                    b.ToTable("Department");
                });

            modelBuilder.Entity("PreClinic.Services.Doctor", b =>
                {
                    b.Property<int>("doctorId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("doctorId"));

                    b.Property<string>("AddressA")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("AddressE")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Email")
                        .IsRequired()
                        .HasColumnType("nvarchar(450)");

                    b.Property<string>("Gender")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("ImageUrl")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Password")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Phone")
                        .IsRequired()
                        .HasColumnType("nvarchar(450)");

                    b.Property<DateTime?>("dateOfBirth")
                        .IsRequired()
                        .HasColumnType("datetime2");

                    b.Property<string>("doctorNameA1")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("doctorNameA2")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("doctorNameA3")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("doctorNameA4")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("doctorNameE1")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("doctorNameE2")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("doctorNameE3")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("doctorNameE4")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("userName")
                        .IsRequired()
                        .HasColumnType("nvarchar(450)");

                    b.HasKey("doctorId");

                    b.HasIndex("Email")
                        .IsUnique();

                    b.HasIndex("Phone")
                        .IsUnique();

                    b.HasIndex("userName")
                        .IsUnique();

                    b.ToTable("Doctors");
                });

            modelBuilder.Entity("PreClinic.Services.DoctorAppointmentSetup", b =>
                {
                    b.Property<int>("AppointmentSetupId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("AppointmentSetupId"));

                    b.Property<TimeSpan?>("BreakEndTime")
                        .HasColumnType("time");

                    b.Property<TimeSpan?>("BreakStartTime")
                        .HasColumnType("time");

                    b.Property<string>("DayOfWeek")
                        .HasColumnType("nvarchar(max)");

                    b.Property<int?>("DoctorId")
                        .HasColumnType("int");

                    b.Property<TimeSpan?>("EndTime")
                        .HasColumnType("time");

                    b.Property<TimeSpan?>("StartTime")
                        .HasColumnType("time");

                    b.Property<string>("duartionInMinute")
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("AppointmentSetupId");

                    b.HasIndex("DoctorId");

                    b.ToTable("DoctorAppointmentSetups");
                });

            modelBuilder.Entity("PreClinic.Services.DoctorBranches", b =>
                {
                    b.Property<int?>("doctorId")
                        .HasColumnType("int");

                    b.Property<int?>("branchId")
                        .HasColumnType("int");

                    b.HasKey("doctorId", "branchId");

                    b.HasIndex("branchId");

                    b.ToTable("DoctorBranches");
                });

            modelBuilder.Entity("PreClinic.Services.DoctorDepartment", b =>
                {
                    b.Property<int?>("doctorId")
                        .HasColumnType("int");

                    b.Property<int?>("departmentId")
                        .HasColumnType("int");

                    b.HasKey("doctorId", "departmentId");

                    b.HasIndex("departmentId");

                    b.ToTable("DoctorDepartments");
                });

            modelBuilder.Entity("PreClinic.Services.Patient", b =>
                {
                    b.Property<int>("PateintId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("PateintId"));

                    b.Property<string>("AddressA")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("AddressE")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Email")
                        .IsRequired()
                        .HasColumnType("nvarchar(450)");

                    b.Property<string>("Gender")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("ImageUrl")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Phone")
                        .IsRequired()
                        .HasColumnType("nvarchar(450)");

                    b.Property<int?>("cardId")
                        .IsRequired()
                        .HasColumnType("int");

                    b.Property<DateTime?>("dateOfBirth")
                        .IsRequired()
                        .HasColumnType("datetime2");

                    b.Property<int?>("doctorId")
                        .HasColumnType("int");

                    b.Property<string>("patientNameA1")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("patientNameA2")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("patientNameA3")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("patientNameA4")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("patientNameE1")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("patientNameE2")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("patientNameE3")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("patientNameE4")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("PateintId");

                    b.HasIndex("Email")
                        .IsUnique();

                    b.HasIndex("Phone")
                        .IsUnique();

                    b.HasIndex("cardId")
                        .IsUnique();

                    b.HasIndex("doctorId");

                    b.ToTable("Patients");
                });

            modelBuilder.Entity("PreClinic.Services.SystemLookups", b =>
                {
                    b.Property<int>("LookupId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("LookupId"));

                    b.Property<int?>("categoryId")
                        .HasColumnType("int");

                    b.Property<string>("lookupNameA")
                        .IsRequired()
                        .HasColumnType("nvarchar(450)");

                    b.Property<string>("lookupNameE")
                        .IsRequired()
                        .HasColumnType("nvarchar(450)");

                    b.HasKey("LookupId");

                    b.HasIndex("categoryId");

                    b.HasIndex("lookupNameA")
                        .IsUnique();

                    b.HasIndex("lookupNameE")
                        .IsUnique();

                    b.ToTable("SystemLookups");
                });

            modelBuilder.Entity("PreClinic.Services.SystemLookupsCategory", b =>
                {
                    b.Property<int>("CategoryId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("CategoryId"));

                    b.Property<string>("categoryCode")
                        .IsRequired()
                        .HasColumnType("nvarchar(450)");

                    b.Property<string>("categoryNameA")
                        .IsRequired()
                        .HasColumnType("nvarchar(450)");

                    b.Property<string>("categoryNameE")
                        .IsRequired()
                        .HasColumnType("nvarchar(450)");

                    b.HasKey("CategoryId");

                    b.HasIndex("categoryCode")
                        .IsUnique();

                    b.HasIndex("categoryNameA")
                        .IsUnique();

                    b.HasIndex("categoryNameE")
                        .IsUnique();

                    b.ToTable("SystemLookupsCategory");
                });

            modelBuilder.Entity("PreClinic.Models.DepartmentBranches", b =>
                {
                    b.HasOne("PreClinic.Services.Branch", "Branch")
                        .WithMany("DepartmentBranches")
                        .HasForeignKey("branchId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("PreClinic.Services.Department", "Department")
                        .WithMany("DepartmentBranches")
                        .HasForeignKey("departmentId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Branch");

                    b.Navigation("Department");
                });

            modelBuilder.Entity("PreClinic.Services.DoctorAppointmentSetup", b =>
                {
                    b.HasOne("PreClinic.Services.Doctor", "Doctor")
                        .WithMany()
                        .HasForeignKey("DoctorId");

                    b.Navigation("Doctor");
                });

            modelBuilder.Entity("PreClinic.Services.DoctorBranches", b =>
                {
                    b.HasOne("PreClinic.Services.Branch", "Branch")
                        .WithMany("DoctorBranches")
                        .HasForeignKey("branchId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("PreClinic.Services.Doctor", "Doctor")
                        .WithMany("DoctorBranches")
                        .HasForeignKey("doctorId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Branch");

                    b.Navigation("Doctor");
                });

            modelBuilder.Entity("PreClinic.Services.DoctorDepartment", b =>
                {
                    b.HasOne("PreClinic.Services.Department", "Department")
                        .WithMany("DoctorDepartments")
                        .HasForeignKey("departmentId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("PreClinic.Services.Doctor", "Doctor")
                        .WithMany("DoctorDepartment")
                        .HasForeignKey("doctorId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Department");

                    b.Navigation("Doctor");
                });

            modelBuilder.Entity("PreClinic.Services.Patient", b =>
                {
                    b.HasOne("PreClinic.Services.Doctor", "Doctor")
                        .WithMany("Patients")
                        .HasForeignKey("doctorId")
                        .OnDelete(DeleteBehavior.SetNull);

                    b.Navigation("Doctor");
                });

            modelBuilder.Entity("PreClinic.Services.SystemLookups", b =>
                {
                    b.HasOne("PreClinic.Services.SystemLookupsCategory", "Category")
                        .WithMany("SystemLookups")
                        .HasForeignKey("categoryId")
                        .OnDelete(DeleteBehavior.SetNull);

                    b.Navigation("Category");
                });

            modelBuilder.Entity("PreClinic.Services.Branch", b =>
                {
                    b.Navigation("DepartmentBranches");

                    b.Navigation("DoctorBranches");
                });

            modelBuilder.Entity("PreClinic.Services.Department", b =>
                {
                    b.Navigation("DepartmentBranches");

                    b.Navigation("DoctorDepartments");
                });

            modelBuilder.Entity("PreClinic.Services.Doctor", b =>
                {
                    b.Navigation("DoctorBranches");

                    b.Navigation("DoctorDepartment");

                    b.Navigation("Patients");
                });

            modelBuilder.Entity("PreClinic.Services.SystemLookupsCategory", b =>
                {
                    b.Navigation("SystemLookups");
                });
#pragma warning restore 612, 618
        }
    }
}
