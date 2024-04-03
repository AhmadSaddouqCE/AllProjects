namespace PreClinic.Services
{
    public class DoctorDepartment
    {
        public int? doctorId { get; set; }
        public Doctor? Doctor { get; set; }
        public int? departmentId { get; set; }
        public Department? Department { get; set; }
    }
}
