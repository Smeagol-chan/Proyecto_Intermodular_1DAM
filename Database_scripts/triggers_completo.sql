USE ROOMIE
GO

CREATE OR ALTER TRIGGER SET_ROOM_STATUS
ON ROOM
AFTER INSERT
AS
BEGIN
	DECLARE @Number AS TINYINT
		, @Address AS VARCHAR(150)
		, @CityID AS SMALLINT
		, @Type AS CHAR(15)
		, @Status AS CHAR(12)

	SELECT @Number = RoomNumber, @Address = PropertyAddress, @CityID = PropertyCityID, @Type = Type
	FROM inserted

	IF @Type = 'Bedroom'
	BEGIN
		SET @Status = 'Available'
	END
	ELSE
	BEGIN
		SET @Status = 'Shared Space'
	END

	UPDATE ROOM
	SET Status = @Status
	WHERE RoomNumber = @Number
		AND PropertyAddress = @Address
		AND PropertyCityID = @CityID
END
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

----------------------------------------------------------------------------
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

------------------------------------------------------------------------------
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

----------------------------------------------------------------------------
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

-------------------------------------------------------------
CREATE OR ALTER TRIGGER CHECK_NUM_PROVINCES_ON_INSERT_TRIGGER
ON PROVINCE
INSTEAD OF INSERT
AS
BEGIN
	IF 51 > (SELECT COUNT(*) FROM PROVINCE)
	BEGIN
		DECLARE @ID AS CHAR(2)
			, @Name AS CHAR(26)

		SELECT @ID = ProvinceID, @Name = ProvinceName
		FROM inserted

		INSERT INTO PROVINCE (ProvinceID, ProvinceName)
		VALUES (@ID, @Name)
	END
END
GO

----------------------------------------------------------------
CREATE OR ALTER TRIGGER CITY_DELETE_TRIGGER
ON CITY
INSTEAD OF DELETE
AS
BEGIN
	DECLARE @ID AS SMALLINT = (SELECT CityID FROM deleted)

	DELETE FROM INSTITUTION
	WHERE CityID = @ID

	DELETE FROM PROPERTY
	WHERE CityID = @ID

	DELETE FROM CITY
	WHERE CityID = @ID
END
GO

-----------------------------------------------------------------
CREATE OR ALTER TRIGGER INSTITUTION_DELETE_TRIGGER
ON INSTITUTION
INSTEAD OF DELETE
AS
BEGIN
	DECLARE @ID AS SMALLINT = (SELECT InstitutionID FROM deleted)

	DELETE FROM PROPERTY_INSITUTION
	WHERE InstitutionID = @ID

	DELETE FROM INSTITUTION
	WHERE InstitutionID = @ID
END
GO

-------------------------------------------------------------------
CREATE OR ALTER TRIGGER PROPERTY_DELETE_TRIGGER
ON PROPERTY
INSTEAD OF DELETE
AS
BEGIN
	DECLARE @Address AS VARCHAR(150)
		, @CityID AS SMALLINT

	SELECT @Address = Address, @CityID = CityID
	FROM deleted

	DELETE FROM PROPERTY_INSITUTION
	WHERE PropertyAddress = @Address
		AND PropertyCityID = @CityID

	DELETE FROM ROOM
	WHERE PropertyAddress = @Address
		AND PropertyCityID = @CityID

	DELETE FROM PROPERTY
	WHERE Address = @Address
		AND CityID = @CityID
END
GO

--------------------------------------------------------------
CREATE OR ALTER TRIGGER OWNER_DELETE_TRIGGER
ON [OWNER]
INSTEAD OF DELETE
AS
BEGIN
	DECLARE @Dni AS CHAR(9) = (SELECT Dni FROM deleted)

	DELETE FROM [USER]
	WHERE Dni = @Dni
END
GO

CREATE OR ALTER TRIGGER TENANT_DELETE_TRIGGER
ON TENANT
INSTEAD OF DELETE
AS
BEGIN
	DECLARE @Dni AS CHAR(9) = (SELECT Dni FROM deleted)

	DELETE FROM [USER]
	WHERE Dni = @Dni
END
GO

---------------------------------------------------------
CREATE OR ALTER TRIGGER ROOM_DELETE_TRIGGER
ON ROOM
INSTEAD OF DELETE
AS
BEGIN
	DECLARE @RoomNumber AS TINYINT
		, @Address AS VARCHAR(150)
		, @CityID AS SMALLINT

	SELECT @RoomNumber = RoomNumber, @Address = PropertyAddress, @CityID = PropertyCityID
	FROM deleted

	DELETE FROM ROOM_FURNITURE
	WHERE @RoomNumber = RoomNumber
		AND @Address = PropertyAddress
		AND @CityID = PropertyCityID

	DELETE FROM [CONTRACT]
	WHERE @RoomNumber = RoomNumber
		AND @Address = PropertyAddress
		AND @CityID = PropertyCityID

	DELETE FROM ROOM
	WHERE @RoomNumber = RoomNumber
		AND @Address = PropertyAddress
		AND @CityID = PropertyCityID
END
GO

--------------------------------------------------

CREATE OR ALTER TRIGGER FURNITURE_DELETE_TRIGGER
ON FURNITURE
INSTEAD OF DELETE
AS
BEGIN
	DECLARE @ID AS SMALLINT = (SELECT FurnitureID FROM deleted)

	DELETE FROM ROOM_FURNITURE
	WHERE FurnitureID = @ID

	DELETE FROM FURNITURE
	WHERE FurnitureID = @ID
END
GO

--------------------------------------------------
CREATE OR ALTER TRIGGER USER_DELETE_TRIGGER
ON [USER]
INSTEAD OF DELETE
AS
BEGIN
	DECLARE @Dni AS CHAR(9) = (SELECT Dni FROM [USER])

	IF EXISTS (SELECT * FROM TENANT WHERE Dni = @Dni)
	BEGIN
		DELETE FROM [CONTRACT]
		WHERE TenantDni = @Dni
	END
	ELSE
	BEGIN
		IF EXISTS (SELECT * FROM [OWNER] WHERE Dni = @Dni)
		BEGIN
			DELETE FROM PROPERTY
			WHERE OwnerDni = @Dni
		END
	END

	DELETE FROM REPORT
	WHERE UserDni = @Dni

	DELETE FROM [USER]
	WHERE Dni = @Dni
END
GO