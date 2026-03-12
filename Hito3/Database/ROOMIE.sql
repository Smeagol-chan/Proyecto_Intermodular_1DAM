/*
	- Para el Type de FURNITURE deberiamos de hacer que su CHECK mire una lista sonde podamos meter todos los tipos que hay (enum / json / etc).
	- Para el Issue de REPORT deberiamos de hacer que su CHECK mire una lista sonde podamos meter todos los tipos que hay (enum / json / etc).
*/
CREATE DATABASE ROOMIE
GO

USE ROOMIE
GO

CREATE TABLE USER (
Dni AS CHAR(9) PRIMARY KEY
, Name AS VARCHAR(20) NOT NULL
, Surnames AS VARCHAR(40) NOT NULL
, Birthday AS DATE NOT NULL
, PhoneNumber AS CHAR(9) UNIQUE NOT NULL
, Email AS VARCHAR(60) UNIQUE NOT NULL
, UserName AS VARCHAR(30) UNIQUE NOT NULL
, Password AS VARCHAR(30) NOT NULL
, CHECK (Dni LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][A-Z]')
, CHECK (Password LIKE '%'+'[A-Z]'+'%'
	AND Password LIKE '%'+'[a-z]'+'%'
	AND Password LIKE '%'+'[0-9]'+'%'
	AND Password LIKE '%'+'[.-+_#*=]'+'%')
, CHECK (PhoneNumber LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
);
GO

CREATE TABLE TENANT(
Dni AS CHAR(9) PRIMARY KEY
, StudentLicense AS CHAR(8) UNIQUE
, FOREIGN KEY (Dni) REFERENCES USER(Dni)
, CHECK (Dni LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][A-Z]')
, CHECK (StudentLicense LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
);
GO

CREATE TABLE OWNER(
Dni AS CHAR(9) PRIMARY KEY
, FOREIGN KEY (Dni) REFERENCES USER(Dni)
, CHECK (Dni LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][A-Z]')
);
GO

CREATE TABLE PROPERTY(
Address AS VARCHAR(150) PRIMARY KEY
, OwnerDni AS CHAR(9) UNIQUE NOT NULL
, Status AS CHAR(9) DEFAULT 'Pending'
, Surface AS DECIMAL(4,1) NOT NULL
, FOREIGN KEY (OwnerDni) REFERENCES OWNER(Dni)
, CHECK (OwnerDni LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][A-Z]')
, CHECK (Status IN ('Pending', 'Confirmed', 'Denied'))
);
GO

CREATE TABLE ROOM(
RoomNumber AS INT IDENTITY
, PropertyAddress AS VARCHAR(150) UNIQUE NOT NULL
, Type AS CHAR(15) NOT NULL
, Surface AS DECIMAL(3,1) NOT NULL
, Status AS CHAR(9) DEFAULT 'Available'
, PricePerMonth AS SMALLMONEY NOT NULL
, PRIMARY KEY (RoomNumber, Address)
, FOREIGN KEY (PropertyAddress) REFERENCES PROPERTY(Address)
, CHECK (Status IN ('Available', 'Rented'))
, CHECK (Type IN ('Kitchen', 'Living Room', 'Balcony', 'Bathroom', 'Hall', 'Bedroom', 'Dinning Room'))
);
GO

CREATE TABLE FURNITURE(
FurnitureNumber AS INT IDENTITY
, PropertyAddress AS VARCHAR(150) UNIQUE NOT NULL
, RoomNumber AS INT NOT NULL
, Type AS CHAR(15) NOT NULL
, Quantity AS TINYINT NOT NULL
, PRIMARY KEY (FurnitureNumber, PropertyAddress, RoomNumber)
, FOREIGN KEY (PropertyAddress) REFERENCES ROOM(PropertyAddress)
, FOREIGN KEY (RoomNumber) REFERENCES ROOM(RoomNumber)
);
GO

CREATE TABLE CONTRACT(
SignatureDate AS DATE NOT NULL
, TenantDni AS CHAR(9) UNIQUE NOT NULL
, RoomNumber AS INT NOT NULL
, PropertyAddress AS VARCHAR(100) NOT NULL
, PricePerMonth AS SMALLMONEY NOT NULL
, StartingDate AS DATE NOT NULL
, EndingDate AS DATE NOT NULL
, Status AS CHAR(7) DEFAULT 'Ongoing'
, PRIMARY KEY (SignatureDate, TenantDni, RoomNumber, PropertyAddress)
, FOREIGN KEY (TenantDni) REFERENCES TENANT(Dni)
, FOREIGN KEY (RoomNumber) REFERENCES ROOM(RoomNumber)
, FOREIGN KEY (PropertyAddress) REFERENCES ROOM(PropertyAddress)
, CHECK (TenantDni LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][A-Z]')
, CHECK (Status INT ('Ongoing', 'Ended'))
);
GO

CREATE TABLE REPORT(
ReportDate AS DATE NOT NULL
, UserDni AS CHAR(9) UNIQUE NOT NULL
, RoomNumber AS INT NOT NULL
, PropertyAddress AS VARCHAR(100) NOT NULL
, Issue AS CHAR(20) NOT NULL
, Details AS VARCHAR(300) NOT NULL
, Status AS CAHR(7) DEFAULT 'Pending' NOT NULL
, PRIMARY KEY (ReportDate, UserDni, RoomNumber, PropertyAddress)
, FOREIGN KEY (UserDni) REFERENCES USER(Dni)
, FOREIGN KEY (RoomNumber) REFERENCES ROOM(RoomNumber)
, FOREIGN KEY (PropertyAddress) REFERENCES ROOM(PropertyAddress)
, CHECK (UserDni LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][A-Z]')
, CHECK (Status IN ('Pending', 'Checked'))
);
GO