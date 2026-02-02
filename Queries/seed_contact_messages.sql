-- Seed sample contact messages for the distributor account (dist1)
-- Run against GadgetHubDB

SET NOCOUNT ON;

DECLARE @UserId INT = (
    SELECT TOP (1) Id
    FROM dbo.Users
    WHERE Username = 'dist1'
);

IF @UserId IS NULL
BEGIN
    THROW 60000, 'User dist1 not found. Create the distributor user first.', 1;
END;

-- Avoid duplicating recent seed data
IF EXISTS (
    SELECT 1
    FROM dbo.Contact_Messages
    WHERE UserId = @UserId
      AND Timestamp >= DATEADD(DAY, -14, GETDATE())
)
BEGIN
    PRINT 'Recent contact messages already exist for dist1. Seed skipped.';
    RETURN;
END;

INSERT INTO dbo.Contact_Messages (Timestamp, Subject, Message, UserId)
VALUES
(DATEADD(DAY, -5,  GETDATE()), 'Order follow-up', 'Checking on the status of my bulk order.', @UserId),
(DATEADD(DAY, -3,  GETDATE()), 'Product catalog', 'Please share the updated product catalog PDF.', @UserId),
(DATEADD(DAY, -1,  GETDATE()), 'Pricing inquiry', 'Can we get revised pricing for high-volume items?', @UserId),
(DATEADD(HOUR, -6, GETDATE()), 'Support', 'Experiencing delays in order updates; please advise.', @UserId);

PRINT 'Sample contact messages seeded successfully for dist1.';
