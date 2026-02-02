-- Seed sample quotations for the first available distributor user
-- Run this script against the GadgetHub database

SET NOCOUNT ON;

DECLARE @DistributorId INT = (
    SELECT TOP (1) Id
    FROM dbo.Users
    WHERE Role = 'Distributor'
    ORDER BY Id
);

IF @DistributorId IS NULL
BEGIN
    THROW 50000, 'No distributor user found. Please create a distributor account before seeding quotations.', 1;
END;

IF NOT EXISTS (
    SELECT 1
    FROM dbo.Product
    WHERE DistributorId = @DistributorId
)
BEGIN
    THROW 50001, 'No products found for the selected distributor. Add products assigned to this distributor before seeding quotations.', 1;
END;

-- Avoid duplicating the seed if it has already been applied
IF EXISTS (
    SELECT 1
    FROM dbo.Quotation
    WHERE DistributorId = @DistributorId
      AND Status IN ('Pending', 'Approved')
      AND CreatedAt >= DATEADD(DAY, -14, GETDATE())
)
BEGIN
    PRINT 'Recent quotations already exist for this distributor. Seed skipped.';
    RETURN;
END;

DECLARE @Products TABLE (
    RowNum INT IDENTITY(1, 1),
    ProductId INT,
    UnitPrice DECIMAL(18, 2)
);

INSERT INTO @Products (ProductId, UnitPrice)
SELECT Id, CAST(Price AS DECIMAL(18, 2))
FROM dbo.Product
WHERE DistributorId = @DistributorId
ORDER BY Id;

DECLARE @ProductCount INT = (SELECT COUNT(*) FROM @Products);
IF @ProductCount < 2
BEGIN
    THROW 50002, 'At least two distributor products are required to seed sample quotations.', 1;
END;

DECLARE @QuoteIds TABLE (RowNum INT IDENTITY(1, 1), QuotationId INT);

INSERT INTO dbo.Quotation (DistributorId, Status, CreatedAt)
OUTPUT INSERTED.Id INTO @QuoteIds (QuotationId)
VALUES
(@DistributorId, 'Pending',  DATEADD(DAY, -6,  CONVERT(date, GETDATE()))),
(@DistributorId, 'Approved', DATEADD(DAY, -2,  CONVERT(date, GETDATE()))),
(@DistributorId, 'Pending',  DATEADD(HOUR, -18, GETDATE()));

DECLARE @Quote1 INT = (SELECT QuotationId FROM @QuoteIds WHERE RowNum = 1);
DECLARE @Quote2 INT = (SELECT QuotationId FROM @QuoteIds WHERE RowNum = 2);
DECLARE @Quote3 INT = (SELECT QuotationId FROM @QuoteIds WHERE RowNum = 3);

-- Helper function to pull product ids by row number
DECLARE @Prod1 INT = (SELECT ProductId FROM @Products WHERE RowNum = 1);
DECLARE @Price1 DECIMAL(18, 2) = (SELECT UnitPrice FROM @Products WHERE RowNum = 1);
DECLARE @Prod2 INT = (SELECT ProductId FROM @Products WHERE RowNum = 2);
DECLARE @Price2 DECIMAL(18, 2) = (SELECT UnitPrice FROM @Products WHERE RowNum = 2);
DECLARE @Prod3 INT = (SELECT ProductId FROM @Products WHERE RowNum = CASE WHEN @ProductCount >= 3 THEN 3 ELSE 1 END);
DECLARE @Price3 DECIMAL(18, 2) = (SELECT UnitPrice FROM @Products WHERE RowNum = CASE WHEN @ProductCount >= 3 THEN 3 ELSE 1 END);

INSERT INTO dbo.QuotationItem (QuotationId, ProductId, Qty, Price)
VALUES
(@Quote1, @Prod1, 5, @Price1 * 0.95),
(@Quote1, @Prod2, 3, @Price2 * 0.90),
(@Quote2, @Prod2, 10, @Price2 * 0.88),
(@Quote2, @Prod3, 6, @Price3 * 0.92),
(@Quote3, @Prod1, 2, @Price1),
(@Quote3, @Prod3, 4, @Price3 * 0.97);

PRINT 'Sample distributor quotations seeded successfully.';
