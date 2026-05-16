USE RoadReadyDB;
GO

-- 1. Ensure the procedure exists
CREATE OR ALTER PROCEDURE sp_DeleteVehicle
    @VehicleID INT
AS
BEGIN
    DELETE FROM Vehicles WHERE VehicleID = @VehicleID;
END;
GO

-- 2. Run the Test
PRINT '--- TEST 4: Selling the Hyundai Accent (VehicleID 8) ---';
EXEC sp_DeleteVehicle 8;
GO