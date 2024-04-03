using Microsoft.AspNetCore.Mvc.ModelBinding;
using Microsoft.EntityFrameworkCore;
using PreClinic.Data;
using PreClinic.Dto;

namespace PreClinic.Services
{
    public class SystemlookupsService
    {
        private readonly DataContext _context;
        public SystemlookupsService(DataContext context)
        {
            _context = context;
        }
        public async Task<bool> Save()
        {
            var saved = await _context.SaveChangesAsync();
            return saved > 0 ? true : false;
        }
        public async Task<List<SystemLookups>> getSystemlookups()
        {
            return await _context.SystemLookups.AsNoTracking().ToListAsync();
        }
        public async Task<List<HandleCodeItemsControllerDto>> getItemsBasedOnCode(int? categoryCodeId)
        {
            var getCategory = await _context.SystemLookupsCategory.
                Where(Id => Id.CategoryId == categoryCodeId)
                .FirstOrDefaultAsync();
            if (getCategory is null || getCategory.categoryCode is null) throw new Exception("No Categories Available");
            var getSystemlookups = await _context.SystemLookups.
                Where(id => id.categoryId == getCategory.CategoryId)
                .ToListAsync();
            if (getSystemlookups is null) throw new Exception("No Lookups Available");
            var newList = new List<HandleCodeItemsControllerDto>();
            if (getCategory.categoryCode.Equals("Branches Name"))
            {
                foreach (var items in getSystemlookups)
                {
                    var assignItems = new HandleCodeItemsControllerDto()
                    {
                        lookupsId = items.LookupId,
                        nameEn = items.lookupNameE,
                        nameAr = items.lookupNameA,
                    };
                    newList.Add(assignItems);
                }
                return newList;

            }
            else if (getCategory.categoryCode.Equals("Departments Name"))
            {
                foreach (var items in getSystemlookups)
                {
                    var assignItems = new HandleCodeItemsControllerDto()
                    {
                        lookupsId = items.LookupId,
                        nameEn = items.lookupNameE,
                        nameAr = items.lookupNameA,
                    };
                    newList.Add(assignItems);
                }
                return newList;
            }
            return newList;
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
