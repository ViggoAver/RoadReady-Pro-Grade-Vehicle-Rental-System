-- RoadReady: Pro-Grade Vehicle Rental System (SQL)


-- DATABASE ESTABLISH
CREATE DATABASE RoadReadyDB;
GO

USE RoadReadyDB;
GO


-- TABLE CREATION
CREATE TABLE Vehicles 
(
	VehicleID INT IDENTITY(1,1) PRIMARY KEY,
	Make VARCHAR(50) NOT NULL,
	VehicleModel VARCHAR(50) NOT NULL,
	Category VARCHAR(30) NOT NULL, -- (e.g. SUV, Van, etc.)
	PlateNumber VARCHAR(15) UNIQUE NOT NULL,
	DailyRate DECIMAL(10,2) NOT NULL,
	IsAvailable BIT DEFAULT 1, -- 1 == Avalaible, 0 == Not
	NeedsMaintenance BIT DEFAULT 0 -- 1 == In Shop, 0 == Good to go
);

-- CUSTOMERS TABLE
CREATE TABLE Customers 
(
	CustomerID INT IDENTITY(1, 1) PRIMARY KEY,
	FirstName VARCHAR(50) NOT NULL,
	LastName VARCHAR(50) NOT NULL,
	LicenseNumber VARCHAR(20) UNIQUE NOT NULL,
	ContactNumber VARCHAR(15) NOT NULL
);

-- RENTALS TABLE
CREATE TABLE Rentals 
(
	RentalID INT IDENTITY(1,1) PRIMARY KEY,
	VehicleID INT FOREIGN KEY REFERENCES Vehicles(VehicleID),
	CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID),
	RentalDate DATE NOT NULL,
	ExpectedReturnDate DATE NOT NULL,
	ActualReturnDate DATE NULL,
	TotalCost DECIMAL (10,2) NULL,
	PenaltyFee DECIMAL(10,2) DEFAULT 0.00
);
GO

--	VEHICLES TEST DATA

INSERT INTO Vehicles(Make, VehicleModel, Category, PlateNumber, DailyRate, IsAvailable, NeedsMaintenance) VALUES
	('Toyota', 'Vios', 'Sedan', 'ABC-1234', 1500.00, 1, 0),
	('Toyota', 'Innova', 'MPV', 'DEF-5678', 2500.00, 1, 0),
	('Ford', 'Everest', 'SUV', 'GHI-9012', 3500.00, 1, 0),
	('Honda', 'Civic', 'Sedan', 'JKL-3456', 2000.00, 1, 0),
	('Mitsubishi', 'Montero', 'SUV', 'MNO-7890', 3200.00, 1, 0),
	('Nissan', 'Urvan', 'Van', 'PQR-1122', 4000.00, 1, 0),
	('Suzuki', 'Ertiga', 'MPV', 'STU-3344', 2200.00, 1, 0),
	('Hyundai', 'Accent', 'Sedan', 'VWX-5566', 1400.00, 1, 0),
	('Ford', 'Ranger', 'Pickup', 'YZA-7788', 3000.00, 0, 1),
	('Toyota', 'Fortuner', 'SUV', 'BCD-9900', 3600.00, 0, 0);


-- CUSTOMERS TEST DATA

INSERT INTO Customers (FirstName, LastName, LicenseNumber, ContactNumber) VALUES
	('John', 'Doe', 'N01-23-456789', '09171234567'),
	('Jane', 'Smith', 'N02-98-765432', '09189876543'),
	('Mark', 'Reyes', 'N03-11-222333', '09191122334'),
	('Maria', 'Cruz', 'N04-44-555666', '09204455667'),
	('Paul', 'Bautista', 'N05-77-888999', '09217788990');


-- RENTALS TEST DATA

INSERT INTO Rentals (VehicleID, CustomerID, RentalDate, ExpectedReturnDate, ActualReturnDate, TotalCost) VALUES
	(10, 1, '2026-05-15', '2026-05-20', NULL, NULL),
	(2, 3, '2026-05-14', '2026-05-18', NULL, NULL),
	(6, 5, '2026-05-16', '2026-05-22', NULL, NULL);
GO


-- PRINT
SELECT * FROM Vehicles;

SELECT * FROM Customers;

SELECT * FROM Rentals;

GO