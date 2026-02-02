-- GadgetHubDB dump (schema + data) generated 2026-02-02 12:25:18Z
GO

GO

--- DATA EXPORT START ---
SET IDENTITY_INSERT Users ON
INSERT INTO Users (Id,FirstName,LastName,PhoneNumber,Username,Password,Email,Role,IsActive) VALUES (1,'Admin','User','0712356473','admin','$2a$11$BGHxkz8x5mEIjFujBT1QNeND32JBXejYEgniLwkSvAhygUn/GRLnG','admin@test.com','Admin',1);
INSERT INTO Users (Id,FirstName,LastName,PhoneNumber,Username,Password,Email,Role,IsActive) VALUES (2,'Dist','One','0112345678','dist1','$2a$11$neACZMjKTCbBzz9PdORBDulcfwfYqL0Uyk9S245c/hXQpoLYzD0t.','dist@test.com','Distributor',1);
INSERT INTO Users (Id,FirstName,LastName,PhoneNumber,Username,Password,Email,Role,IsActive) VALUES (4,'Jane','Doe','0712345678','janedoe@gmail.com','$2a$11$SF5UISgxgxrTAt4R8o3FIOBKaC2wzN6QLHNUtBSr4GHg.rZnjAB0G','janedoe@gmail.com','customer',1);
SET IDENTITY_INSERT Users OFF
GO
SET IDENTITY_INSERT Category ON
INSERT INTO Category (Id,Name) VALUES (1,'Mobile Phones');
INSERT INTO Category (Id,Name) VALUES (2,'Laptops');
INSERT INTO Category (Id,Name) VALUES (3,'Accessories');
SET IDENTITY_INSERT Category OFF
GO
SET IDENTITY_INSERT Product ON
INSERT INTO Product (Id,Name,Description,Price,Stock,CategoryId,DistributorId,IsActive) VALUES (2,'Samsung Galaxy S23','Flagship Android smartphone with Dynamic AMOLED display',289900,25,1,2,1);
INSERT INTO Product (Id,Name,Description,Price,Stock,CategoryId,DistributorId,IsActive) VALUES (3,'Google Pixel 8','Google Tensor powered camera phone',245000,18,1,2,1);
INSERT INTO Product (Id,Name,Description,Price,Stock,CategoryId,DistributorId,IsActive) VALUES (4,'MacBook Air M2','13-inch Apple silicon laptop',475000,12,2,2,1);
INSERT INTO Product (Id,Name,Description,Price,Stock,CategoryId,DistributorId,IsActive) VALUES (5,'Lenovo ThinkPad X1 Carbon','Business ultrabook with carbon fiber chassis',385000,15,2,2,1);
INSERT INTO Product (Id,Name,Description,Price,Stock,CategoryId,DistributorId,IsActive) VALUES (6,'Sony WH-1000XM5','Wireless noise-cancelling headphones',139900,30,3,2,1);
INSERT INTO Product (Id,Name,Description,Price,Stock,CategoryId,DistributorId,IsActive) VALUES (7,'Logitech MX Master 3S','Advanced wireless mouse',29999,40,3,2,1);
INSERT INTO Product (Id,Name,Description,Price,Stock,CategoryId,DistributorId,IsActive) VALUES (8,'Samsung Galaxy Tab S9','11-inch AMOLED Android tablet',225000,20,1,2,1);
INSERT INTO Product (Id,Name,Description,Price,Stock,CategoryId,DistributorId,IsActive) VALUES (9,'Apple Watch Series 9','Smartwatch with health monitoring',175000,35,3,2,1);
SET IDENTITY_INSERT Product OFF
GO
INSERT INTO Cart (UserId,ProductId,Qty) VALUES (4,2,1);
INSERT INTO Cart (UserId,ProductId,Qty) VALUES (4,3,1);
GO
SET IDENTITY_INSERT [Order] ON
INSERT INTO [Order] (Id,UserId,Total,DeliveryAddress,Status,CreatedAt) VALUES (1,4,534900,'Default Address (Or retrieve from user profile later)','Pending','2026-02-01T21:41:39.977');
SET IDENTITY_INSERT [Order] OFF
GO
INSERT INTO Order_Items (OrderId,ProductId,Qty) VALUES (1,2,1);
INSERT INTO Order_Items (OrderId,ProductId,Qty) VALUES (1,3,1);
GO
SET IDENTITY_INSERT Quotation ON
INSERT INTO Quotation (Id,DistributorId,Status,CreatedAt) VALUES (1,2,'Pending','2026-01-27T00:00:00');
INSERT INTO Quotation (Id,DistributorId,Status,CreatedAt) VALUES (2,2,'Approved','2026-01-31T00:00:00');
INSERT INTO Quotation (Id,DistributorId,Status,CreatedAt) VALUES (3,2,'Pending','2026-02-01T16:01:35.887');
SET IDENTITY_INSERT Quotation OFF
GO
INSERT INTO QuotationItem (QuotationId,ProductId,Qty,Price) VALUES (1,2,5,275405.00);
INSERT INTO QuotationItem (QuotationId,ProductId,Qty,Price) VALUES (1,3,3,220500.00);
INSERT INTO QuotationItem (QuotationId,ProductId,Qty,Price) VALUES (2,3,10,215600.00);
INSERT INTO QuotationItem (QuotationId,ProductId,Qty,Price) VALUES (2,4,6,437000.00);
INSERT INTO QuotationItem (QuotationId,ProductId,Qty,Price) VALUES (3,2,2,289900.00);
INSERT INTO QuotationItem (QuotationId,ProductId,Qty,Price) VALUES (3,4,4,460750.00);
GO
SET IDENTITY_INSERT Contact_Messages ON
INSERT INTO Contact_Messages (Id,Timestamp,Subject,Message,UserId) VALUES (1,'2026-01-28T10:21:41.383','Order follow-up','Checking on the status of my bulk order.',2);
INSERT INTO Contact_Messages (Id,Timestamp,Subject,Message,UserId) VALUES (2,'2026-01-30T10:21:41.383','Product catalog','Please share the updated product catalog PDF.',2);
INSERT INTO Contact_Messages (Id,Timestamp,Subject,Message,UserId) VALUES (3,'2026-02-01T10:21:41.383','Pricing inquiry','Can we get revised pricing for high-volume items?',2);
INSERT INTO Contact_Messages (Id,Timestamp,Subject,Message,UserId) VALUES (4,'2026-02-02T04:21:41.383','Support','Experiencing delays in order updates; please advise.',2);
SET IDENTITY_INSERT Contact_Messages OFF
GO
