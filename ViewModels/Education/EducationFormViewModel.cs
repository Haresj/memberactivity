namespace memberactivity.ViewModels.Education;

public sealed class EducationFormViewModel
{
    public int? EducationLevelId { get; set; }

    public IReadOnlyList<EducationLevelOptionViewModel> EducationLevels { get; set; } = Array.Empty<EducationLevelOptionViewModel>();

    public List<DynamicEducationFieldViewModel> Fields { get; set; } = new();

    public Dictionary<string, string?> Values { get; set; } = new(StringComparer.OrdinalIgnoreCase);
}
