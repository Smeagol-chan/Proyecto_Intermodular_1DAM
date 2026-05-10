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