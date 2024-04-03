using Microsoft.AspNetCore.Mvc.ModelBinding;
using Microsoft.EntityFrameworkCore;
using PreClinic.Data;

namespace PreClinic.Services
{
    public class DepartmentService
    {
        private readonly DataContext _context;
        public DepartmentService(DataContext context)
        {
            _context = context;
        }
        public async Task<List<Department>> getAllDepartments()
        {
            return await _context.Department.AsNoTracking().ToListAsync();
        }
        public async Task<(bool, int)> addDepartment(Department department)
        {
            using var transaction = await _context.Database.BeginTransactionAsync();

            try
            {
                var checkCategory = await _context.SystemLookupsCategory.
                    Where(Code => Code.categoryCode == "Departments Name").
                    FirstOrDefaultAsync();
                if (checkCategory is null)
                {
                    var newCategory = new SystemLookupsCategory()
                    {
                        categoryCode = "Departments Name",
                        categoryNameE = "Departments",
                        categoryNameA = "الأقسام"
                    };
                    await _context.SystemLookupsCategory.AddAsync(newCategory);
                    await Save();
                    var newDepartment = new Department()
                    {
                        departmentNameA = department.departmentNameA,
                        departmentNameE = department.departmentNameE,
                    };
                    await _context.Department.AddAsync(newDepartment);
                    await Save();

                    var newLookup = new SystemLookups()
                    {
                        categoryId = newCategory.CategoryId,
                        lookupNameE = newDepartment.departmentNameE,
                        lookupNameA = newDepartment.departmentNameA,
                    };
                    await _context.SystemLookups.AddAsync(newLookup);
                    await transaction.CommitAsync();
                    await Save();
                    return (true, newDepartment.departmentId);
                }
                else
                {
                    var newDepartment = new Department()
                    {
                        departmentNameA = department.departmentNameA,
                        departmentNameE = department.departmentNameE,
                    };
                    await _context.Department.AddAsync(newDepartment);
                    await Save();

                    var newLookup = new SystemLookups()
                    {
                        categoryId = checkCategory.CategoryId,
                        lookupNameE = newDepartment.departmentNameE,
                        lookupNameA = newDepartment.departmentNameA,
                    };
                    await _context.SystemLookups.AddAsync(newLookup);
                    await transaction.CommitAsync();
                    await Save();
                    return (true, newDepartment.departmentId);
                }
            }
            catch (Exception ex)
            {
                await transaction.RollbackAsync();
                throw new Exception("Failed To Add Category");

            }
        }
        public async Task<string> ValidateModelAsync(ModelStateDictionary modelState)
        {
            var firstError = modelState.Values
                .SelectMany(v => v.Errors)
                .FirstOrDefault(e => !string.IsNullOrEmpty(e.ErrorMessage));

            if (firstError is not null) return firstError.ErrorMessage;

            return await Task.FromResult(string.Empty);
        }
        public async Task<bool> Save()
        {
            var saved = await _context.SaveChangesAsync();
            return saved > 0 ? true : false;
        }
    }
}
