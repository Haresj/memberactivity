using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace memberactivity.Data.Entities;

[Table("EducationFieldConfiguration")]
public sealed class EducationFieldConfiguration
{
    [Key]
    public int Id { get; set; }

    public int EducationLevelId { get; set; }

    [Required]
    [StringLength(100)]
    public string FieldName { get; set; } = string.Empty;

    [Required]
    [StringLength(150)]
    public string DisplayName { get; set; } = string.Empty;

    [Required]
    [StringLength(50)]
    public string ControlType { get; set; } = "text";

    public bool IsVisible { get; set; } = true;

    public bool IsRequired { get; set; }

    public bool IsEditable { get; set; } = true;

    [StringLength(500)]
    public string? DefaultValue { get; set; }

    [StringLength(250)]
    public string? Placeholder { get; set; }

    [StringLength(250)]
    public string? RequiredMessage { get; set; }

    [StringLength(500)]
    public string? RegexPattern { get; set; }

    [StringLength(250)]
    public string? RegexMessage { get; set; }

    public int? MinLength { get; set; }

    [StringLength(250)]
    public string? MinLengthMessage { get; set; }

    public int? MaxLength { get; set; }

    [StringLength(250)]
    public string? MaxLengthMessage { get; set; }

    public int DisplayOrder { get; set; }

    public EducationLevelMaster? EducationLevel { get; set; }
}
