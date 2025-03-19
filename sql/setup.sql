CREATE DATABASE Test;
GO

CREATE LOGIN Oscar WITH PASSWORD = 'SecurePassword123!';
CREATE LOGIN Hannah WITH PASSWORD = 'AnotherSecurePassword456!';
GO

USE Test;
GO

CREATE USER Oscar FOR LOGIN Oscar;
CREATE USER Hannah FOR LOGIN Hannah;
GO

ALTER ROLE db_datareader ADD MEMBER Oscar;
ALTER ROLE db_datareader ADD MEMBER Hannah;
GO

CREATE TABLE Orders (
    id INT IDENTITY(1,1) PRIMARY KEY,
    username NVARCHAR(100) NOT NULL,
    orderid INT NOT NULL,
    privacyLevel INT NOT NULL,
    info NVARCHAR(255)
);
GO

INSERT INTO Orders (username, orderid, privacyLevel, info)
VALUES 
('Oscar', 1001, 1, 'Order details for Oscar #1'),
('Oscar', 1002, 1, 'Order details for Oscar #2'),
('Hannah', 1003, 1, 'Order details for Hannah #1'),
('Oscar', 1004, 3, 'Order details for Oscar #3'),
('Oscar', 1005, 2, 'Order details for Oscar #4'),
('Hannah', 1006, 2, 'Order details for Hannah #2');
GO

CREATE FUNCTION dbo.f_Orders(@username varchar(max))
RETURNS TABLE
WITH SCHEMABINDING
AS RETURN SELECT 1 AS fn_securitypredicate_result
WHERE @username = CAST(SESSION_CONTEXT(N'preferred_username') AS varchar(max));
GO

CREATE SECURITY POLICY dbo.SecurityPolicy_Orders
ADD FILTER PREDICATE dbo.f_Orders(username)
ON dbo.Orders;
GO
