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
	AND Password LIKE '%[-.+_#*=]%')
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
Address VARCHAR(150) NOT NULL
, CityID SMALLINT NOT NULL
, OwnerDni CHAR(9) UNIQUE NOT NULL
, Status CHAR(9) DEFAULT 'Pending'
, Surface DECIMAL(4,1) NOT NULL
, PRIMARY KEY (Address, CityID)
, FOREIGN KEY (CityID) REFERENCES CITY(CityID)
, FOREIGN KEY (OwnerDni) REFERENCES [OWNER](Dni)
, CHECK (OwnerDni LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][A-Z]')
, CHECK (Status IN ('Pending', 'Confirmed', 'Denied'))
);
GO

CREATE TABLE PROPERTY_INSITUTION(
InstitutionID SMALLINT NOT NULL
, PropertyAddress VARCHAR(150) NOT NULL
, PropertyCityID SMALLINT NOT NULL
, PRIMARY KEY (InstitutionID, PropertyAddress, PropertyCityID)
, FOREIGN KEY (InstitutionID) REFERENCES INSTITUTION(InstitutionID)
, FOREIGN KEY (PropertyAddress, PropertyCityID) REFERENCES PROPERTY(Address, CityID)
);
GO

CREATE TABLE ROOM(
RoomNumber TINYINT IDENTITY
, PropertyAddress VARCHAR(150) NOT NULL
, PropertyCityID SMALLINT NOT NULL
, Type CHAR(15) NOT NULL
, Surface DECIMAL(3,1) NOT NULL
, Status CHAR(12)
, PricePerMonth SMALLMONEY NOT NULL
, PRIMARY KEY (RoomNumber, PropertyAddress, PropertyCityID)
, FOREIGN KEY (PropertyAddress, PropertyCityID) REFERENCES PROPERTY(Address, CityID)
, CHECK (Status IN ('Available', 'Rented', 'Shared Space'))
, CHECK (Type IN ('Kitchen', 'Living Room', 'Balcony', 'Bathroom', 'Hall', 'Bedroom', 'Dinning Room', 'Storage Room'))
);
GO

CREATE TABLE FURNITURE(
FurnitureID SMALLINT IDENTITY PRIMARY KEY
, FurnitureName CHAR(20) UNIQUE NOT NULL
, FurnitureDescription VARCHAR(50)
);
GO

CREATE TABLE ROOM_FURNITURE(
FurnitureID SMALLINT NOT NULL
, PropertyAddress VARCHAR(150) NOT NULL
, PropertyCityID SMALLINT NOT NULL
, RoomNumber TINYINT NOT NULL
, Quantity TINYINT DEFAULT 1
, PRIMARY KEY (FurnitureID, PropertyAddress, PropertyCityID, RoomNumber)
, FOREIGN KEY (RoomNumber,PropertyAddress, PropertyCityID) REFERENCES ROOM(RoomNumber, PropertyAddress, PropertyCityID)
, FOREIGN KEY (FurnitureID) REFERENCES FURNITURE(FurnitureID)
, CHECK (Quantity > 0)
);
GO

CREATE TABLE [CONTRACT](
ContractID INT IDENTITY PRIMARY KEY
, SignatureDate DATE NOT NULL
, TenantDni CHAR(9) UNIQUE NOT NULL
, RoomNumber TINYINT NOT NULL
, PropertyAddress VARCHAR(150) NOT NULL
, PropertyCityID SMALLINT NOT NULL
, PricePerMonth SMALLMONEY NOT NULL
, StartingDate DATE NOT NULL
, EndingDate DATE NOT NULL
, Status CHAR(7) DEFAULT 'Ongoing'
, FOREIGN KEY (TenantDni) REFERENCES TENANT(Dni)
, FOREIGN KEY (RoomNumber,PropertyAddress,PropertyCityID) REFERENCES ROOM(RoomNumber,PropertyAddress,PropertyCityID)
, CHECK (TenantDni LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][A-Z]')
, CHECK (Status in ('Ongoing', 'Ended'))
, CHECK (DATEDIFF(dd, StartingDate, EndingDate) <= 0)
);
GO

CREATE TABLE REPORT(
ReportID INT IDENTITY PRIMARY KEY
, ReportDate DATETIME NOT NULL
, UserDni CHAR(9) UNIQUE NOT NULL
, RoomNumber TINYINT NOT NULL
, PropertyAddress VARCHAR(150) NOT NULL
, PropertyCityID SMALLINT NOT NULL
, Issue CHAR(20) NOT NULL
, Details VARCHAR(300) NOT NULL
, Status CHAR(7) DEFAULT 'Pending'
, FOREIGN KEY (UserDni) REFERENCES [USER](Dni)
, FOREIGN KEY (RoomNumber,PropertyAddress,PropertyCityID) REFERENCES ROOM(RoomNumber,PropertyAddress,PropertyCityID)
, CHECK (UserDni LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][A-Z]')
, CHECK (Status IN ('Pending', 'Checked'))
);
GO