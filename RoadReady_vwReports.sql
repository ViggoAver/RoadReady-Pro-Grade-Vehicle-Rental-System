--RoadReady View SQL (for reports)

--Active Rentals
CREATE OR ALTER VIEW vw_ActiveRentals AS
SELECT
	r.RentalID,
	c.FirstName + ' ' + c.LastName AS CustomerName,
	c.ContactNumber,
	v.Make + ' ' + v.VehicleModel AS VehicleRented,
	v.PlateNumber,
	r.RentalDate,
	r.ExpectedreturnDate
FROM
	Rentals r
JOIN Customers c ON r.CustomerID = c.CustomerID
JOIN Vehicles v ON r.VehicleID = v.VehicleID
WHERE
	r.ActualReturnDate IS NULL; -- Only shows vehicles that haven't been rented
GO

--Available Vehicles
CREATE OR ALTER VIEW vw_AvailableVehicles AS
SELECT
	VehicleID,
	Make,
	vehicleModel,
	Category,
	PlateNumber,
	DailyRate
FROM
	Vehicles
WHERE
	IsAvailable = 1 AND NeedsMaintenance = 0;
GO


--Rental History and Revenue

CREATE OR ALTER VIEW vw_RentalHistory AS
SELECT
	r.RentalID,
	c.FirstName + ' ' + c.LastName AS CustomerName,
	v.Make + ' ' + v.VehicleModel AS VehicleRented,
	v.Category,
	r.RentalDate,
	r.ActualReturnDate,
	r.TotalCost,
	r.PenaltyFee
FROM
	Rentals r
JOIN Customers c ON r.CustomerID = c.CustomerID
JOIN Vehicles v ON r.VehicleID = v.VehicleID
WHERE
	r.ActualReturnDate IS NOT NULL;
GO

SELECT * FROM vw_ActiveRentals;
SELECT * FROM vw_AvailableVehicles;
SELECT * FROM vw_RentalHistory;