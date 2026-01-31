INSERT INTO Category (Name) VALUES
('Mobile Phones'),
('Laptops'),
('Accessories'),
('Tablets');

CREATE TABLE Product (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Price INT NOT NULL,
    Image NVARCHAR(255),
    CategoryId INT NOT NULL,
    FOREIGN KEY (CategoryId) REFERENCES Category(Id)
);
INSERT INTO Product (Name, Price, Image, CategoryId) VALUES
('iPhone 14', 350000, 'iphone.jpg', 1),
('Dell XPS 13', 420000, 'dell.jpg', 2),
('Wireless Mouse', 4500, 'mouse.jpg', 3);

ALTER TABLE Product
ADD IsActive BIT NOT NULL DEFAULT 1;

CREATE TABLE Cart (
    UserId INT NOT NULL,
    ProductId INT NOT NULL,
    Qty INT NOT NULL DEFAULT 1,
    PRIMARY KEY (UserId, ProductId),
    FOREIGN KEY (UserId) REFERENCES Users(Id),
    FOREIGN KEY (ProductId) REFERENCES Product(Id)
);
CREATE TABLE [Order] (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    UserId INT NOT NULL,
    Total INT NOT NULL,
    DeliveryAddress NVARCHAR(MAX) NOT NULL,
    Status NVARCHAR(50) NOT NULL,
    CreatedAt DATETIME NOT NULL,
    FOREIGN KEY (UserId) REFERENCES Users(Id)
);