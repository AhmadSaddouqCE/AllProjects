using Microsoft.AspNetCore.Mvc.ModelBinding;
using Microsoft.EntityFrameworkCore;
using PreClinic.Data;
using PreClinic.Dto;

namespace PreClinic.Services
{
    public class BranchService
    {
        private readonly DataContext _context;
        public BranchService(DataContext context)
        {
            _context = context;
        }

        public async Task<(bool, int)> addBranch(Branch branch)
        {
            using var transaction = await _context.Database.BeginTransactionAsync();

            try
            {
                var checkCategory = await _context.SystemLookupsCategory.
                    Where(Code => Code.categoryCode == "Branches Name").
                    FirstOrDefaultAsync();
                if (checkCategory is null)
                {
                    var newCategory = new SystemLookupsCategory()
                    {
                        categoryCode = "Branches Name",
                        categoryNameE = "Branches",
                        categoryNameA = "الأفرع"
                    };
                    await _context.SystemLookupsCategory.AddAsync(newCategory);
                    await Save();
                    var newBranch = new Branch()
                    {
                        branchNameA = branch.branchNameA,
                        branchNameE = branch.branchNameE,
                    };
                    await _context.Branches.AddAsync(newBranch);
                    await Save();

                    var newLookup = new SystemLookups()
                    {
                        categoryId = newCategory.CategoryId,
                        lookupNameE = newBranch.branchNameE,
                        lookupNameA = newBranch.branchNameA,

                    };
                    await _context.SystemLookups.AddAsync(newLookup);
                    await transaction.CommitAsync();
                    await Save();
                    return (true, newBranch.branchId);

                }
                else
                {
                    var newBranch = new Branch()
                    {
                        branchNameA = branch.branchNameA,
                        branchNameE = branch.branchNameE,
                    };
                    await _context.Branches.AddAsync(newBranch);
                    await Save();

                    var newLookup = new SystemLookups()
                    {
                        categoryId = checkCategory.CategoryId,
                        lookupNameE = newBranch.branchNameE,
                        lookupNameA = newBranch.branchNameA,

                    };
                    await _context.SystemLookups.AddAsync(newLookup);
                    await transaction.CommitAsync();
                    await Save();
                    return (true, newBranch.branchId);
                }
            }
            catch (Exception ex)
            {
                if (ex.InnerException != null) throw new Exception("This Branch Does Exist");
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
        public async Task<List<Branch>> getBranches()
        {
            return await _context.Branches.AsNoTracking().ToListAsync();
        }
        public async Task<List<DepartmentBranchesDto>> getDepartmentInBranches(int? branchId)
        {
            var departmentList = new List<DepartmentBranchesDto>();
            var getBranch = await _context.Branches.FindAsync(branchId);
            if (getBranch is null) throw new Exception("This Branch Doesn't Exist");
            var departmentBranches = await _context.DepartmentBranches.
                 Where(id => id.branchId == branchId)
                .ToListAsync();
            foreach (var departmentBranch in departmentBranches)
            {
                var getDepartment = await _context.Department.
                    FindAsync(departmentBranch.departmentId);
                if (getDepartment is null) throw new Exception("This Department Doesn't Exist");
                var newDepartmentBranch = new DepartmentBranchesDto
                {
                    departmentName = getDepartment.departmentNameE,
                    departmentId = getDepartment.departmentId
                };
                departmentList.Add(newDepartmentBranch);
            }
            return departmentList;
        }
        public async Task<bool> Save()
        {
            var saved = await _context.SaveChangesAsync();
            return saved > 0 ? true : false;
        }
    }
}
