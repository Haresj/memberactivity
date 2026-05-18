using memberactivity.Data.Entities;
using Microsoft.EntityFrameworkCore;

namespace memberactivity.Data;

public sealed class ApplicationDbContext : DbContext
{
    public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
        : base(options)
    {
    }

    public DbSet<EducationLevelMaster> EducationLevelMasters => Set<EducationLevelMaster>();

    public DbSet<EducationFieldConfiguration> EducationFieldConfigurations => Set<EducationFieldConfiguration>();

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        modelBuilder.Entity<EducationLevelMaster>(entity =>
        {
            entity.HasKey(e => e.EducationLevelId);
            entity.Property(e => e.Name).HasMaxLength(150).IsRequired();
            entity.HasIndex(e => e.Name).IsUnique();
            entity.HasIndex(e => new { e.IsActive, e.DisplayOrder });
        });

        modelBuilder.Entity<EducationFieldConfiguration>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.Property(e => e.FieldName).HasMaxLength(100).IsRequired();
            entity.Property(e => e.DisplayName).HasMaxLength(150).IsRequired();
            entity.Property(e => e.ControlType).HasMaxLength(50).IsRequired();
            entity.Property(e => e.DefaultValue).HasMaxLength(500);
            entity.Property(e => e.Placeholder).HasMaxLength(250);
            entity.Property(e => e.RequiredMessage).HasMaxLength(250);
            entity.Property(e => e.RegexPattern).HasMaxLength(500);
            entity.Property(e => e.RegexMessage).HasMaxLength(250);
            entity.Property(e => e.MinLengthMessage).HasMaxLength(250);
            entity.Property(e => e.MaxLengthMessage).HasMaxLength(250);
            entity.HasIndex(e => new { e.EducationLevelId, e.FieldName }).IsUnique();
            entity.HasIndex(e => new { e.EducationLevelId, e.DisplayOrder });

            entity.HasOne(e => e.EducationLevel)
                .WithMany(e => e.FieldConfigurations)
                .HasForeignKey(e => e.EducationLevelId)
                .OnDelete(DeleteBehavior.Cascade);
        });
    }
}
