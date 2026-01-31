CREATE TABLE dbo.Users (
    Id          INT            IDENTITY(1,1) PRIMARY KEY,
    FirstName   NVARCHAR(50)   NOT NULL,
    LastName    NVARCHAR(50)   NOT NULL,
    PhoneNumber NVARCHAR(20)   NOT NULL,
    Username    NVARCHAR(50)   NOT NULL,
    Password    NVARCHAR(255)  NOT NULL,  -- stores BCrypt hashes
    Email       NVARCHAR(100)  NOT NULL,
    Role        NVARCHAR(20)   NOT NULL,
    IsActive    BIT            NOT NULL DEFAULT (1),
    CONSTRAINT UQ_Users_Username UNIQUE (Username),
    CONSTRAINT UQ_Users_Email    UNIQUE (Email)
);

CREATE TABLE dbo.Category (
    Id   INT           IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE dbo.Product (
    Id            INT           IDENTITY(1,1) PRIMARY KEY,
    Name          NVARCHAR(100) NOT NULL,
    Description   NVARCHAR(MAX) NULL,
    Price         INT           NOT NULL,                 -- consumed with GetInt32
    Image         NVARCHAR(255) NULL,
    Stock         INT           NOT NULL DEFAULT (0),
    CategoryId    INT           NOT NULL,
    DistributorId INT           NULL,
    IsActive      INT           NOT NULL DEFAULT (1),
    CONSTRAINT CK_Product_IsActive CHECK (IsActive IN (0,1)),
    CONSTRAINT FK_Product_Category FOREIGN KEY (CategoryId) REFERENCES dbo.Category(Id),
    CONSTRAINT FK_Product_Distributor FOREIGN KEY (DistributorId) REFERENCES dbo.Users(Id)
);

CREATE TABLE dbo.Cart (
    UserId    INT NOT NULL,
    ProductId INT NOT NULL,
    Qty       INT NOT NULL DEFAULT (1),
    CONSTRAINT PK_Cart PRIMARY KEY (UserId, ProductId),
    CONSTRAINT FK_Cart_User    FOREIGN KEY (UserId) REFERENCES dbo.Users(Id)    ON DELETE CASCADE,
    CONSTRAINT FK_Cart_Product FOREIGN KEY (ProductId) REFERENCES dbo.Product(Id) ON DELETE CASCADE
);

CREATE TABLE dbo.[Order] (
    Id              INT           IDENTITY(1,1) PRIMARY KEY,
    UserId          INT           NOT NULL,
    Total           INT           NOT NULL,
    DeliveryAddress NVARCHAR(MAX) NOT NULL,
    Status          NVARCHAR(50)  NOT NULL DEFAULT ('Pending'),
    CreatedAt       DATETIME      NOT NULL DEFAULT (GETDATE()),
    CONSTRAINT FK_Order_User FOREIGN KEY (UserId) REFERENCES dbo.Users(Id)
);

CREATE TABLE dbo.Order_Items (
    OrderId   INT NOT NULL,
    ProductId INT NOT NULL,
    Qty       INT NOT NULL,
    CONSTRAINT PK_OrderItems PRIMARY KEY (OrderId, ProductId),
    CONSTRAINT FK_OrderItems_Order   FOREIGN KEY (OrderId)   REFERENCES dbo.[Order](Id)   ON DELETE CASCADE,
    CONSTRAINT FK_OrderItems_Product FOREIGN KEY (ProductId) REFERENCES dbo.Product(Id)
);

CREATE TABLE dbo.Quotation (
    Id            INT          IDENTITY(1,1) PRIMARY KEY,
    DistributorId INT          NOT NULL,
    Status        NVARCHAR(50) NOT NULL DEFAULT ('Pending'),
    CreatedAt     DATETIME     NOT NULL DEFAULT (GETDATE()),
    CONSTRAINT FK_Quotation_Distributor FOREIGN KEY (DistributorId) REFERENCES dbo.Users(Id)
);

CREATE TABLE dbo.QuotationItem (
    QuotationId INT            NOT NULL,
    ProductId   INT            NOT NULL,
    Qty         INT            NOT NULL,
    Price       DECIMAL(18, 2) NOT NULL,
    CONSTRAINT PK_QuotationItem PRIMARY KEY (QuotationId, ProductId),
    CONSTRAINT FK_QuotationItem_Quotation FOREIGN KEY (QuotationId) REFERENCES dbo.Quotation(Id) ON DELETE CASCADE,
    CONSTRAINT FK_QuotationItem_Product   FOREIGN KEY (ProductId)   REFERENCES dbo.Product(Id)
);

CREATE TABLE dbo.Contact_Messages (
    Id        INT           IDENTITY(1,1) PRIMARY KEY,
    Timestamp DATETIME      NOT NULL DEFAULT (GETDATE()),
    Subject   NVARCHAR(200) NOT NULL,
    Message   NVARCHAR(MAX) NOT NULL,
    UserId    INT           NOT NULL,
    CONSTRAINT FK_ContactMessages_User FOREIGN KEY (UserId) REFERENCES dbo.Users(Id)
);

INSERT INTO Category (Name) VALUES
('Mobile Phones'),
('Laptops'),
('Accessories');

INSERT INTO Product
(Name, Description, Price, Stock, CategoryId, DistributorId)
VALUES
('iPhone 14', 'Apple smartphone', 350000, 10, 1, 2),
('Dell XPS', 'Laptop', 420000, 5, 2, 2);

