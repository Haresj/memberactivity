using System.Text.RegularExpressions;
using memberactivity.Data.Entities;
using memberactivity.Data.Repositories;
using memberactivity.ViewModels.Education;
using Microsoft.AspNetCore.Mvc.ModelBinding;

namespace memberactivity.Services;

public sealed class EducationConfigurationService : IEducationConfigurationService
{
    private readonly IEducationConfigurationRepository _repository;

    public EducationConfigurationService(IEducationConfigurationRepository repository)
    {
        _repository = repository;
    }

    public async Task<EducationFormViewModel> BuildFormAsync(int? educationLevelId, IDictionary<string, string?>? postedValues = null, CancellationToken cancellationToken = default)
    {
        var levels = await _repository.GetActiveEducationLevelsAsync(cancellationToken);
        var selectedLevelId = educationLevelId ?? levels.FirstOrDefault()?.EducationLevelId;

        return new EducationFormViewModel
        {
            EducationLevelId = selectedLevelId,
            EducationLevels = levels.Select(level => new EducationLevelOptionViewModel
            {
                EducationLevelId = level.EducationLevelId,
                Name = level.Name
            }).ToList(),
            Fields = selectedLevelId.HasValue
                ? (await GetFieldsAsync(selectedLevelId.Value, postedValues, cancellationToken)).ToList()
                : new List<DynamicEducationFieldViewModel>(),
            Values = postedValues is null
                ? new Dictionary<string, string?>(StringComparer.OrdinalIgnoreCase)
                : new Dictionary<string, string?>(postedValues, StringComparer.OrdinalIgnoreCase)
        };
    }

    public async Task<IReadOnlyList<DynamicEducationFieldViewModel>> GetFieldsAsync(int educationLevelId, IDictionary<string, string?>? values = null, CancellationToken cancellationToken = default)
    {
        var configurations = await _repository.GetFieldConfigurationsAsync(educationLevelId, visibleOnly: true, cancellationToken);

        return configurations.Select(configuration => MapField(configuration, values)).ToList();
    }

    public async Task ValidateAsync(int? educationLevelId, IDictionary<string, string?> values, ModelStateDictionary modelState, CancellationToken cancellationToken = default)
    {
        if (!educationLevelId.HasValue)
        {
            modelState.AddModelError(nameof(EducationFormViewModel.EducationLevelId), "Education Level is required.");
            return;
        }

        var level = await _repository.GetActiveEducationLevelAsync(educationLevelId.Value, cancellationToken);
        if (level is null)
        {
            modelState.AddModelError(nameof(EducationFormViewModel.EducationLevelId), "Select a valid active Education Level.");
            return;
        }

        // Validation is driven entirely by EducationFieldConfiguration rows; no education level names are hardcoded here.
        var fields = await _repository.GetFieldConfigurationsAsync(educationLevelId.Value, visibleOnly: true, cancellationToken);
        foreach (var field in fields)
        {
            values.TryGetValue(field.FieldName, out var rawValue);
            var value = rawValue?.Trim();
            var modelStateKey = $"Values[{field.FieldName}]";

            if (field.IsRequired && string.IsNullOrWhiteSpace(value))
            {
                modelState.AddModelError(modelStateKey, field.RequiredMessage ?? $"{field.DisplayName} is required.");
                continue;
            }

            if (string.IsNullOrWhiteSpace(value))
            {
                continue;
            }

            if (field.MinLength.HasValue && value.Length < field.MinLength.Value)
            {
                modelState.AddModelError(modelStateKey, field.MinLengthMessage ?? $"{field.DisplayName} must be at least {field.MinLength} characters.");
            }

            if (field.MaxLength.HasValue && value.Length > field.MaxLength.Value)
            {
                modelState.AddModelError(modelStateKey, field.MaxLengthMessage ?? $"{field.DisplayName} must be no more than {field.MaxLength} characters.");
            }

            if (!string.IsNullOrWhiteSpace(field.RegexPattern) && !Regex.IsMatch(value, field.RegexPattern, RegexOptions.None, TimeSpan.FromSeconds(1)))
            {
                modelState.AddModelError(modelStateKey, field.RegexMessage ?? $"{field.DisplayName} is not in a valid format.");
            }
        }
    }

    private static DynamicEducationFieldViewModel MapField(EducationFieldConfiguration configuration, IDictionary<string, string?>? values)
    {
        values?.TryGetValue(configuration.FieldName, out var postedValue);

        return new DynamicEducationFieldViewModel
        {
            FieldName = configuration.FieldName,
            DisplayName = configuration.DisplayName,
            ControlType = configuration.ControlType,
            IsVisible = configuration.IsVisible,
            IsRequired = configuration.IsRequired,
            IsEditable = configuration.IsEditable,
            DefaultValue = configuration.DefaultValue,
            Placeholder = configuration.Placeholder,
            RequiredMessage = configuration.RequiredMessage ?? $"{configuration.DisplayName} is required.",
            RegexPattern = configuration.RegexPattern,
            RegexMessage = configuration.RegexMessage,
            MinLength = configuration.MinLength,
            MinLengthMessage = configuration.MinLengthMessage,
            MaxLength = configuration.MaxLength,
            MaxLengthMessage = configuration.MaxLengthMessage,
            DisplayOrder = configuration.DisplayOrder,
            Value = postedValue ?? configuration.DefaultValue
        };
    }
}
