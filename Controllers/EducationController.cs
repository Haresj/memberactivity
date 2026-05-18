using memberactivity.Services;
using memberactivity.ViewModels.Education;
using Microsoft.AspNetCore.Mvc;

namespace memberactivity.Controllers;

public sealed class EducationController : Controller
{
    private readonly IEducationConfigurationService _educationConfigurationService;

    public EducationController(IEducationConfigurationService educationConfigurationService)
    {
        _educationConfigurationService = educationConfigurationService;
    }

    [HttpGet]
    public async Task<IActionResult> EducationForm(int? educationLevelId, CancellationToken cancellationToken)
    {
        var model = await _educationConfigurationService.BuildFormAsync(educationLevelId, cancellationToken: cancellationToken);
        return View(model);
    }

    [HttpGet]
    public async Task<IActionResult> Fields(int educationLevelId, CancellationToken cancellationToken)
    {
        var fields = await _educationConfigurationService.GetFieldsAsync(educationLevelId, cancellationToken: cancellationToken);
        return PartialView("_EducationFields", fields);
    }

    [HttpGet]
    public async Task<IActionResult> Configuration(int educationLevelId, CancellationToken cancellationToken)
    {
        var fields = await _educationConfigurationService.GetFieldsAsync(educationLevelId, cancellationToken: cancellationToken);
        return Ok(new
        {
            educationLevelId,
            fields = fields.Select(field => new
            {
                field.FieldName,
                field.DisplayName,
                field.ControlType,
                field.IsVisible,
                field.IsRequired,
                field.IsEditable,
                field.DefaultValue,
                field.Placeholder,
                field.RequiredMessage,
                field.RegexPattern,
                field.RegexMessage,
                field.MinLength,
                field.MinLengthMessage,
                field.MaxLength,
                field.MaxLengthMessage,
                field.DisplayOrder
            })
        });
    }

    [HttpPost]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> EducationForm(EducationFormViewModel model, CancellationToken cancellationToken)
    {
        model.Values ??= new Dictionary<string, string?>(StringComparer.OrdinalIgnoreCase);

        await _educationConfigurationService.ValidateAsync(model.EducationLevelId, model.Values, ModelState, cancellationToken);

        if (!ModelState.IsValid)
        {
            var invalidModel = await _educationConfigurationService.BuildFormAsync(model.EducationLevelId, model.Values, cancellationToken);
            return View(invalidModel);
        }

        // Persist the submitted education payload in your application table here. The submitted values are already
        // validated using the same DB configuration that rendered the UI.
        TempData["SuccessMessage"] = "Education details validated successfully.";
        return RedirectToAction(nameof(EducationForm), new { educationLevelId = model.EducationLevelId });
    }
}
