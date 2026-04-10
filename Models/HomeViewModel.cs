namespace memberactivity.Models;

public class HomeViewModel
{
    public string? Name { get; set; }
    public string? Email { get; set; }
    public List<ClaimViewModel> Claims { get; set; } = new();
    public Dictionary<string, string?> Tokens { get; set; } = new();
}

public class ClaimViewModel
{
    public string Type { get; set; } = string.Empty;
    public string Value { get; set; } = string.Empty;
}
