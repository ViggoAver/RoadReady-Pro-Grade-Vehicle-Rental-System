USE RoadReadyDB;
GO

-- AddCustomer PROCEDURE
CREATE OR ALTER PROCEDURE sp_AddCustomer
	@FirstName VARCHAR(50),
	@LastName VARCHAR(50),
	@LicenseNumber VARCHAR(20),
	@ContactNumber VARCHAR(15)
AS
BEGIN
	INSERT INTO Customers (FirstName, LastName, LicenseNumber, ContactNumber)
	VALUES (@FirstName, @LastName, @LicenseNumber, @ContactNumber);
END;
GO

--ProcessRental PROCEDURE
CREATE OR ALTER PROCEDURE sp_ProcessRental
	@VehicleID INT,
	@CustomerID INT,
	@RentalDate DATE,
	@ExpectedReturnDate DATE
AS
BEGIN
	INSERT INTO Rentals (VehicleID, CustomerID, RentalDate, ExpectedReturnDate) VALUES
	(@VehicleID, @CustomerID, @RentalDate, @ExpectedReturnDate);

	UPDATE Vehicles
	SET IsAvailable = 0
	WHERE VehicleID = @VehicleID;
END;
GO

-- ReturnVehicle PROCEDURE
CREATE OR ALTER PROCEDURE sp_ReturnVehicle
	@RentalID INT,
	@ActualReturnDate DATE,
	@TotalCost DECIMAL(10,2),
	@PenaltyFee DECIMAL(10,2)
AS
BEGIN
	-- 1. Update the rental record with final dates and costs
	UPDATE Rentals
	SET ActualReturnDate = @ActualReturnDate,
		TotalCost = @TotalCost,
		PenaltyFee = @PenaltyFee
	WHERE RentalID = @RentalID;

	-- 2. Find which vehicle was just returned
	DECLARE @ReturnedVehicleID INT;
	SELECT @ReturnedVehicleID = VehicleID FROM Rentals WHERE RentalID = @RentalID;

	-- 3. Mark that vehicle as available again
	UPDATE Vehicles
	SET IsAvailable = 1
	WHERE VehicleID = @ReturnedVehicleID;
END;
GO

--DeleteVehicle PROCEDURE
CREATE OR ALTER PROCEDURE sp_DeleteVehicle
	@VehicleID INT
AS
BEGIN
	DELETE FROM Vehicles WHERE VehicleID = @VehicleID;
END;
GO