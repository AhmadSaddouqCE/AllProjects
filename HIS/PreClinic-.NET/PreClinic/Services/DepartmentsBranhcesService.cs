using Microsoft.EntityFrameworkCore;
using PreClinic.Data;
using PreClinic.Dto;
using PreClinic.Models;

namespace PreClinic.Services
{
    public class DepartmentsBranhcesService
    {
        private readonly DataContext _context;
        public DepartmentsBranhcesService(DataContext context)
        {
            _context = context;
        }
        public async Task<bool> addDeparmentToBranch(int? departmentId, int? branchId)
        {
            var getDepartment = await _context.Department.FindAsync(departmentId);
            if (getDepartment is null) throw new Exception("This Department Doesn't Exist");
            var getBranch = await _context.Branches.FindAsync(branchId);
            if (getBranch is null) throw new Exception("This Branch Doesn't Exist");
            var checkForExistance = await _context.DepartmentBranches
                .Where(id => id.branchId == branchId &&
                id.departmentId == departmentId)
                .FirstOrDefaultAsync();
            if (checkForExistance is not null) throw new Exception("This Department Exists in thie Branch");
            var newDepartmentBranch = new DepartmentBranches()
            {
                branchId = branchId,
                departmentId = departmentId
            };
            await _context.DepartmentBranches.AddAsync(newDepartmentBranch);
            return await Save();
        }
        public async Task<List<DoctorsInDepartmentAndBranchesDto>> getDoctorsInBranchAndDepartment(DoctorsInDepartmentAndBranchesDto doctors)
        {
            var newDoctorsList = new List<DoctorsInDepartmentAndBranchesDto>();
            var getBranch = await _context.Branches.FindAsync(doctors.branchId);
            if (getBranch is null) throw new Exception("This Branch Doesn't Exist");
            var getDepartment = await _context.Department.FindAsync(doctors.departmentId);
            if (getDepartment is null) throw new Exception("This Department Doesn't Exist");

            var getDoctorDepartments = await _context.DoctorDepartments.
                Where(id => id.departmentId == doctors.departmentId)
                .ToListAsync();
            foreach (var DoctorDepartments in getDoctorDepartments)
            {
                var getDepartmentsInBranch = await _context.DepartmentBranches.
                 Where(id => id.branchId == doctors.branchId
                 && id.departmentId == doctors.departmentId).
                 FirstOrDefaultAsync();
                if (getDepartmentsInBranch is not null)
                {

                    var getDoctor = await _context.Doctors.FindAsync(DoctorDepartments.doctorId);
                    if (getDoctor is null) throw new Exception("This Doctor Doesn't Exist");
                    var checkDoctorInBranch = await _context.DoctorBranches.
                        Where(id => id.doctorId == getDoctor.doctorId && doctors.branchId == id.branchId).
                        FirstOrDefaultAsync();
                    if (checkDoctorInBranch is not null)
                    {
                        var addDoctorToList = new DoctorsInDepartmentAndBranchesDto()
                        {
                            doctorNameE = getDoctor.doctorNameE1,
                            doctorId = getDoctor.doctorId
                        };
                        newDoctorsList.Add(addDoctorToList);
                    }

                }
            }

            return newDoctorsList;
        }

        public async Task<List<DepartmentBranchesDto>> getDepartmentsByBranchId(int? branchId)
        {
            var getBranch = await _context.Branches.FindAsync(branchId);
            if (getBranch is null) throw new Exception("This Branch Doest't Exist");
            var getDepartmentsInBranch = await _context.DepartmentBranches
                .Where(id => id.branchId == branchId)
                .ToListAsync();
            if (getDepartmentsInBranch is null) throw new Exception("No Available Branches");
            var ListOfDepartments = new List<DepartmentBranchesDto>();
            foreach (var department in getDepartmentsInBranch)
            {
                var getDepartment = await _context.Department.FindAsync(department.departmentId);
                if (getDepartment is null) throw new Exception("This Department Doesn't Exist");
                var newDto = new DepartmentBranchesDto()
                {
                    departmentName = getDepartment.departmentNameE,
                    branchName = getBranch.branchNameE,
                    departmentNameA = getDepartment.departmentNameA,
                    departmentId = getDepartment.departmentId

                };
                ListOfDepartments.Add(newDto);
            }
            return ListOfDepartments;
        }

        public async Task<bool> Save()
        {
            var saved = await _context.SaveChangesAsync();
            return saved > 0 ? true : false;
        }
    }
}
