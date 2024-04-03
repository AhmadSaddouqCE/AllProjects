namespace PreClinic.Dto
{
    public class DoctorAppointmentSetupsDto
    {
        public int? AppointmentSetupId { get; set; }
        public int? DoctorId { get; set; }
        public string? dayOfWeek { get; set; }
        public string? FromTime { get; set; }
        public string? ToTime { get; set; }
        public string? BreakIn { get; set; }
        public string? BreakOut { get; set; }
        public string? DurationInMinutes { get; set; }
        public int? DepartmentId { get; set; }
        public int? BranchId { get; set; }
    }
}
