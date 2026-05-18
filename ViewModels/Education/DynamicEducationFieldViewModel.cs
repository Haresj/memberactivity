namespace memberactivity.ViewModels.Education;

public sealed class DynamicEducationFieldViewModel
{
    public string FieldName { get; init; } = string.Empty;

    public string DisplayName { get; init; } = string.Empty;

    public string ControlType { get; init; } = "text";

    public bool IsVisible { get; init; }

    public bool IsRequired { get; init; }

    public bool IsEditable { get; init; } = true;

    public string? DefaultValue { get; init; }

    public string? Placeholder { get; init; }

    public string RequiredMessage { get; init; } = string.Empty;

    public string? RegexPattern { get; init; }

    public string? RegexMessage { get; init; }

    public int? MinLength { get; init; }

    public string? MinLengthMessage { get; init; }

    public int? MaxLength { get; init; }

    public string? MaxLengthMessage { get; init; }

    public int DisplayOrder { get; init; }

    public string? Value { get; set; }

    public string InputName => $"Values[{FieldName}]";

    public string InputId => FieldName;
}
