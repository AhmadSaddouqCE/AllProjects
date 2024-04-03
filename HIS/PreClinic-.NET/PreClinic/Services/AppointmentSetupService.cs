using Microsoft.EntityFrameworkCore;
using PreClinic.Data;

namespace PreClinic.Services
{
    public class AppointmentSetupService
    {
        private readonly DataContext _context;
        public AppointmentSetupService(DataContext context)
        {
            _context = context;
        }

        public async Task<List<DoctorAppointmentSetup>> getSetupDetails(int? branchId, int? departmentId, int? doctorId)
        {
            var getBranch = await _context.Branches.FindAsync(branchId);
            if (getBranch is null) throw new Exception("This Branch Doesn't Exist");
            var getDoctor = await _context.Doctors.FindAsync(doctorId);
            if (getDoctor is null) throw new Exception("This Doctor Dosen't Exist");
            var getDepartment = await _context.Department.FindAsync(departmentId);
            if (getDepartment is null) throw new Exception("This Department Doesn't Exist");
            var checkRelated = await _context.DepartmentBranches
                .Where(id => id.branchId == branchId && id.departmentId == departmentId)
                .FirstOrDefaultAsync();
            if (checkRelated is null) throw new Exception("This Department Doesn't Relate to This Branch");
            var newList = new List<DoctorAppointmentSetup>();
            var getAppointmentDeails = await _context.DoctorAppointmentSetups
                .Where(id => id.BranchId == branchId
                && id.DoctorId == doctorId
                && id.DepartmentId == departmentId)
                .ToListAsync();
            foreach (var item in getAppointmentDeails)
            {
                var addToList = new DoctorAppointmentSetup()
                {
                    DepartmentId = item.DepartmentId,
                    BreakOut = item.BreakOut,
                    BranchId = item.BranchId,
                    BreakIn = item.BreakIn,
                    dayOfWeek = item.dayOfWeek,
                    DurationInMinutes = item.DurationInMinutes,
                    FromTime = item.FromTime,
                    ToTime = item.ToTime,
                    DoctorId = item.DoctorId,
                };
                newList.Add(addToList);
            }
            return newList;
        }



        public async Task<bool> addDoctorAppointmentSetups(List<DoctorAppointmentSetup> appointmentSetups)
        {
            var getBranch = appointmentSetups.Select(id => id.BranchId).FirstOrDefault();
            var getDoctor = appointmentSetups.Select(id => id.DoctorId).FirstOrDefault();
            var getDepartment = appointmentSetups.Select(id => id.DepartmentId).FirstOrDefault();
            if (getDoctor is null) throw new Exception("This Doctor Doesn't Exist");
            if (getDepartment is null) throw new Exception("This Department Doesn't Exist");
            if (getDepartment is null) throw new Exception("This Branch Doesn't Exist");
            var checkRelated = await _context.DepartmentBranches
              .Where(id => id.departmentId == getDepartment && id.branchId == getBranch)
              .FirstOrDefaultAsync();
            if (checkRelated is null) throw new Exception("This Department Doesn't Relate To This Branch");
            foreach (var setup in appointmentSetups)
            {
                var checkSetupDoctor = await _context.DoctorAppointmentSetups
                      .Where(id => id.DoctorId == setup.DoctorId
                      && id.DepartmentId == setup.DepartmentId
                      && id.BranchId == setup.BranchId
                      && id.dayOfWeek == setup.dayOfWeek)
                      .FirstOrDefaultAsync();
                if (checkSetupDoctor is null)
                {
                    var newSetupDoctor = new DoctorAppointmentSetup()
                    {
                        BranchId = setup.BranchId,
                        BreakOut = setup.BreakOut,
                        dayOfWeek = setup.dayOfWeek,
                        DepartmentId = setup.DepartmentId,
                        DoctorId = setup.DoctorId,
                        DurationInMinutes = setup.DurationInMinutes,
                        FromTime = setup.FromTime,
                        ToTime = setup.ToTime,
                        BreakIn = setup.BreakIn,

                    };
                    await _context.DoctorAppointmentSetups.AddAsync(newSetupDoctor);
                }
                else
                {
                    checkSetupDoctor.BreakOut = setup.BreakOut;
                    checkSetupDoctor.BreakIn = setup.BreakIn;
                    checkSetupDoctor.DurationInMinutes = setup.DurationInMinutes;
                    checkSetupDoctor.FromTime = setup.FromTime;
                    checkSetupDoctor.ToTime = setup.ToTime;


                }
            }
            return await Save();
        }
        public async Task<bool> Save()
        {
            var saved = await _context.SaveChangesAsync();
            return saved > 0 ? true : false;
        }
    }
}
