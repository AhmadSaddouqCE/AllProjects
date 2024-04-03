using PreClinic.Services;

namespace PreClinic.Models
{
    public class DepartmentBranches
    {
        public int? departmentId { get; set; }
        public Department? Department { get; set; }
        public int? branchId { get; set; }
        public Branch? Branch { get; set; }
    }
}
