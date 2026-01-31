# GadgetHub

GadgetHub is a demonstration application built using a Service-Oriented Architecture (SOA) with Windows Communication Foundation (WCF). It showcases a basic user registration system for a fictional e-commerce platform, clearly separating the business logic, hosting, and presentation layers.

## Architecture

The solution is divided into three distinct projects:

*   **`GadgetHub.Service` (WCF Service Library)**: This is the core component containing the business logic. It defines the service contract (`IGadgetHubService`) and its implementation, which includes the `RegisterUser` method. This layer is responsible for interacting with the database.
*   **`GadgetHub.Host` (Console Application)**: A lightweight, self-hosting console application for the WCF service. It makes the `GadgetHubService` available over HTTP for clients to consume.
*   **`GadgetHub.Web` (ASP.NET Web Forms)**: The front-end web application that serves as the client. It includes a registration page (`Register.aspx`) that consumes the WCF service to register new users.

## Features

*   User registration with fields for name, phone number, username, password, and email.
*   Multi-project SOA implementation using WCF.
*   Self-hosted WCF service via a console application.
*   ASP.NET Web Forms client consuming the WCF service.

## Prerequisites

*   Visual Studio 2017 or later
*   .NET Framework 4.7.2
*   SQL Server (including LocalDB)

## Getting Started

Follow these instructions to get the project up and running on your local machine.

### 1. Database Setup

The application requires a SQL Server database. The connection string in the project is hardcoded to use a local `.mdf` file.

1.  **Create the Database**: In Visual Studio's "Server Explorer" or using SQL Server Management Studio, create a new database. You can name it `GadgetHubDB`.

2.  **Create the Users Table**: Execute the following SQL script against your newly created database to create the `Users` table.

    ```sql
    CREATE TABLE [dbo].[Users]
    (
        [Id]          INT           IDENTITY (1, 1) NOT NULL,
        [FirstName]   NVARCHAR (50) NOT NULL,
        [LastName]    NVARCHAR (50) NOT NULL,
        [PhoneNumber] NVARCHAR (20) NOT NULL,
        [Username]    NVARCHAR (50) NOT NULL UNIQUE,
        [Password]    NVARCHAR (50) NOT NULL,
        [Email]       NVARCHAR (100) NOT NULL,
        [Role]        NVARCHAR (20) NOT NULL,
        PRIMARY KEY CLUSTERED ([Id] ASC)
    );
    ```

3.  **Update Connection String**: Open the `GadgetHub.Service/GadgetHubService.cs` file and update the `connectionString` variable to point to your database. For example, if using LocalDB, your string might look like this:

    ```csharp
    // Before
    string connectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=D:\\SOC\\GadgetHub\\GadgetHubDB.mdf;Integrated Security=True;Connect Timeout=30;Encrypt=False";
    
    // After (Update with your correct path and server instance)
    string connectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=C:\\Your\\Path\\To\\GadgetHubDB.mdf;Integrated Security=True;Connect Timeout=30";
    ```

### 2. Build the Solution

1.  Clone the repository to your local machine:
    ```sh
    git clone https://github.com/sadanah/gadget-hub-soc.git
    ```
2.  Open the `GadgetHub.sln` file in Visual Studio.
3.  Build the solution by selecting `Build` > `Build Solution` from the menu. This will restore the necessary NuGet packages.

### 3. Run the Application

The service must be running before the web client can connect to it.

1.  **Start the WCF Service Host**: In the Solution Explorer, right-click the **`GadgetHub.Host`** project and select `Debug` -> `Start New Instance`. A console window will appear with the message: `Service is running at http://localhost:8733/GadgetHubService/`. Do not close this window.

2.  **Start the Web Client**:
    *   Right-click the **`GadgetHub.Web`** project in the Solution Explorer and select `Set as StartUp Project`.
    *   Press `F5` or click the `Start` button in Visual Studio to launch the web application.

3.  **Test Registration**:
    *   Your web browser should open. Navigate to the registration page by adding `/Register.aspx` to the URL (e.g., `https://localhost:44391/Register.aspx`).
    *   Fill in the registration form and click the "Register" button.
    *   A status message will appear indicating whether the registration was successful.