using memberactivity.Data.Entities;
using Microsoft.EntityFrameworkCore;

namespace memberactivity.Data.Repositories;

public sealed class EducationConfigurationRepository : IEducationConfigurationRepository
{
    private readonly ApplicationDbContext _dbContext;

    public EducationConfigurationRepository(ApplicationDbContext dbContext)
    {
        _dbContext = dbContext;
    }

    public async Task<IReadOnlyList<EducationLevelMaster>> GetActiveEducationLevelsAsync(CancellationToken cancellationToken = default)
    {
        return await _dbContext.EducationLevelMasters
            .AsNoTracking()
            .Where(level => level.IsActive)
            .OrderBy(level => level.DisplayOrder)
            .ThenBy(level => level.Name)
            .ToListAsync(cancellationToken);
    }

    public async Task<EducationLevelMaster?> GetActiveEducationLevelAsync(int educationLevelId, CancellationToken cancellationToken = default)
    {
        return await _dbContext.EducationLevelMasters
            .AsNoTracking()
            .FirstOrDefaultAsync(level => level.EducationLevelId == educationLevelId && level.IsActive, cancellationToken);
    }

    public async Task<IReadOnlyList<EducationFieldConfiguration>> GetFieldConfigurationsAsync(int educationLevelId, bool visibleOnly = false, CancellationToken cancellationToken = default)
    {
        var query = _dbContext.EducationFieldConfigurations
            .AsNoTracking()
            .Where(field => field.EducationLevelId == educationLevelId);

        if (visibleOnly)
        {
            query = query.Where(field => field.IsVisible);
        }

        return await query
            .OrderBy(field => field.DisplayOrder)
            .ThenBy(field => field.DisplayName)
            .ToListAsync(cancellationToken);
    }
}
