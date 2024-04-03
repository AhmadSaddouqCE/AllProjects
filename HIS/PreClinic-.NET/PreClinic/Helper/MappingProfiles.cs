using AutoMapper;
using PreClinic.Dto;
using PreClinic.Models;
using PreClinic.Services;

namespace PreClinic.Helper
{
    public class MappingProfiles : Profile
    {
        public MappingProfiles()
        {
            //Patient
            CreateMap<Patient, PatientDto>();
            CreateMap<PatientDto, Patient>();

            //SystemlookupsCategory
            CreateMap<SystemLookupsCategory, SystemlookupsCategoryDto>();
            CreateMap<SystemlookupsCategoryDto, SystemLookupsCategory>();

            //Doctor
            CreateMap<Doctor, DoctorDto>();
            CreateMap<DoctorDto, Doctor>();

            //Systemlookups
            CreateMap<SystemLookups, SystemlookupsDto>();
            CreateMap<SystemlookupsDto, SystemLookups>();

            //DepartmentBranches
            CreateMap<DepartmentBranches, DepartmentBranchesDto>();
            CreateMap<DepartmentBranchesDto, DepartmentBranches>();

            //Department 
            CreateMap<Department, DepartmentDto>();
            CreateMap<DepartmentDto, Department>();

            //Branch
            CreateMap<Branch, BranchDto>();
            CreateMap<BranchDto, Branch>();

            //DoctorAppointments
            CreateMap<DoctorAppointmentSetup, DoctorAppointmentSetupsDto>();
            CreateMap<DoctorAppointmentSetupsDto, DoctorAppointmentSetup>();

        }
    }
}
