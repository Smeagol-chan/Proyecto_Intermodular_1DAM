USE ROOMIE
GO

CREATE OR ALTER TRIGGER SET_ROOM_STATUS
ON ROOM
AFTER INSERT
AS
BEGIN
	DECLARE @Number AS INT
		, @Address AS VARCHAR(150)
		, @Type AS CHAR(15)
		, @Status AS CHAR(12)

	SELECT @Number = RoomNumber, @Address = PropertyAddress, @Type = Type
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
END
GO