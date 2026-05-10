CREATE DATABASE ROOMIE
GO

USE ROOMIE
GO

CREATE TABLE PROVINCE(
ProvinceID CHAR(2) PRIMARY KEY
, ProvinceName CHAR(26) UNIQUE NOT NULL
);
GO

CREATE TABLE CITY(
CityID SMALLINT IDENTITY PRIMARY KEY
, CityName VARCHAR(50) NOT NULL
, ProvinceID CHAR(2) NOT NULL
, FOREIGN KEY (ProvinceID) REFERENCES PROVINCE(ProvinceID)
);
GO

CREATE TABLE INSTITUTION(
InstitutionID SMALLINT IDENTITY PRIMARY KEY
, InstitutionName VARCHAR(50) NOT NULL
, CityID SMALLINT NOT NULL
, FOREIGN KEY (CityID) REFERENCES CITY(CityID)
);
GO

CREATE TABLE [USER] (
Dni CHAR(9) PRIMARY KEY
, Name VARCHAR(20) NOT NULL
, Surnames VARCHAR(40) NOT NULL
, Birthday DATE NOT NULL
, PhoneNumber CHAR(9) UNIQUE NOT NULL
, Email VARCHAR(60) UNIQUE NOT NULL
, Password VARCHAR(30) NOT NULL
, CHECK (Dni LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][A-Z]')
, CHECK (Password LIKE '%[A-Z]%'
	AND Password LIKE '%[a-z]%'
	AND Password LIKE '%[0-9]%'
	AND Password LIKE '%[.-+_#*=]%')
, CHECK (PhoneNumber LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
);
GO

CREATE TABLE TENANT(
Dni CHAR(9) PRIMARY KEY
, StudentLicense CHAR(8) UNIQUE
, FOREIGN KEY (Dni) REFERENCES [USER](Dni)
, CHECK (Dni LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][A-Z]')
, CHECK (StudentLicense LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
);
GO

CREATE TABLE [OWNER](
Dni CHAR(9) PRIMARY KEY
, FOREIGN KEY (Dni) REFERENCES [USER](Dni)
, CHECK (Dni LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][A-Z]')
);
GO

CREATE TABLE PROPERTY(
Address VARCHAR(150) PRIMARY KEY
, OwnerDni CHAR(9) UNIQUE NOT NULL
, Status CHAR(9) DEFAULT 'Pending'
, Surface DECIMAL(4,1) NOT NULL
, FOREIGN KEY (OwnerDni) REFERENCES [OWNER](Dni)
, CHECK (OwnerDni LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][A-Z]')
, CHECK (Status IN ('Pending', 'Confirmed', 'Denied'))
);
GO

CREATE TABLE PROPERTY_INSITUTION(
InstitutionID SMALLINT NOT NULL
, PropertyAddress VARCHAR(150) NOT NULL
, PRIMARY KEY (InstitutionID, PropertyAddress)
, FOREIGN KEY (InstitutionID) REFERENCES INSTITUTION(InstitutionID)
, FOREIGN KEY (PropertyAddress) REFERENCES PROPERTY(Address)
);
GO

CREATE TABLE ROOM(
RoomNumber INT IDENTITY
, PropertyAddress VARCHAR(150) UNIQUE NOT NULL
, Type CHAR(15) NOT NULL
, Surface DECIMAL(3,1) NOT NULL
, Status CHAR(12)
, PricePerMonth SMALLMONEY NOT NULL
, PRIMARY KEY (RoomNumber, PropertyAddress)
, FOREIGN KEY (PropertyAddress) REFERENCES PROPERTY(Address)
, CHECK (Status IN ('Available', 'Rented', 'Shared Space'))
, CHECK (Type IN ('Kitchen', 'Living Room', 'Balcony', 'Bathroom', 'Hall', 'Bedroom', 'Dinning Room', 'Storage Room'))
);
GO

CREATE TABLE FURNITURE(
FurnitureID INT IDENTITY PRIMARY KEY
, FurnitureName CHAR(20) UNIQUE NOT NULL
, FurnitureDescription VARCHAR(50)
);
GO

CREATE TABLE ROOM_FURNITURE(
FurnitureID INT NOT NULL
, PropertyAddress VARCHAR(150) UNIQUE NOT NULL
, RoomNumber INT NOT NULL
, Quantity TINYINT DEFAULT 1
, PRIMARY KEY (FurnitureID, PropertyAddress, RoomNumber)
, FOREIGN KEY (RoomNumber,PropertyAddress) REFERENCES ROOM(RoomNumber,PropertyAddress)
, FOREIGN KEY (FurnitureID) REFERENCES FURNITURE(FurnitureID)
, CHECK (Quantity > 0)
);
GO

CREATE TABLE [CONTRACT](
SignatureDate DATE NOT NULL
, TenantDni CHAR(9) UNIQUE NOT NULL
, RoomNumber INT NOT NULL
, PropertyAddress VARCHAR(150) NOT NULL
, PricePerMonth SMALLMONEY NOT NULL
, StartingDate DATE NOT NULL
, EndingDate DATE NOT NULL
, Status CHAR(7) DEFAULT 'Ongoing'
, PRIMARY KEY (SignatureDate, TenantDni, RoomNumber, PropertyAddress)
, FOREIGN KEY (TenantDni) REFERENCES TENANT(Dni)
, FOREIGN KEY (RoomNumber,PropertyAddress) REFERENCES ROOM(RoomNumber,PropertyAddress)
, CHECK (TenantDni LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][A-Z]')
, CHECK (Status in ('Ongoing', 'Ended'))
);
GO

CREATE TABLE REPORT(
ReportDate DATETIME NOT NULL
, UserDni CHAR(9) UNIQUE NOT NULL
, RoomNumber INT NOT NULL
, PropertyAddress VARCHAR(150) NOT NULL
, Issue CHAR(20) NOT NULL
, Details VARCHAR(300) NOT NULL
, Status CHAR(7) DEFAULT 'Pending'
, PRIMARY KEY (ReportDate, UserDni, RoomNumber, PropertyAddress)
, FOREIGN KEY (UserDni) REFERENCES [USER](Dni)
, FOREIGN KEY (RoomNumber,PropertyAddress) REFERENCES ROOM(RoomNumber,PropertyAddress)
, CHECK (UserDni LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][A-Z]')
, CHECK (Status IN ('Pending', 'Checked'))
);
GO

----------------------------INSERTS-----------------------------------

INSERT INTO PROVINCE (ProvinceName, ProvinceID)
VALUES ('Ávala', 'VI')
	, ('Albacete', 'AB')
	, ('Alicante', 'A')
	, ('Almería', 'AL')
	, ('Asturias', 'O')
	, ('Ávila', 'AV')
	, ('Badajoz', 'BA')
	, ('Barcelona', 'B')
	, ('Burgos', 'BU')
	, ('Cádiz', 'CA')
	, ('Cantabria', 'S')
	, ('Cáceres', 'CC')
	, ('Castellón', 'CS')
	, ('Ceuta', 'CE')
	, ('Ciudad Real', 'CR')
	, ('Córdoba', 'CO')
	, ('La Coruña', 'C')
	, ('Cuenca', 'CU')
	, ('Las Palmas de Gran Canaria', 'GC')
	, ('Girona', 'GI')
	, ('Granada', 'GR')
	, ('Guadalajara', 'GU')
	, ('Guipúzcua', 'SS')
	, ('Huelva', 'H')
	, ('Islas Baleares', 'IB')
	, ('Jaén', 'J')
	, ('León', 'LE')
	, ('Lérida', 'L')
	, ('La Rioja', 'LO')
	, ('Lugo', 'LU')
	, ('Madrid', 'M')
	, ('Málaga', 'MA')
	, ('Melilla', 'ML')
	, ('Murcia', 'MU')
	, ('Navarra', 'NA')
	, ('Ourense', 'OU')
	, ('Palencia', 'P')
	, ('Pontevedra', 'PO')
	, ('Salamanca', 'SA')
	, ('Segovia', 'SG')
	, ('Sevilla', 'SE')
	, ('Soria', 'SO')
	, ('Tarragona', 'T')
	, ('Santa Cruz de Tenerife', 'TF')
	, ('Teruel', 'TE')
	, ('Toledo', 'TO')
	, ('Valencia', 'V')
	, ('Valladolid', 'VA')
	, ('Vizcaya', 'BI')
	, ('Zamora', 'ZA')
	, ('Zaragoza', 'Z')
GO

INSERT INTO FURNITURE (FurnitureName)
VALUES ('Bedroom desk')
	, ('Bed')
	, ('Armchair')
	, ('Nightstand')
	, ('Desktop')
	, ('Simple shelf')
	, ('Display shelf')
	, ('Standing lamp')
	, ('Office chair')
	, ('Rolling cart')
	, ('Coffee table')
	, ('Dining room table')
	, ('Sofa')
	, ('Television')
	, ('Wardrobe')
	, ('Dining room chair')
	, ('Rug')
	, ('Ceiling lamp')
	, ('Display case')
	, ('Cupboard')
	, ('Pillow')
	, ('Ceiling fan')
	, ('Cabinet')
GO

-------------------------TRIGGERS------------------

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