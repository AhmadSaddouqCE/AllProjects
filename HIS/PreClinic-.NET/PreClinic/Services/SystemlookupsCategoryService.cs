using Microsoft.AspNetCore.Mvc.ModelBinding;
using Microsoft.EntityFrameworkCore;
using PreClinic.Data;

namespace PreClinic.Services
{
    public class SystemlookupsCategoryService
    {
        private readonly DataContext _context;
        public SystemlookupsCategoryService(DataContext context)
        {
            _context = context;
        }
        public async Task<List<SystemLookupsCategory>> getCategories()
        {
            return await _context.SystemLookupsCategory.AsNoTracking().ToListAsync();
        }
        public async Task<bool> addCategory(SystemLookupsCategory category)
        {
            var newCategory = new SystemLookupsCategory()
            {
                categoryCode = category.categoryCode,
                categoryNameA = category.categoryNameA,
                categoryNameE = category.categoryNameE,
            };
            await _context.SystemLookupsCategory.AddAsync(newCategory);
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
    }
}
