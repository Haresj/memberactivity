using System.Security.Claims;
using memberactivity.Models;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace memberactivity.Controllers;

[Authorize]
public class HomeController : Controller
{
    [HttpGet]
    public IActionResult Index()
    {
        var model = new HomeViewModel
        {
            Name = User.FindFirstValue("name") ?? User.Identity?.Name,
            Email = User.FindFirstValue("email"),
            Claims = User.Claims
                .OrderBy(c => c.Type)
                .Select(c => new ClaimViewModel { Type = c.Type, Value = c.Value })
                .ToList(),
            Tokens = new Dictionary<string, string?>
            {
                ["access_token"] = HttpContext.GetTokenAsync("access_token").GetAwaiter().GetResult(),
                ["id_token"] = HttpContext.GetTokenAsync("id_token").GetAwaiter().GetResult(),
                ["refresh_token"] = HttpContext.GetTokenAsync("refresh_token").GetAwaiter().GetResult(),
                ["expires_at"] = HttpContext.GetTokenAsync("expires_at").GetAwaiter().GetResult()
            }
        };

        return View(model);
    }
}
