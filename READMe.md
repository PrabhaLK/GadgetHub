# GadgetHub

Service-oriented e-commerce demo built with WCF and ASP.NET Web Forms. It separates service, host, and web UI into distinct projects and includes admin, distributor, and customer-facing areas with recent UI refreshes.

## Solution layout

- GadgetHub.Service — WCF service library with business logic, data access, DTOs, and service contracts.
- GadgetHub.Host — Console host exposing the WCF service at http://localhost:8733/GadgetHubService/.
- GadgetHub.Web — ASP.NET Web Forms client (admin, distributor, customer flows; login/register; dashboards).
- Queries — Handy SQL seed scripts (quotations, contact messages, etc.).

## Key features

- Auth with roles (Admin, Distributor, Customer) and BCrypt password storage.
- Admin: users, products, orders, quotations, contact messages — all restyled with the new glass UI.
- Distributor: dashboard, quotations (editable line items), orders, contact messages — same design system.
- Customer: login/register and basic purchasing flows (cart/orders).
- SQL Server persistence (LocalDB by default) with seed data for quicker demos.

## Prerequisites

- Visual Studio 2019+ (or 2017 if you prefer) with .NET Framework 4.7.2 SDK.
- SQL Server / LocalDB accessible as (localdb)\MSSQLLocalDB (default in code).

## Configure database

1) Ensure a database named `GadgetHubDB` exists on your SQL instance.
2) Connection string is in GadgetHub.Service/GadgetHubService.cs — update if you are not using LocalDB:

```csharp
private readonly string connectionString =
    @"Server=(localdb)\MSSQLLocalDB;
      Database=GadgetHubDB;
      Trusted_Connection=True;";
```

3) Apply schema: use final-schema.sql (top-level) to create tables and minimal seed products/categories.
   Example:

```sh
sqlcmd -S "(localdb)\MSSQLLocalDB" -d GadgetHubDB -i "final-schema.sql"
```

4) Optional demo data:
   - Seed quotations: Queries/seed_distributor_quotations.sql
   - Seed contact messages: Queries/seed_contact_messages.sql

## Running the app

1) Start the service host: set GadgetHub.Host as startup and run (Debug ▶ Start New Instance). Keep it running.
2) Start the web client: set GadgetHub.Web as startup and run (F5). Default landing is Login.aspx.
3) Log in:
   - Admin (example): use your created admin account.
   - Distributor: dist1 / corresponding password (check Users table for email dist@test.com if needed).
   - Customers: create via Register.aspx or seed your own.

## Useful paths

- Service endpoint config: GadgetHub.Host/App.config
- Web client endpoint: GadgetHub.Web/Web.config (points to http://localhost:8733/GadgetHubService/)
- Core service code/connection string: GadgetHub.Service/GadgetHubService.cs
- Admin UI pages: GadgetHub.Web/GHAdmin
- Distributor UI pages: GadgetHub.Web/GHDistributor
- Seeds: Queries/seed_distributor_quotations.sql, Queries/seed_contact_messages.sql

## Notes

- If you change the service URL or binding, update the Web.config endpoint accordingly.
- After code-behind changes, rebuild and restart the web site to pick up the updates (session-dependent pages rely on fresh logins).