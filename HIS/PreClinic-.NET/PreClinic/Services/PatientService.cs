using Azure.Storage.Blobs;
using Microsoft.AspNetCore.Mvc.ModelBinding;
using Microsoft.EntityFrameworkCore;
using PreClinic.Data;

namespace PreClinic.Services
{
    public class PatientService
    {
        private readonly DataContext _context;

        public PatientService(DataContext context)
        {
            _context = context;
        }
        public async Task<List<Patient>> GetPatients()
        {
            return await _context.Patients.AsNoTracking().ToListAsync();
        }
        public async Task<List<Patient>> getPatientsPagination(int page, int pageSize)
        {
            int skipAmount = (page - 1) * pageSize;
            var patients = await _context.Patients.Skip(skipAmount).Take(pageSize).ToListAsync();
            return patients;
        }
        public async Task<int> getPatientsCount()
        {
            return await _context.Patients.CountAsync();
        }
        public async Task<bool> addPatient(Patient patient)
        {
            if (patient.patientImage is null) throw new Exception("Image Required");
            // string connectionString = @"DefaultEndpointsProtocol=https;AccountName=centercontainerapp;AccountKey=1cJ8BE0WIm8ZLPRNHLc/At9LW1uHcme42IaSue2U/kh7h+lm+fpT1o41B15XsaYwA/XAyqeGsaGq+AStsir7XA==;EndpointSuffix=core.windows.net";
            // string containerName = "image";
            // var imageUrl = await UploadImageAsync(patient.patientImage, connectionString, containerName);
            var addPatient = new Patient()
            {
                patientNameE1 = patient.patientNameE1,
                patientNameE2 = patient.patientNameE2,
                patientNameE3 = patient.patientNameE3,
                patientNameE4 = patient.patientNameE4,
                patientNameA1 = patient.patientNameA1,
                patientNameA2 = patient.patientNameA2,
                patientNameA3 = patient.patientNameA3,
                patientNameA4 = patient.patientNameA4,
                Phone = patient.Phone,
                AddressA = patient.AddressA,
                AddressE = patient.AddressE,
                dateOfBirth = patient.dateOfBirth,
                Email = patient.Email,
                Gender = patient.Gender,
                doctorId = patient.doctorId,
                // ImageUrl = imageUrl,
                cardId = patient.cardId
            };
            await _context.Patients.AddAsync(addPatient);
            return await Save();
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
        // public async Task<string> UploadImageAsync(IFormFile imageFile, string connectionString, string containerName)
        // {
        //     if (imageFile is null)
        //     {
        //         throw new ArgumentNullException(nameof(imageFile), "Image file cannot be null");
        //     }

        //     string uniqueBlobName = Guid.NewGuid().ToString() + "_" + imageFile.FileName;

        //     BlobContainerClient blobContainerClient = new BlobContainerClient(connectionString, containerName);
        //     BlobClient blobClient = blobContainerClient.GetBlobClient(uniqueBlobName);

        //     using (var memoryStream = new MemoryStream())
        //     {
        //         await imageFile.CopyToAsync(memoryStream);
        //         memoryStream.Position = 0;
        //         await blobClient.UploadAsync(memoryStream);
        //     }

        //     return blobClient.Uri.AbsoluteUri;
        // }
    }
}
