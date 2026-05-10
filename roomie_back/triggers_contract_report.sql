USE ROOMIE
GO
----------------------------------------------------------CONTRACT--------------------------------------------------------------------------------
-- Checks if both room and tenant exist before commiting the insertion.
-- If a contract is inserted in CONTRACT table and it's status is 'Ongoing', the related room status is update to 'Rented'.
CREATE OR ALTER TRIGGER NEW_CONTRACT_INSERTED
ON [CONTRACT]
INSTEAD OF INSERT
AS
BEGIN
	DECLARE @SignatureDate AS DATE
		, @TenantDni AS CHAR(9)
		, @RoomNumber AS TINYINT
		, @PropertyAddress AS VARCHAR(150)
		, @PropertyCityID AS SMALLINT
		, @PricePerMonth AS SMALLMONEY
		, @StartingDate AS DATE
		, @EndingDate AS DATE
		, @Status AS CHAR(7)
		, @RoomStatus AS CHAR(12)

	SELECT @SignatureDate = SignatureDate, @TenantDni = TenantDni, @RoomNumber = RoomNumber
		, @PropertyAddress = PropertyAddress, @PropertyCityID = PropertyCityID, @PricePerMonth = PricePerMonth
		, @StartingDate = StartingDate, @EndingDate = EndingDate, @Status = Status
	FROM inserted

	SELECT @RoomStatus = Status
	FROM ROOM 
	WHERE RoomNumber = @RoomNumber
		AND PropertyAddress = @PropertyAddress
		AND PropertyCityID = @PropertyCityID

	IF @RoomStatus IS NOT NULL
		AND EXISTS (SELECT * FROM TENANT WHERE Dni = @TenantDni)
	BEGIN
		IF @Status = 'Ongoing'
		BEGIN
			IF @RoomStatus = 'Available'
				AND NOT EXISTS (SELECT * FROM [CONTRACT] WHERE TenantDni = @TenantDni AND Status = 'Ongoing')
			BEGIN
				UPDATE ROOM
				SET Status = 'Rented'
				WHERE RoomNumber = @RoomNumber
					AND PropertyAddress = @PropertyAddress
					AND PropertyCityID = @PropertyCityID
			END
			ELSE
			BEGIN
				SET @Status = 'Error'
			END
		END
		
		INSERT INTO [CONTRACT] (SignatureDate, TenantDni, RoomNumber, PropertyAddress, PropertyCityID, PricePerMonth, StartingDate, EndingDate, Status)
		VALUES (@SignatureDate, @TenantDni, @RoomNumber, @PropertyAddress, @PropertyCityID, @PricePerMonth, @StartingDate, @EndingDate, @Status)
	END
END
GO

-- Updates the room status when a contract ends
CREATE OR ALTER TRIGGER CONTRACT_STATUS_UPDATED
ON [CONTRACT]
AFTER UPDATE
AS
BEGIN
	DECLARE @OldStatus AS CHAR(7) = (SELECT Status FROM deleted)
		, @NewStatus AS CHAR(7)
		, @RoomNumber AS TINYINT
		, @PropertyAddress AS VARCHAR(150)
		, @PropertyCityID AS SMALLINT

	SELECT @NewStatus = Status, @RoomNumber = RoomNumber, @PropertyAddress = PropertyAddress, @PropertyCityID = PropertyCityID
	FROM inserted

	IF @OldStatus = 'Ongoing' AND @NewStatus = 'Ended'
	BEGIN
		UPDATE ROOM
		SET Status = 'Available'
		WHERE RoomNumber = @RoomNumber
			AND PropertyAddress = @PropertyAddress
			AND PropertyCityID = @PropertyCityID
	END
END
GO

-- The update is avoided if t any attribute besides the status is update
CREATE OR ALTER TRIGGER CONTRACT_PROHIBITTED_UPDATES
ON [CONTRACT]
INSTEAD OF UPDATE
AS
BEGIN
	DECLARE @ContractID AS INT

		, @NewSignatureDate AS DATE
		, @NewTenantDni AS CHAR(9)
		, @NewRoomNumber AS TINYINT
		, @NewPropertyAddress AS VARCHAR(150)
		, @NewPropertyCityID AS SMALLINT
		, @NewPricePerMonth AS SMALLMONEY
		, @NewStartingDate AS DATE
		, @NewEndingDate AS DATE
		, @NewStatus AS CHAR(7)

		, @OldSignatureDate AS DATE
		, @OldTenantDni AS CHAR(9)
		, @OldRoomNumber AS TINYINT
		, @OldPropertyAddress AS VARCHAR(150)
		, @OldPropertyCityID AS SMALLINT
		, @OldPricePerMonth AS SMALLMONEY
		, @OldStartingDate AS DATE
		, @OldEndingDate AS DATE
		, @OldStatus AS CHAR(7)

	SELECT @OldSignatureDate = SignatureDate
		, @OldTenantDni = TenantDni
		, @OldRoomNumber = RoomNumber
		, @OldPropertyAddress = PropertyAddress
		, @OldPropertyCityID = PropertyCityID
		, @OldPricePerMonth = PricePerMonth
		, @OldStartingDate = StartingDate
		, @OldEndingDate = EndingDate
		, @OldStatus = Status
	FROM deleted

	SELECT @NewSignatureDate = SignatureDate
		, @NewTenantDni = TenantDni
		, @NewRoomNumber = RoomNumber
		, @NewPropertyAddress = PropertyAddress
		, @NewPropertyCityID = PropertyCityID
		, @NewPricePerMonth = PricePerMonth
		, @NewStartingDate = StartingDate
		, @NewEndingDate = EndingDate
		, @NewStatus = Status
		, @ContractID = ContractID
	FROM inserted

	IF @NewSignatureDate = @OldSignatureDate
		AND @NewTenantDni = @OldTenantDni
		AND @NewRoomNumber = @OldRoomNumber
		AND @NewPropertyAddress = @OldPropertyAddress
		AND @NewPropertyCityID = @OldPropertyCityID
		AND @NewPricePerMonth = @OldPricePerMonth
		AND @NewStartingDate = @OldStartingDate
		AND @NewEndingDate = @OldEndingDate
		AND @NewStatus <> @OldStatus
	BEGIN
		UPDATE [CONTRACT]
		SET Status = @NewStatus
		WHERE ContractID = @ContractID
	END
END
GO

-- No deletes are permitted on CONTRACTS
CREATE OR ALTER TRIGGER DELETE_CONTRACT_BLOCKADE
ON [CONTRACT]
INSTEAD OF DELETE
AS
BEGIN
	PRINT 'Deletes over CONTRACT are not permitted.'
END
GO

--------------------------------------------------------------------REPORT---------------------------------------------------------
-- Checks if the user and the room exist and if the user is related to the reported room.
CREATE OR ALTER TRIGGER NEW_REPORT_INSERTED
ON REPORT
INSTEAD OF INSERT
AS
BEGIN
	DECLARE @ReportDate AS DATETIME
		, @UserDni AS CHAR(9)
		, @RoomNumber AS TINYINT
		, @PropertyAddress AS VARCHAR(150)
		, @PropertyCityID AS SMALLINT
		, @Issue AS CHAR(20)
		, @Details AS VARCHAR(300)
		, @Status AS CHAR(7)

	SELECT @ReportDate = ReportDate
		, @UserDni = UserDni
		, @RoomNumber = RoomNumber
		, @PropertyAddress = PropertyAddress
		, @PropertyCityID = PropertyCityID
		, @Issue = Issue
		, @Details = Details
		, @Status = Status
	FROM inserted

	IF EXISTS (
			SELECT * 
			FROM ROOM 
			WHERE RoomNumber = @RoomNumber
				AND PropertyAddress = @PropertyAddress
				AND PropertyCityID = @PropertyCityID
			)
		AND EXISTS (
			SELECT *
			FROM [USER]
			WHERE @UserDni = Dni
			)
	BEGIN
		IF EXISTS (
				SELECT *
				FROM PROPERTY
				WHERE Address = @PropertyAddress
					AND CityID = @PropertyCityID
					AND OwnerDni = @UserDni
				)
			OR (@Status = 'Pending'
				AND EXISTS (
						SELECT *
						FROM [CONTRACT]
						WHERE RoomNumber = @RoomNumber
							AND PropertyAddress = @PropertyAddress
							AND PropertyCityID = @PropertyCityID
							AND TenantDni = @UserDni
							AND Status = 'Ongoing'
						))
			OR (@Status = 'Checked'
				AND EXISTS (
						SELECT *
						FROM [CONTRACT]
						WHERE RoomNumber = @RoomNumber
							AND PropertyAddress = @PropertyAddress
							AND PropertyCityID = @PropertyCityID
							AND TenantDni = @UserDni
						))
		BEGIN
			INSERT INTO REPORT (ReportDate, UserDni, RoomNumber, PropertyAddress, PropertyCityID, Issue, Details, Status)
			VALUES (@ReportDate, @UserDni, @RoomNumber, @PropertyAddress, @PropertyCityID, @Issue, @Details, @Status)
		END
	END
END
GO

-- The update is avoided if t any attribute besides the status is update
CREATE OR ALTER TRIGGER REPORT_PROHIBITTED_UPDATES
ON REPORT
INSTEAD OF UPDATE
AS
BEGIN
	DECLARE @ReportID AS INT

		, @NewReportDate AS DATETIME
		, @NewUserDni AS CHAR(9)
		, @NewRoomNumber AS TINYINT
		, @NewPropertyAddress AS VARCHAR(150)
		, @NewPropertyCityID AS SMALLINT
		, @NewIssue AS CHAR(20)
		, @NewDetails AS VARCHAR(300)
		, @NewStatus AS CHAR(7)

		, @OldReportDate AS DATETIME
		, @OldUserDni AS CHAR(9)
		, @OldRoomNumber AS TINYINT
		, @OldPropertyAddress AS VARCHAR(150)
		, @OldPropertyCityID AS SMALLINT
		, @OldIssue AS CHAR(20)
		, @OldDetails AS VARCHAR(300)
		, @OldStatus AS CHAR(7)

	SELECT @ReportID = ReportID
		, @NewReportDate = ReportDate
		, @NewUserDni = UserDni
		, @NewRoomNumber = RoomNumber
		, @NewPropertyAddress = PropertyAddress
		, @NewPropertyCityID = PropertyCityID
		, @NewIssue = Issue
		, @NewDetails = Details
		, @NewStatus = Status
	FROM inserted

	SELECT @OldReportDate = ReportDate
		, @OldUserDni = UserDni
		, @OldRoomNumber = RoomNumber
		, @OldPropertyAddress = PropertyAddress
		, @OldPropertyCityID = PropertyCityID
		, @OldIssue = Issue
		, @OldDetails = Details
		, @OldStatus = Status
	FROM deleted

	IF @OldReportDate = @NewReportDate
		AND @OldUserDni = @NewUserDni
		AND @OldRoomNumber = @NewRoomNumber
		AND @OldPropertyAddress = @NewPropertyAddress
		AND @OldPropertyCityID = @NewPropertyCityID
		AND @OldIssue = @NewIssue
		AND @OldDetails = @NewDetails
		AND @OldStatus <> @NewStatus
	BEGIN
		UPDATE REPORT
		SET Status = @NewStatus
		WHERE @ReportID = ReportID
	END
END
GO

-- No deletes are permitted on REPORTS
CREATE OR ALTER TRIGGER DELETE_REPORT_BLOCKADE
ON REPORT
INSTEAD OF DELETE
AS
BEGIN
	PRINT 'Deletes over REPORT are not permitted.'
END
GO