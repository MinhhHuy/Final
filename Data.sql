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
  2, -- IDTABLE
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
( 3, -- idBill
  5, -- idFood
  2  --count
 )

 GO

SELECT * FROM dbo.Bill
SELECT * FROM dbo.BillInfo
SELECT * FROM dbo.Food
SELECT * FROM dbo.FoodCategory

SELECT id FROM dbo.Bill WHERE idTable = 2 and status = 0
SELECT * FROM dbo.BillInfo WHERE idBill = 2

SELECT f.name, bi.count, f.price, f.price * bi.count AS totalPrice FROM dbo.BillInfo AS bi, dbo.Bill AS b, dbo.Food AS f WHERE bi.idBill = b.id AND bi.idFood = f.id AND b.idTable = 1