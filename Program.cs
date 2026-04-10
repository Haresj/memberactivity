using System.IdentityModel.Tokens.Jwt;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication.OpenIdConnect;
using Microsoft.IdentityModel.Protocols.OpenIdConnect;

var builder = WebApplication.CreateBuilder(args);

JwtSecurityTokenHandler.DefaultMapInboundClaims = false;

builder.Services.AddControllersWithViews();

builder.Services
    .AddAuthentication(options =>
    {
        options.DefaultScheme = CookieAuthenticationDefaults.AuthenticationScheme;
        options.DefaultChallengeScheme = OpenIdConnectDefaults.AuthenticationScheme;
    })
    .AddCookie(options =>
    {
        options.LoginPath = "/Account/Login";
        options.LogoutPath = "/Account/Logout";
    })
    .AddOpenIdConnect(options =>
    {
        var keycloakSection = builder.Configuration.GetSection("Authentication:Keycloak");

        options.Authority = keycloakSection["Authority"];
        options.ClientId = keycloakSection["ClientId"];
        options.ClientSecret = keycloakSection["ClientSecret"];

        options.ResponseType = OpenIdConnectResponseType.Code;
        options.UsePkce = true;
        options.CallbackPath = "/signin-oidc";
        options.SaveTokens = true;
        options.GetClaimsFromUserInfoEndpoint = true;
        options.RequireHttpsMetadata = keycloakSection.GetValue("RequireHttpsMetadata", true);

        options.Scope.Clear();
        options.Scope.Add("openid");
        options.Scope.Add("profile");
        options.Scope.Add("email");

        options.TokenValidationParameters.NameClaimType = "name";
        options.TokenValidationParameters.RoleClaimType = "role";

        options.Events = new OpenIdConnectEvents
        {
            OnRedirectToIdentityProvider = context =>
            {
                var configuredProvider = keycloakSection["IdentityProvider"];
                if (!string.IsNullOrWhiteSpace(configuredProvider))
                {
                    context.ProtocolMessage.SetParameter("kc_idp_hint", configuredProvider);
                }

                return Task.CompletedTask;
            }
        };
    });

var app = builder.Build();

if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();

app.UseAuthentication();
app.UseAuthorization();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

app.Run();
