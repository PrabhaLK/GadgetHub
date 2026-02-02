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