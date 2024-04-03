using Azure.Storage.Blobs;
using Microsoft.AspNetCore.Mvc.ModelBinding;
using Microsoft.EntityFrameworkCore;
using PreClinic.Data;
using PreClinic.Dto;

namespace PreClinic.Services
{
    public class DoctorService
    {
        private readonly DataContext _context;
        public DoctorService(DataContext context)
        {
            _context = context;
        }
        public async Task<List<Doctor>> getDoctorsPagination(int page, int pageSize)
        {
            int skipAmount = (page - 1) * pageSize;
            var doctors = await _context.Doctors.Skip(skipAmount).Take(pageSize).ToListAsync();
            return doctors;
        }
        public async Task<int> getDoctorsCount()
        {
            return await _context.Doctors.CountAsync();
        }
        public async Task<bool> addDoctor(Doctor doctor, Dictionary<string, List<Departments>> BranchesDepartments)
        {
            using var transaction = await _context.Database.BeginTransactionAsync();
            try
            {
                if (doctor.doctorImage is null) throw new Exception("Image Required");
                string connectionString = @"DefaultEndpointsProtocol=https;AccountName=centercontainerapp;AccountKey=1cJ8BE0WIm8ZLPRNHLc/At9LW1uHcme42IaSue2U/kh7h+lm+fpT1o41B15XsaYwA/XAyqeGsaGq+AStsir7XA==;EndpointSuffix=core.windows.net";
                string containerName = "image";
                var imageUrl = await UploadImageAsync(doctor.doctorImage, connectionString, containerName);
                string hashedPassword = BCrypt.Net.BCrypt.HashPassword(doctor.Password);
                var newDoctor = new Doctor()
                {
                    AddressA = doctor.AddressA,
                    AddressE = doctor.AddressE,
                    dateOfBirth = doctor.dateOfBirth,
                    doctorNameA1 = doctor.doctorNameA1,
                    doctorNameA2 = doctor.doctorNameA2,
                    doctorNameA3 = doctor.doctorNameA3,
                    doctorNameA4 = doctor.doctorNameA4,
                    doctorNameE1 = doctor.doctorNameE1,
                    doctorNameE2 = doctor.doctorNameE2,
                    doctorNameE3 = doctor.doctorNameE3,
                    doctorNameE4 = doctor.doctorNameE4,
                    Email = doctor.Email,
                    Gender = doctor.Gender,
                    userName = doctor.userName,
                    Phone = doctor.Phone,
                    ImageUrl = imageUrl,
                    Password = hashedPassword,
                };
                await _context.Doctors.AddAsync(newDoctor);
                await Save();
                foreach (var branchEntry in BranchesDepartments)
                {
                    var branchName = branchEntry.Key;
                    var departments = branchEntry.Value;
                    if (departments.Count == 0) continue;
                    var getBranch = await _context.Branches
                        .Where(b => b.branchNameE == branchName)
                        .FirstOrDefaultAsync();

                    if (getBranch is null)
                    {
                        throw new Exception("This Branch Doesn't Exist");
                    }
                    var newDoctorBranch = new DoctorBranches()
                    {
                        branchId = getBranch.branchId,
                        doctorId = newDoctor.doctorId
                    };
                    await _context.DoctorBranches.AddAsync(newDoctorBranch);
                    await Save();
                    foreach (var department in departments)
                    {
                        var getDepartment = await _context.Department.
                            Where(Name => Name.departmentNameE == department.departmentName).
                            FirstOrDefaultAsync();
                        if (getDepartment is null) throw new Exception("This Department Doesn't Exist");
                        var cheackRelatedDepartmentBranch =
                            await _context.DepartmentBranches.
                            Where(id => id.departmentId == getDepartment.departmentId && id.branchId == getBranch.branchId)
                            .FirstOrDefaultAsync();
                        if (cheackRelatedDepartmentBranch is null)
                            throw new Exception("This Department Doesn't Realte To This Branch");
                        var DoctorDepartment = await _context.DoctorDepartments.
                            Where(id => id.doctorId == newDoctor.doctorId).
                            FirstOrDefaultAsync();
                        if (DoctorDepartment is null)
                        {
                            var addNew = new DoctorDepartment()
                            {
                                departmentId = getDepartment.departmentId,
                                doctorId = newDoctor.doctorId

                            };
                            await _context.DoctorDepartments.AddAsync(addNew);
                            await Save();
                        }
                        else
                        {
                            var checkSameDepartment = await _context.DoctorDepartments.
                                Where(id => id.doctorId == newDoctor.doctorId && id.departmentId == getDepartment.departmentId)
                                .FirstOrDefaultAsync();
                            if (checkSameDepartment is not null) continue;
                            else
                            {

                                var addNewDoctoreDepartment = new DoctorDepartment()
                                {
                                    departmentId = getDepartment.departmentId,
                                    doctorId = newDoctor.doctorId

                                };
                                await _context.DoctorDepartments.AddAsync(addNewDoctoreDepartment);
                                await Save();
                            }
                        }
                    }
                }
                await transaction.CommitAsync();
                return true;
            }
            catch (Exception ex)
            {
                await transaction.RollbackAsync();
                throw new Exception("Failed To Add Doctor");
            }
        }
        public async Task<List<Doctor>> getAllDoctors()
        {
            return await _context.Doctors.AsNoTracking().ToListAsync();
        }
        public async Task<bool> Save()
        {
            var saved = await _context.SaveChangesAsync();
            return saved > 0 ? true : false;
        }
        public async Task<string> ValidateModelAsync(ModelStateDictionary modelState)
        {
            var firstError = modelState.Values
                .SelectMany(v => v.Errors)
                .FirstOrDefault(e => !string.IsNullOrEmpty(e.ErrorMessage));

            if (firstError is not null) return firstError.ErrorMessage;

            return await Task.FromResult(string.Empty);
        }
        public async Task<string> UploadImageAsync(IFormFile imageFile, string connectionString, string containerName)
        {
            if (imageFile is null)
            {
                throw new ArgumentNullException(nameof(imageFile), "Image file cannot be null");
            }

            string uniqueBlobName = Guid.NewGuid().ToString() + "_" + imageFile.FileName;

            BlobContainerClient blobContainerClient = new BlobContainerClient(connectionString, containerName);
            BlobClient blobClient = blobContainerClient.GetBlobClient(uniqueBlobName);

            using (var memoryStream = new MemoryStream())
            {
                await imageFile.CopyToAsync(memoryStream);
                memoryStream.Position = 0;
                await blobClient.UploadAsync(memoryStream);
            }

            return blobClient.Uri.AbsoluteUri;
        }
    }
}
