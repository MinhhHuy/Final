CREATE DATABASE QuanLyQuanAn
GO

USE QuanLyQuanAn
GO

-- Food--
-- Table--
-- FoodCatagory--
-- Account--
-- Bill--
-- BillInfo--

CREATE TABLE TableFood
(
	id INT IDENTITY PRIMARY KEY,
	name NVARCHAR(100) NOT NULL DEFAULT N'None Table',
	status NVARCHAR(100) NOT NULL DEFAULT N'Available', -- available || not available--
	
)
GO

CREATE TABLE Account
(
	UserName NVARCHAR(100) PRIMARY KEY,
	DisplayName NVARCHAR(100) NOT NULL DEFAULT N'None',
	PassWord NVARCHAR(1000) NOT NULL DEFAULT 0,
	Type INT NOT NULL DEFAULT 0 -- 1 ADMIN && 0 STAFF
)
GO

CREATE TABLE FoodCategory
(
	id INT IDENTITY PRIMARY KEY,
	name NVARCHAR(100) NOT NULL DEFAULT N'None'
)
GO

CREATE TABLE Food
(
	id INT IDENTITY PRIMARY KEY,
	name NVARCHAR(100) NOT NULL DEFAULT N'None',
	idCategory INT NOT NULL,
	price FLOAT NOT NULL DEFAULT 0

	FOREIGN KEY (idCategory) REFERENCES dbo.FoodCategory(id)
)
GO

CREATE TABLE Bill
(
	id INT IDENTITY PRIMARY KEY,
	DateCheckIn DATE NOT NULL DEFAULT GETDATE(),
	DateCheckOut DATE,
	idTable INT NOT NULL,
	status INT NOT NULL DEFAULT 0 -- 1 paid && 0 not paid

	FOREIGN KEY (idTable) REFERENCES dbo.TableFood(id)
)
GO

CREATE TABLE BillInfo
(
	id INT IDENTITY PRIMARY KEY,
	idBill INT NOT NULL,
	idFood INT NOT NULL,
	count INT NOT NULL DEFAULT 0

	FOREIGN KEY (idBill) REFERENCES dbo.Bill(id),
	FOREIGN KEY (idFood) REFERENCES dbo.Food(id),
)
GO

CREATE PROC USP_GetAccountByUserName
@userName nvarchar(100)
AS 
BEGIN
	SELECT * FROM dbo.Account WHERE UserName = @userName
END
GO

EXEC dbo.USP_GetAccountByUserName @userName = N'pro' -- nvarchar(100)
GO

CREATE PROC USP_Login
@userName nvarchar(100), @passWord nvarchar(100)
AS
BEGIN
	SELECT * FROM dbo.Account WHERE UserName = @userName AND PassWord = @passWord
END
GO
-- add table
DECLARE @i INT =0

WHILE @i <= 10
BEGIN
INSERT dbo.TableFood
		(name)
VALUES	( N'Table ' + CAST(@i AS nvarchar(100)))
SET @i = @i +1
END

SELECT * FROM dbo.TableFood
GO

CREATE PROC USP_GetTableList
AS SELECT * FROM dbo.TableFood
GO

UPDATE dbo.TableFood SET status = N'Unavailable' WHERE id = 9
EXEC dbo.USP_GetTableList

-- add category
INSERT dbo.FoodCategory
(name)
VALUES 
(N'Sea Food')
INSERT dbo.FoodCategory
(name)
VALUES 
(N'Healthy Food')
INSERT dbo.FoodCategory
(name)
VALUES 
(N'Mexico Food')
INSERT dbo.FoodCategory
(name)
VALUES 
(N'Trump Food')
INSERT dbo.FoodCategory
(name)
VALUES 
(N'Drink')

--addFood
INSERT dbo.Food
(name, idCategory,price)
VALUES 
(N'Fish and Chips', -- name
1, -- idCategory
100000)

INSERT dbo.Food
(name, idCategory,price)
VALUES 
(N'Fish Burger', -- name
1, -- idCategory
90000)

INSERT dbo.Food
(name, idCategory,price)
VALUES 
(N'Boil Vegetable', -- name
2, -- idCategory
60000)

INSERT dbo.Food
(name, idCategory,price)
VALUES 
(N'Italian Sausage Stuffed Zucchini', -- name
2, -- idCategory
90000)

INSERT dbo.Food
(name, idCategory,price)
VALUES 
(N'Burritos with Minced Meat Filling', -- name
3, -- idCategory
100000)

INSERT dbo.Food
(name, idCategory,price)
VALUES 
(N'Tomato Salsa', -- name
3, -- idCategory
110000)

INSERT dbo.Food
(name, idCategory,price)
VALUES 
(N'McDonal Burger', -- name
4, -- idCategory
110000)

INSERT dbo.Food
(name, idCategory,price)
VALUES 
(N'Very big McDonal Burger', -- name
4, -- idCategory
140000)

INSERT dbo.Food
(name, idCategory,price)
VALUES 
(N'Pesi', -- name
5, -- idCategory
30000)

INSERT dbo.Food
(name, idCategory,price)
VALUES 
(N'Coca Cola', -- name
5, -- idCategory
30000)

-- add bill
INSERT dbo.Bill
( DateCheckIn, DateCheckOut, idTable, status)
VALUES
( GETDATE(), --DATECHECKIN
  NULL, --DATECHECKOUT
  1, -- IDTABLE
  0 -- STATUS
)

INSERT dbo.Bill
( DateCheckIn, DateCheckOut, idTable, status)
VALUES
( GETDATE(), --DATECHECKIN
  NULL, --DATECHECKOUT
  2, -- IDTABLE
  0 -- STATUS
)



INSERT dbo.Bill
( DateCheckIn, DateCheckOut, idTable, status)
VALUES
( GETDATE(), --DATECHECKIN
  GETDATE(), --DATECHECKOUT
  3, -- IDTABLE
  1 -- STATUS
)

-- add bill info

INSERT dbo.BillInfo
(idBill, idFood, count)
VALUES
( 1, -- idBill
  1, -- idFood
  2  --count
 )

 INSERT dbo.BillInfo
(idBill, idFood, count)
VALUES
( 1, -- idBill
  3, -- idFood
  4  --count
 )

 INSERT dbo.BillInfo
(idBill, idFood, count)
VALUES
( 1, -- idBill
  5, -- idFood
  1  --count
 )

 INSERT dbo.BillInfo
(idBill, idFood, count)
VALUES
( 2, -- idBill
  1, -- idFood
  2  --count
 )

 INSERT dbo.BillInfo
(idBill, idFood, count)
VALUES
( 2, -- idBill
  6, -- idFood
  2  --count
 )

 INSERT dbo.BillInfo
(idBill, idFood, count)
VALUES
( 7, -- idBill
  1, -- idFood
  2  --count
 )

 GO

SELECT * FROM dbo.Bill
SELECT * FROM dbo.BillInfo
SELECT * FROM dbo.Food
SELECT * FROM dbo.FoodCategory
DELETE FROM dbo.Food WHERE id = 30

SELECT id FROM dbo.Bill WHERE idTable = 2 and status = 0
SELECT * FROM dbo.BillInfo WHERE idBill = 2

SELECT f.name, bi.count, f.price, f.price * bi.count AS totalPrice FROM dbo.BillInfo AS bi, dbo.Bill AS b, dbo.Food AS f WHERE bi.idBill = b.id AND bi.idFood = f.id AND b.idTable = 1

GO

CREATE PROC USP_InsertBill
@idTable INT
AS
BEGIN
	INSERT dbo.Bill
	(DateCheckIn,DateCheckOut,idTable,status,discount)
	VALUES ( GETDATE(), --DateCheckIn
			 NULL, --DateCheckOut
			 @idTable, --idTable
			 0, --status
			 0 -- discount
			 )
END
GO

CREATE PROC USP_InsertBillInfo
@idBill INT, @idFood INT, @count INT
AS 
BEGIN
	 INSERT dbo.BillInfo
	(idBill, idFood, count)
	VALUES
	( @idBill, -- idBill
	 @idFood, -- idFood
	 @count  --count
		)
END
GO

CREATE PROC USP_InsertBillInfo
@idBill INT, @idFood INT, @count INT
AS
BEGIN

DECLARE @isExitsBillInfo INT;
DECLARE @foodCount INT = 1;

SELECT @isExitsBillInfo = id, @foodCount= b.count 
FROM dbo.BillInfo AS b 
WHERE idBill = @idBill AND idFood = @idFood

IF (@isExitsBillInfo > 0)
	BEGIN
		DECLARE @newCount INT = @foodCount + @count
		IF (@newCount > 0)
			UPDATE dbo.BillInfo SET count = @foodCount + @count where idFood = @idFood
		ELSE 
			DELETE dbo.BillInfo WHERE idBill = @idBill AND idFood = @idFood
	END
ELSE 
	BEGIN
		 INSERT dbo.BillInfo
			(idBill, idFood, count)
		VALUES
			( @idBill, -- idBill
				@idFood, -- idFood
				@count  --count
				)
	END
END
GO

DELETE dbo.BillInfo

DELETE dbo.Bill

UPDATE dbo.Bill SET status = 1 WHERE id =1
GO

CREATE TRIGGER UTG_UpdateBillInfo
ON dbo.BillInfo FOR INSERT, UPDATE
AS
BEGIN
	DECLARE @idBill INT

	SELECT @idBill = idBill FROM Inserted

	DECLARE @idTable INT

	SELECT @idTable = idTable FROM dbo.Bill WHERE id = @idBill AND status = 0

	DECLARE @count INT

	SELECT @count = COUNT(*) FROM dbo.BillInfo WHERE idBill = @idBill


	IF(@count > 0)
		UPDATE dbo.TableFood SET status = N'Unavailable' WHERE id = @idTable
	ELSE
		UPDATE dbo.TableFood SET status = N'Available' WHERE id = @idTable
END
GO



CREATE TRIGGER UTG_UpdateBill
ON dbo.Bill FOR UPDATE
AS
BEGIN
	DECLARE @idBill INT

	SELECT @idBill = id FROM Inserted

	DECLARE @idTable INT

	SELECT @idTable = idTable FROM dbo.Bill WHERE id = @idBill 

	DECLARE @count INT = 0

	SELECT @count = COUNT(*) FROM dbo.Bill WHERE idTable = @idTable AND status = 0

	IF (@count = 0)
		UPDATE dbo.TableFood SET status = N'Available' WHERE id = @idTable
END
GO

ALTER TABLE dbo.Bill
ADD discount INT



UPDATE dbo.Bill SET discount = 0

SELECT * FROM dbo.Bill
SELECT * FROM dbo.Food


DECLARE @idBill INT = 5
GO

CREATE PROC USP_SwitchTable
@idTable1 int, @idTable2 INT
AS
BEGIN

	DECLARE @idFirstBill INT
	DECLARE @idSecondBill INT

	DECLARE @isFirstTableEmpty INT = 1
	DECLARE @isSecondTableEmpty INT = 1

	SELECT @idSecondBill = id FROM dbo.Bill WHERE idTable = @idTable2 AND status = 0
	SELECT @idFirstBill = id FROM dbo.Bill WHERE idTable = @idTable1 AND status = 0

	IF( @idFirstBill IS NULL)
	BEGIN
		
		INSERT dbo.Bill
			( DateCheckIn, DateCheckOut, idTable, status)
		VALUES
			( GETDATE(), --DATECHECKIN
				 NULL, --DATECHECKOUT
				 @idTable1, -- IDTABLE
				 0 -- STATUS
			 )
		SELECT @idFirstBill = MAX(id) FROM dbo.Bill WHERE idTable = @idTable1 AND status = 0

	END


	SELECT @isFirstTableEmpty = COUNT(*) FROM dbo.BillInfo WHERE idBill = @idFirstBill

	IF( @idSecondBill IS NULL)
	BEGIN
		
		INSERT dbo.Bill
			( DateCheckIn, DateCheckOut, idTable, status)
		VALUES
			( GETDATE(), --DATECHECKIN
				 NULL, --DATECHECKOUT
				 @idTable2, -- IDTABLE
				 0 -- STATUS
			 )
		SELECT @idSecondBill = MAX(id) FROM dbo.Bill WHERE idTable = @idTable2 AND status = 0

		

	END

	SELECT @isSecondTableEmpty = COUNT(*) FROM dbo.BillInfo WHERE idBill = @idSecondBill

	SELECT id INTO IDBillInfoTable FROM dbo.BillInfo WHERE idBill = @idSecondBill

	UPDATE dbo.BillInfo SET idBill = @idSecondBill WHERE idBill = @idFirstBill

	UPDATE dbo.BillInfo SET idBill = @idFirstBill WHERE id IN (SELECT * FROM IDBillInfoTable)

	DROP TABLE IDBillInfoTable

	IF(@isFirstTableEmpty = 0)
		UPDATE dbo.TableFood SET status = N'Available' WHERE id = @idTable2
	IF(@isSecondTableEmpty = 0)
		UPDATE dbo.TableFood SET status = N'Available' WHERE id = @idTable1
END
GO

