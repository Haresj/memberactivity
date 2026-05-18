using memberactivity.Data.Entities;

namespace memberactivity.Data.Repositories;

public interface IEducationConfigurationRepository
{
    Task<IReadOnlyList<EducationLevelMaster>> GetActiveEducationLevelsAsync(CancellationToken cancellationToken = default);

    Task<EducationLevelMaster?> GetActiveEducationLevelAsync(int educationLevelId, CancellationToken cancellationToken = default);

    Task<IReadOnlyList<EducationFieldConfiguration>> GetFieldConfigurationsAsync(int educationLevelId, bool visibleOnly = false, CancellationToken cancellationToken = default);
}
