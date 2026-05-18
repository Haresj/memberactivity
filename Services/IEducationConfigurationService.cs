using memberactivity.ViewModels.Education;
using Microsoft.AspNetCore.Mvc.ModelBinding;

namespace memberactivity.Services;

public interface IEducationConfigurationService
{
    Task<EducationFormViewModel> BuildFormAsync(int? educationLevelId, IDictionary<string, string?>? postedValues = null, CancellationToken cancellationToken = default);

    Task<IReadOnlyList<DynamicEducationFieldViewModel>> GetFieldsAsync(int educationLevelId, IDictionary<string, string?>? values = null, CancellationToken cancellationToken = default);

    Task ValidateAsync(int? educationLevelId, IDictionary<string, string?> values, ModelStateDictionary modelState, CancellationToken cancellationToken = default);
}
