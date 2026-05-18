using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace memberactivity.Data.Entities;

[Table("EducationLevelMaster")]
public sealed class EducationLevelMaster
{
    [Key]
    public int EducationLevelId { get; set; }

    [Required]
    [StringLength(150)]
    public string Name { get; set; } = string.Empty;

    public bool IsActive { get; set; } = true;

    public int DisplayOrder { get; set; }

    public ICollection<EducationFieldConfiguration> FieldConfigurations { get; set; } = new List<EducationFieldConfiguration>();
}
