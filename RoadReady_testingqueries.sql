USE RoadReadyDB;
GO

-- ==========================================
-- TEST 1: Add a New Customer
-- ==========================================
PRINT '--- TEST 1: Adding Clark Kent ---';
EXEC sp_AddCustomer 'Clark', 'Kent', 'N06-99-000111', '09221234567';

-- Verify: You should now see Clark Kent at the bottom of the list (CustomerID 6)
SELECT * FROM Customers;
GO

-- ==========================================
-- TEST 2: Process a New Rental
-- ==========================================
PRINT '--- TEST 2: Clark Kent rents the Toyota Vios (VehicleID 1) ---';
-- Parameters: VehicleID (1), CustomerID (6), RentalDate, ExpectedReturnDate
EXEC sp_ProcessRental 1, 6, '2026-05-17', '2026-05-19';

-- Verify: Look at the Rentals table for the new record. 
-- Then look at the Vehicles table: Vehicle 1's "IsAvailable" should now be 0!
SELECT * FROM Rentals;
SELECT VehicleID, Make, VehicleModel, IsAvailable FROM Vehicles WHERE VehicleID = 1;
GO

-- ==========================================
-- TEST 3: Return a Vehicle
-- ==========================================
PRINT '--- TEST 3: John Doe returns the Toyota Fortuner (RentalID 1) ---';
-- Parameters: RentalID (1), ActualReturnDate, TotalCost, PenaltyFee
EXEC sp_ReturnVehicle 1, '2026-05-20', 18000.00, 0.00;

-- Verify: Look at RentalID 1, it should now have an ActualReturnDate and TotalCost.
-- Then look at Vehicle 10: "IsAvailable" should be flipped back to 1!
SELECT * FROM Rentals WHERE RentalID = 1;
SELECT VehicleID, Make, VehicleModel, IsAvailable FROM Vehicles WHERE VehicleID = 10;
GO

-- ==========================================
-- TEST 4: Delete a Vehicle
-- ==========================================
PRINT '--- TEST 4: Selling the Hyundai Accent (VehicleID 8) ---';
-- Parameters: VehicleID (8)
EXEC sp_DeleteVehicle 8;

-- Verify: VehicleID 8 should be completely gone from the inventory.
SELECT * FROM Vehicles;
GO