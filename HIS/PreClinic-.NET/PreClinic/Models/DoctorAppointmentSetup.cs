using System.ComponentModel.DataAnnotations;

namespace PreClinic.Services
{
    public class DoctorAppointmentSetup
    {
        [Key]
        public int? AppointmentSetupId { get; set; }
        public int? DoctorId { get; set; }
        public Doctor? Doctor { get; set; }
        public int? DepartmentId { get; set; }
        public Department? Department { get; set; }
        public int? BranchId { get; set; }
        public Branch? Branch { get; set; }
        public string? dayOfWeek { get; set; }
        public string? FromTime { get; set; }
        public string? ToTime { get; set; }
        public string? BreakIn { get; set; }
        public string? BreakOut { get; set; }
        public string? DurationInMinutes { get; set; }
    }
}

