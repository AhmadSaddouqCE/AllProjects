namespace PreClinic.Services
{
    public class DoctorBranches
    {
        public int? doctorId { get; set; }
        public Doctor? Doctor { get; set; }
        public int? branchId { get; set; }
        public Branch? Branch { get; set; }
    }
}
