# ASP.NET Core 9 + Keycloak OIDC (Google Broker) Demo

This project uses ASP.NET Core MVC with OpenID Connect authorization code flow against Keycloak.

## Features implemented

- Custom local login page at `/Account/Login`.
- `Sign in with Google` button (no Keycloak-hosted login form).
- Forces Keycloak to redirect directly to Google via `kc_idp_hint=google`.
- Uses callback endpoint `/signin-oidc`.
- Saves OIDC tokens (`id_token`, `access_token`, optional `refresh_token`, `expires_at`).
- Displays authenticated user claims (`email`, `name`, and all available claims).
- Redirects to `/Home/Index` after successful login.
- Supports SSO behavior across multiple apps/ports by relying on Keycloak session cookies.

## Run profiles for SSO demo

You can run this app with two different launch profiles to emulate two apps:

```bash
dotnet run --launch-profile memberactivity-7172
dotnet run --launch-profile memberactivity-7173
```

If both applications are configured as Keycloak clients in the same realm and trust the same IdP broker, signing in once should allow silent sign-in on the second app.

## Configuration

Update `appsettings.json`:

- `Authentication:Keycloak:Authority`
- `Authentication:Keycloak:ClientId`
- `Authentication:Keycloak:ClientSecret`
- `Authentication:Keycloak:IdentityProvider` (defaults to `google`)

> You already configured Google + Keycloak redirect URIs in Keycloak/Google console, so no extra broker setup is included in this repo.
