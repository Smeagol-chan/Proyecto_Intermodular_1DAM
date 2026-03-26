CREATE DATABASE ROOMIE
GO

USE ROOMIE
GO

CREATE TABLE [USER] (
Dni CHAR(9) PRIMARY KEY
, Name VARCHAR(20) NOT NULL
, Surnames VARCHAR(40) NOT NULL
, Birthday DATE NOT NULL
, PhoneNumber CHAR(9) UNIQUE NOT NULL
, Email VARCHAR(60) UNIQUE NOT NULL
, UserName VARCHAR(30) UNIQUE NOT NULL
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

CREATE TABLE ROOM(
RoomNumber INT IDENTITY
, PropertyAddress VARCHAR(150) UNIQUE NOT NULL
, Type CHAR(15) NOT NULL
, Surface DECIMAL(3,1) NOT NULL
, Status CHAR(9) DEFAULT 'Available'
, PricePerMonth SMALLMONEY NOT NULL
, PRIMARY KEY (RoomNumber, PropertyAddress)
, FOREIGN KEY (PropertyAddress) REFERENCES PROPERTY(Address)
, CHECK (Status IN ('Available', 'Rented'))
, CHECK (Type IN ('Kitchen', 'Living Room', 'Balcony', 'Bathroom', 'Hall', 'Bedroom', 'Dinning Room'))
);
GO

CREATE TABLE FURNITURE_CATEGORY(
CategoryID INT IDENTITY PRIMARY KEY
, CategoryName CHAR(15) UNIQUE NOT NULL
);
GO

CREATE TABLE FURNITURE(
FurnitureNumber INT IDENTITY
, PropertyAddress VARCHAR(150) UNIQUE NOT NULL
, RoomNumber INT NOT NULL
, Name VARCHAR(30) NOT NULL
, Category INT NOT NULL
, Quantity TINYINT NOT NULL
, PRIMARY KEY (FurnitureNumber, PropertyAddress, RoomNumber)
, FOREIGN KEY (RoomNumber,PropertyAddress) REFERENCES ROOM(RoomNumber,PropertyAddress)
, FOREIGN KEY (Category) REFERENCES FURNITURE_CATEGORY (CategoryID)
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
ReportDate DATE NOT NULL
, UserDni CHAR(9) UNIQUE NOT NULL
, RoomNumber INT NOT NULL
, PropertyAddress VARCHAR(150) NOT NULL
, Issue CHAR(20) NOT NULL
, Details VARCHAR(300) NOT NULL
, Status CHAR(7) DEFAULT 'Pending' NOT NULL
, PRIMARY KEY (ReportDate, UserDni, RoomNumber, PropertyAddress)
, FOREIGN KEY (UserDni) REFERENCES [USER](Dni)
, FOREIGN KEY (RoomNumber,PropertyAddress) REFERENCES ROOM(RoomNumber,PropertyAddress)
, CHECK (UserDni LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][A-Z]')
, CHECK (Status IN ('Pending', 'Checked'))
);
GO