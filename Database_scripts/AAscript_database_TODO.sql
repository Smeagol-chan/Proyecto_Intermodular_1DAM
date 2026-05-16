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
, CHECK (DATEDIFF(dd, StartingDate, EndingDate) > 0) 
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

INSERT INTO CITY (CityName, ProvinceID)
VALUES
('San Vicente del Raspeig','A'),
('Elche', 'A'),
('Torrevieja', 'A'),
('Orihuela', 'A'),
('Benidorm', 'A'),
('Alcoy', 'A'),
('Elda', 'A'),
('Denia', 'A'),
('Villajoyosa', 'A'),
('Santa Pola', 'A'),
('Villena', 'A'),
('Torrent', 'V'),
('Gandia', 'V'),
('Paterna', 'V'),
('Sagunto', 'V'),
('Alzira', 'V'),
('Mislata', 'V'),
('Burjassot', 'V'),
('Ontinyent', 'V'),
('Xàtiva', 'V'),
('Chirivella', 'V'),
('Hospitalet de Llobregat', 'B'),
('Badalona', 'B'),
('Terrassa', 'B'),
('Sabadell', 'B'),
('Mataró', 'B'),
('Santa Coloma de Gramenet', 'B'),
('Cornellà de Llobregat', 'B'),
('Sant Cugat del Vallès', 'B'),
('Manresa', 'B'),
('Granollers', 'B'),
('Móstoles', 'M'),
('Alcalá de Henares', 'M'),
('Fuenlabrada', 'M'),
('Leganés', 'M'),
('Getafe', 'M'),
('Dos Hermanas', 'SE'),
('Alcalá de Guadaíra', 'SE'),
('Utrera', 'SE'),
('Mairena del Aljarafe', 'SE'),
('Écija', 'SE'),
('Gijón', 'O'),
('Vigo', 'PO'),
('Marbella', 'MA'),
('Cartagena', 'MU'),
('Jerez de la Frontera', 'CA'),
('Barakaldo', 'BI'),
('Talavera de la Reina', 'TO'),
('Ponferrada', 'LE'),
('Algeciras', 'CA');

go

insert into INSTITUTION (InstitutionName,CityID)
values
('Universidad de Alicante',1),
('Universidad de Elche',2),
('Universidad de Torrevieja',3),
('Universidad de Orihuela',4),
('Universidad de Benidorm',5),
('Universidad de Alcoy',6),
('Universidad de Elda',7),
('Universidad de Denia',8),
('Universidad de Villajoyosa',9),
('Universidad de Santa Pola',10),
('Universidad de Villena',11),
('Universidad de Valencia',12),
('Universidad de Gandia',13),
('Universidad de Paterna',14),
('Universidad de Sagunto',15),
('Universidad de Alzira',16),
('Universidad de Mislata',17),
('Universidad de Burjassot',18),
('Universidad de Ontiynent',19),
('Universidad de Xátiva',20),
('Universidad de Chirivella',21),
('Universidad de Barcelona',22),
('Universidad de Badalona',23),
('Universidad de Terrasa',24),
('Universidad de Sabadell',25),
('Universidad de Mataró',26),
('Universidad de Santa Coloma',27),
('Universidad de Llobregat',28),
('Universidad del Vallés ',29),
('Universidad de Madrid',32),
('Universidad de Sevilla',37),
('Universidad de Asturias',42),
('Universidad de Galicia',43),
('Universidad de Marbella',44),
('Universidad de Murcia',45),
('Universidad de Toledo',48),
('Universidad de Manresa',30),
('Universidad de Granollers',31),
('Universidad de Alcalá de Henares',33),
('Universidad de Fuenlabrada',34),
('Universidad de Leganés',35),
('Universidad de Getafe',36),
('Universidad de Dos Hermanas',38),
('Universidad de Alcalá de Guadaíra',39)
go



INSERT INTO [USER] (dni, Name, Surnames, Birthday, PhoneNumber, email, Password) 
VALUES
('48291037X', 'Hugo', 'García Fernández', '12/05/1985', '610293847', 'hugo.garcia@email.com', 'hG9_pass'),
('72349581B', 'Lucía', 'Martínez Ruiz', '22/08/1992', '654321098', 'lucia.mtz@email.com', 'lM2*root'),
('10582736C', 'Mateo', 'López Sánchez', '05/11/1988', '689574123', 'mateo.ls@email.com', 'mL5#safe'),
('39485726D', 'Sofía', 'Pérez Gómez', '30/01/1995', '600112233', 'sofia.perez@email.com', 'sP1+data'),
('58271634E', 'Martín', 'González Cano', '14/03/1980', '677889900', 'martin.gonz@email.com', 'mG4.secure'),
('29384756F', 'Elena', 'Rodríguez Díaz', '19/07/2000', '633445566', 'elena.rd@email.com', 'eR8=pass'),
('84756123G', 'Alejandro', 'Hernández Moreno', '25/09/1983', '611223344', 'alex.hm@email.com', 'aH3-word'),
('12345098H', 'Valentina', 'Muñoz Jiménez', '08/02/1991', '699001122', 'valen.mj@email.com', 'vM6_key1'),
('56473829I', 'Lucas', 'Álvarez Romero', '17/06/1987', '622334455', 'lucas.alv@email.com', 'lA2.best'),
('90123456J', 'Alba', 'Suárez Navarro', '11/12/1999', '655667788', 'alba.sn@email.com', 'aS7#code'),
('34567890K', 'Leo', 'Delgado Torres', '03/04/1994', '688776655', 'leo.dt@email.com', 'lD9+fast'),
('67890123L', 'Julia', 'Vázquez Ramos', '27/10/1982', '644556677', 'julia.vr@email.com', 'jV1_admin'),
('21098765M', 'Daniel', 'Gil Blanco', '15/01/1986', '611998877', 'daniel.gb@email.com', 'dG4*point'),
('45678901N', 'Sara', 'Ramírez Castro', '09/05/1993', '633221100', 'sara.rc@email.com', 'sR3.work'),
('89012345P', 'Pablo', 'Molina Ortiz', '21/08/1989', '666554433', 'pablo.mo@email.com', 'pM5-test'),
('23456789Q', 'Emma', 'Morales Nuñez', '13/11/1997', '677443322', 'emma.mn@email.com', 'eM2#user'),
('54321098R', 'Adrián', 'Ortega Medina', '04/02/1984', '611001199', 'adrian.om@email.com', 'aO8+gold'),
('76543210S', 'Lola', 'Garrido León', '28/06/1996', '655889911', 'lola.gl@email.com', 'lG1_blue'),
('13579246T', 'Iker', 'Cortes Castillo', '10/09/1981', '699223344', 'iker.cc@email.com', 'iC4*star'),
('24681357U', 'Carla', 'Rubio Santos', '02/12/1990', '622778899', 'carla.rs@email.com', 'cR6.link'),
('35792468V', 'Marcos', 'Pascual Lozano', '18/03/1998', '600334455', 'marcos.pl@email.com', 'mP9#jump'),
('46813579W', 'Clara', 'Vega Herrera', '26/05/1985', '644112233', 'clara.vh@email.com', 'cV2=nice'),
('57924681X', 'Javier', 'Méndez Esteban', '07/07/1992', '688445566', 'javier.me@email.com', 'jM3_flow'),
('68035792Y', 'Marta', 'Hidalgo Marcos', '14/10/1987', '611556677', 'marta.hm@email.com', 'mH7*peak'),
('79146803Z', 'Diego', 'Ibañez Nieto', '29/01/1994', '633778899', 'diego.in@email.com', 'dI1.up77'),
('80257914A', 'Paula', 'Vicente Ferrer', '01/04/1983', '677221100', 'paula.vf@email.com', 'pV4#door'),
('91368025B', 'Álvaro', 'Crespo Diez', '23/06/1991', '622001122', 'alvaro.cd@email.com', 'aC9+wind'),
('02479136C', 'Noa', 'Gutiérrez Reyes', '16/09/1995', '644998877', 'noa.gr@email.com', 'nG2_land'),
('13580247D', 'Mario', 'Pastor Soler', '05/02/1980', '688112233', 'mario.ps@email.com', 'mP5*fire'),
('24691358E', 'Inés', 'Gallardo Aguilar', '21/11/1988', '611443322', 'ines.ga@email.com', 'iG8.cool'),
('35702469F', 'Bruno', 'Escribano Lara', '12/03/1993', '666221100', 'bruno.el@email.com', 'bE1#city'),
('46813570G', 'Candela', 'Pardo Arenas', '24/07/1986', '600887766', 'candela.pa@email.com', 'cP6=open'),
('57924681H', 'Jorge', 'Lorenzo Franco', '31/05/1997', '633990011', 'jorge.lf@email.com', 'jL4_step'),
('68035792I', 'Alicia', 'Montero Mora', '06/10/1984', '677002233', 'alicia.mm@email.com', 'aM3*road'),
('79146803J', 'David', 'Iglesias Luna', '15/12/1990', '622556677', 'david.il@email.com', 'dI9.west'),
('80257914K', 'Irene', 'Giménez Izquierdo', '02/08/1982', '644332211', 'irene.gi@email.com', 'iG2#east'),
('91368025L', 'Samuel', 'Sanz Marín', '19/01/1999', '688667788', 'samuel.sm@email.com', 'sS7+near'),
('02479136M', 'Nerea', 'Beltrán Flores', '11/04/1985', '611223399', 'nerea.bf@email.com', 'nB5_look'),
('13580247N', 'Gonzalo', 'Galán Jurado', '28/06/1992', '633554433', 'gonzalo.gj@email.com', 'gG1*park'),
('24691358P', 'Ainhoa', 'Conde Quintana', '14/09/1987', '677112288', 'ainhoa.cq@email.com', 'aC4.hill'),
('35702469Q', 'Rodrigo', 'Casado Rivas', '23/02/1994', '622998800', 'rodrigo.cr@email.com', 'rC8#lake'),
('46813570R', 'Miriam', 'Vila Blasco', '07/11/1981', '644445566', 'miriam.vb@email.com', 'mV2=rain'),
('57924681S', 'Rafael', 'Bravo Vico', '20/05/1996', '688001144', 'rafael.bv@email.com', 'rB6_song'),
('68035792T', 'Esther', 'Egea Fuentes', '12/08/1989', '611667722', 'esther.ef@email.com', 'eE3*mind'),
('79146803U', 'Oliver', 'Manso Serra', '04/01/1983', '633889955', 'oliver.ms@email.com', 'oM9.kind'),
('80257914V', 'Berta', 'Cano Santiago', '26/03/1998', '677334411', 'berta.cs@email.com', 'bC1#hope'),
('91368025W', 'Marcos', 'Benítez Acosta', '17/07/1980', '622110099', 'marcos.ba@email.com', 'mB4+soul'),
('02479136X', 'Rocío', 'Merino Cabrera', '09/10/1991', '644778822', 'rocio.mc@email.com', 'rM7_life'),
('13580247Y', 'Ismael', 'Velasco Solís', '25/12/1984', '688223311', 'ismael.vs@email.com', 'iV2*love'),
('24691358Z', 'Nuria', 'Pallarés León', '13/04/1995', '611445500', 'nuria.pl@email.com', 'nP5.home');
go


INSERT INTO [OWNER] ([Dni])          
VALUES
('39485726D'),
 ('35792468V'),
 ('46813570G'),
 ('48291037X'),
 ('54321098R'),
 ('84756123G'),
 ('02479136M'),
 ('24691358E'),
 ('24691358Z'),
 ('68035792Y'),
 ('68035792T'),
 ('21098765M'),
 ('91368025B'),
 ('91368025W'),
 ('56473829I'),
 ('79146803J'),
 ('24681357U'),
 ('35702469Q'),
 ('45678901N'),
 ('29384756F'),
 ('13580247N'),
 ('79146803Z'),
 ('79146803U'),
 ('57924681H'),
 ('46813579W')

 go

INSERT INTO [TENANT] (Dni, StudentLicense)
VALUES
('80257914K', '12345678'),
('46813570R', '84920311'),
('67890123L', '55214789'),
('02479136X', '33698521'),
('02479136C', '77412589'),
('72349581B', '10293847'),
('90123456J', '99663322'),
('76543210S', '44112233'),
('35702469F', '88552211'),
('89012345P', '66339988'),
('68035792I', '22558877'),
('24691358P', '11447700'),
('80257914A', '55882244'),
('80257914V', '33991177'),
('23456789Q', '44771100'),
('58271634E', '22660033'),
('57924681S', '99228855'),
('13580247D', '77331144'),
('13580247Y', '66442299'),
('57924681X', '88115522'),
('91368025L', '11009922'),
('34567890K', '44227755'),
('10582736C', '66883311'),
('12345098H', '99551144'),
('13579246T', '22884477');

go

INSERT INTO PROPERTY (Address, CityID, OwnerDni, Status, Surface)
VALUES
('Calle Mayor 12', 1, '02479136M', 'Confirmed', 85.0),
('Avenida de la Libertad 45', 2, '13580247N', 'Pending', 110.5),
('Calle del Mar 3', 3, '21098765M', 'Denied', 65.2),
('Plaza de la Constitución 1', 4, '24681357U', 'Confirmed', 120.0),
('Calle San José 22', 5, '24691358E', 'Pending', 95.8),
('Avenida Mediterráneo 88', 6, '24691358Z', 'Confirmed', 78.3),
('Calle Nueva 15', 7, '29384756F', 'Denied', 102.1),
('Calle de la Paz 5', 8, '35702469Q', 'Confirmed', 55.4),
('Avenida de Madrid 101', 9, '35792468V', 'Pending', 130.2),
('Calle del Sol 7', 10, '39485726D', 'Confirmed', 88.9),
('Plaza Mayor 10', 11, '45678901N', 'Denied', 115.0),
('Calle Valencia 4', 12, '46813570G', 'Confirmed', 70.6),
('Avenida de Francia 12', 13, '46813579W', 'Pending', 92.4),
('Calle de la Iglesia 2', 14, '48291037X', 'Confirmed', 81.0),
('Paseo de la Estación 33', 15, '54321098R', 'Denied', 105.7),
('Calle Real 50', 16, '56473829I', 'Confirmed', 68.5),
('Avenida de los Chopos 21', 17, '57924681H', 'Pending', 99.3),
('Calle de las Flores 9', 18, '68035792T', 'Confirmed', 112.8),
('Plaza de España 5', 19, '68035792Y', 'Denied', 77.0),
('Calle de la Luna 11', 20, '79146803J', 'Confirmed', 140.5),
('Avenida de la Constitución 40', 32, '79146803U', 'Pending', 84.2),
('Calle de Alcalá 200', 33, '79146803Z', 'Confirmed', 118.6),
('Calle de la Victoria 14', 37, '84756123G', 'Denied', 91.1),
('Avenida de Andalucía 55', 38, '91368025B', 'Confirmed', 103.4),
('Calle Sierpes 10', 39, '91368025W', 'Pending', 62.9);

GO

insert into PROPERTY_INSITUTION (InstitutionID,PropertyAddress,PropertyCityID)
values
(1,'Calle Mayor 12',1),
(2,'Avenida de la Libertad 45',2),
(3,'Calle del Mar 3',3),
(4,'Plaza de la Constitución 1',4),
(5,'Calle San José 22',5),
(6,'Avenida Mediterráneo 88',6),
(7,'Calle Nueva 15',7),
(8,'Calle de la Paz 5',8),
(9,'Avenida de Madrid 101',9),
(10,'Calle del Sol 7',10),
(11,'Plaza Mayor 10',11),
(12,'Calle Valencia 4',12),
(13,'Avenida de Francia 12',13),
(14,'Calle de la Iglesia 2',14),
(15,'Paseo de la Estación 33',15),
(16,'Calle Real 50',16),
(17,'Avenida de los Chopos 21',17),
(18,'Calle de las Flores 9',18),
(19,'Plaza de España 5',19),
(20,'Calle de la Luna 11',20),
(42,'Avenida de la Constitución 40',32),
(39,'Calle de Alcalá 200',33),
(31,'Calle de la Victoria 14',37),
(43,'Avenida de Andalucía 55',38),
(44,'Calle Sierpes 10',39)
go

INSERT INTO ROOM (PropertyAddress, PropertyCityID, Type, Surface, Status, PricePerMonth)
VALUES

('Calle Mayor 12', 1, 'Bedroom', 12.5, 'Available', 350.0),
('Calle Mayor 12', 1, 'Bedroom', 15.0, 'Rented', 400.0),
('Calle Mayor 12', 1, 'Bedroom', 10.2, 'Available', 300.0),
('Avenida de la Libertad 45', 2, 'Bedroom', 18.5, 'Rented', 500.0),
('Avenida de la Libertad 45', 2, 'Bedroom', 14.0, 'Available', 450.0),
('Calle del Mar 3', 3, 'Bedroom', 11.0, 'Shared Space', 280.0),
('Calle del Mar 3', 3, 'Bedroom', 12.0, 'Available', 310.0),
('Plaza de la Constitución 1', 4, 'Bedroom', 20.0, 'Rented', 600.0),
('Plaza de la Constitución 1', 4, 'Bedroom', 19.5, 'Available', 580.0),
('Plaza de la Constitución 1', 4, 'Bedroom', 15.0, 'Rented', 450.0),
('Calle San José 22', 5, 'Bedroom', 13.2, 'Available', 340.0),
('Calle San José 22', 5, 'Bedroom', 12.8, 'Rented', 340.0),
('Avenida Mediterráneo 88', 6, 'Bedroom', 14.5, 'Available', 390.0),
('Avenida Mediterráneo 88', 6, 'Bedroom', 11.5, 'Shared Space', 320.0),
('Calle Nueva 15', 7, 'Bedroom', 16.0, 'Rented', 420.0),
('Calle Nueva 15', 7, 'Bedroom', 15.5, 'Available', 410.0),
('Calle de la Paz 5', 8, 'Bedroom', 10.0, 'Available', 290.0),
('Calle de la Paz 5', 8, 'Bedroom', 9.5, 'Rented', 270.0),
('Avenida de Madrid 101', 9, 'Bedroom', 22.0, 'Available', 650.0),
('Avenida de Madrid 101', 9, 'Bedroom', 18.0, 'Rented', 550.0),
('Avenida de Madrid 101', 9, 'Bedroom', 15.0, 'Available', 450.0),
('Calle del Sol 7', 10, 'Bedroom', 14.0, 'Shared Space', 360.0),
('Calle del Sol 7', 10, 'Bedroom', 13.5, 'Available', 350.0),
('Plaza Mayor 10', 11, 'Bedroom', 17.5, 'Rented', 480.0),
('Plaza Mayor 10', 11, 'Bedroom', 16.5, 'Available', 460.0),
('Calle Valencia 4', 12, 'Bedroom', 12.0, 'Available', 310.0),
('Calle Valencia 4', 12, 'Bedroom', 11.5, 'Rented', 300.0),
('Avenida de Francia 12', 13, 'Bedroom', 15.5, 'Available', 420.0),
('Avenida de Francia 12', 13, 'Bedroom', 14.0, 'Shared Space', 380.0),
('Calle de la Iglesia 2', 14, 'Bedroom', 13.0, 'Rented', 340.0),
('Calle de la Iglesia 2', 14, 'Bedroom', 12.5, 'Available', 330.0),
('Paseo de la Estación 33', 15, 'Bedroom', 19.0, 'Available', 520.0),
('Paseo de la Estación 33', 15, 'Bedroom', 18.0, 'Rented', 500.0),
('Calle Real 50', 16, 'Bedroom', 11.5, 'Available', 295.0),
('Calle Real 50', 16, 'Bedroom', 10.8, 'Rented', 280.0),
('Avenida de los Chopos 21', 17, 'Bedroom', 14.8, 'Shared Space', 375.0),
('Avenida de los Chopos 21', 17, 'Bedroom', 13.0, 'Available', 350.0),
('Calle de las Flores 9', 18, 'Bedroom', 16.5, 'Rented', 440.0),
('Calle de las Flores 9', 18, 'Bedroom', 15.5, 'Available', 420.0),
('Plaza de España 5', 19, 'Bedroom', 21.0, 'Available', 590.0),
('Plaza de España 5', 19, 'Bedroom', 19.0, 'Rented', 540.0),
('Calle de la Luna 11', 20, 'Bedroom', 13.5, 'Available', 360.0),
('Calle de la Luna 11', 20, 'Bedroom', 12.0, 'Shared Space', 330.0),
('Avenida de la Constitución 40', 32, 'Bedroom', 15.0, 'Rented', 410.0),
('Avenida de la Constitución 40', 32, 'Bedroom', 14.5, 'Available', 400.0),
('Avenida de la Constitución 40', 32, 'Bedroom', 13.0, 'Rented', 380.0),
('Calle de Alcalá 200', 33, 'Bedroom', 25.0, 'Available', 750.0),
('Calle de Alcalá 200', 33, 'Bedroom', 22.5, 'Rented', 700.0),
('Calle de Alcalá 200', 33, 'Bedroom', 20.0, 'Available', 650.0),
('Calle de la Victoria 14', 37, 'Bedroom', 16.0, 'Shared Space', 430.0),
('Calle de la Victoria 14', 37, 'Bedroom', 15.5, 'Available', 420.0),
('Calle de la Victoria 14', 37, 'Bedroom', 14.0, 'Rented', 400.0),
('Avenida de Andalucía 55', 38, 'Bedroom', 18.0, 'Available', 490.0),
('Avenida de Andalucía 55', 38, 'Bedroom', 17.5, 'Rented', 480.0),
('Avenida de Andalucía 55', 38, 'Bedroom', 16.0, 'Available', 450.0),
('Calle Sierpes 10', 39, 'Bedroom', 14.5, 'Rented', 380.0),
('Calle Sierpes 10', 39, 'Bedroom', 13.5, 'Available', 360.0),
('Calle Sierpes 10', 39, 'Bedroom', 12.0, 'Shared Space', 340.0),
('Calle Mayor 12', 1, 'Bedroom', 11.0, 'Available', 300.0),
('Avenida de la Libertad 45', 2, 'Bedroom', 12.5, 'Available', 350.0),
('Calle del Mar 3', 3, 'Bedroom', 10.5, 'Rented', 290.0),
('Calle San José 22', 5, 'Bedroom', 11.8, 'Available', 310.0),
('Avenida Mediterráneo 88', 6, 'Bedroom', 13.0, 'Available', 340.0);
go

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

INSERT INTO ROOM_FURNITURE (FurnitureID, PropertyAddress, PropertyCityID, RoomNumber, Quantity)
VALUES
(2, 'Calle Mayor 12', 1, 1, 1), (15, 'Calle Mayor 12', 1, 1, 1),
(2, 'Calle Mayor 12', 1, 2, 1), (4, 'Calle Mayor 12', 1, 2, 2),
(2, 'Calle Mayor 12', 1, 3, 1)
go
INSERT INTO ROOM_FURNITURE (FurnitureID, PropertyAddress, PropertyCityID, RoomNumber, Quantity)
VALUES
(2, 'Avenida de la Libertad 45', 2, 4, 1), (1, 'Avenida de la Libertad 45', 2, 4, 1),
(2, 'Avenida de la Libertad 45', 2, 5, 1), (15, 'Avenida de la Libertad 45', 2, 5, 1)
go
INSERT INTO ROOM_FURNITURE (FurnitureID, PropertyAddress, PropertyCityID, RoomNumber, Quantity)
VALUES
(2, 'Calle del Mar 3', 3, 6, 1), (8, 'Calle del Mar 3', 3, 6, 1),
(2, 'Calle del Mar 3', 3, 7, 1), (4, 'Calle del Mar 3', 3, 7, 1)
INSERT INTO ROOM_FURNITURE (FurnitureID, PropertyAddress, PropertyCityID, RoomNumber, Quantity)
VALUES
(2, 'Plaza de la Constitución 1', 4, 8, 1), (15, 'Plaza de la Constitución 1', 4, 8, 1),
(2, 'Plaza de la Constitución 1', 4, 9, 1), (21, 'Plaza de la Constitución 1', 4, 9, 2),
(2, 'Plaza de la Constitución 1', 4, 10, 1)
go
INSERT INTO ROOM_FURNITURE (FurnitureID, PropertyAddress, PropertyCityID, RoomNumber, Quantity)
VALUES
(2, 'Calle San José 22', 5, 11, 1), (4, 'Calle San José 22', 5, 11, 1),
(2, 'Calle San José 22', 5, 12, 1), (15, 'Calle San José 22', 5, 12, 1)
go
INSERT INTO ROOM_FURNITURE (FurnitureID, PropertyAddress, PropertyCityID, RoomNumber, Quantity)
VALUES
(2, 'Avenida Mediterráneo 88', 6, 13, 1), (1, 'Avenida Mediterráneo 88', 6, 13, 1),
(2, 'Avenida Mediterráneo 88', 6, 14, 1), (18, 'Avenida Mediterráneo 88', 6, 14, 1)
go
INSERT INTO ROOM_FURNITURE (FurnitureID, PropertyAddress, PropertyCityID, RoomNumber, Quantity)
VALUES
(2, 'Calle Nueva 15', 7, 15, 1), (15, 'Calle Nueva 15', 7, 15, 1),
(2, 'Calle Nueva 15', 7, 16, 1), (4, 'Calle Nueva 15', 7, 16, 2)
go
INSERT INTO ROOM_FURNITURE (FurnitureID, PropertyAddress, PropertyCityID, RoomNumber, Quantity)
VALUES
(2, 'Calle de la Paz 5', 8, 17, 1), (8, 'Calle de la Paz 5', 8, 17, 1),
(2, 'Calle de la Paz 5', 8, 18, 1), (15, 'Calle de la Paz 5', 8, 18, 1)
go
INSERT INTO ROOM_FURNITURE (FurnitureID, PropertyAddress, PropertyCityID, RoomNumber, Quantity)
VALUES
(2, 'Avenida de Madrid 101', 9, 19, 1), (1, 'Avenida de Madrid 101', 9, 19, 1),
(2, 'Avenida de Madrid 101', 9, 20, 1), (4, 'Avenida de Madrid 101', 9, 20, 2)
go
INSERT INTO ROOM_FURNITURE (FurnitureID, PropertyAddress, PropertyCityID, RoomNumber, Quantity)
VALUES
(2, 'Avenida de Madrid 101', 9, 21, 1)
go

INSERT INTO ROOM_FURNITURE (FurnitureID, PropertyAddress, PropertyCityID, RoomNumber, Quantity)
VALUES
(2, 'Plaza Mayor 10', 11, 24, 1), (4, 'Plaza Mayor 10', 11, 24, 1),
(2, 'Plaza Mayor 10', 11, 25, 1), (15, 'Plaza Mayor 10', 11, 25, 1)
go
INSERT INTO ROOM_FURNITURE (FurnitureID, PropertyAddress, PropertyCityID, RoomNumber, Quantity)
VALUES
(2, 'Calle Valencia 4', 12, 26, 1), (1, 'Calle Valencia 4', 12, 26, 1),
(2, 'Calle Valencia 4', 12, 27, 1), (18, 'Calle Valencia 4', 12, 27, 1)
go
INSERT INTO ROOM_FURNITURE (FurnitureID, PropertyAddress, PropertyCityID, RoomNumber, Quantity)
VALUES
(2, 'Avenida de Francia 12', 13, 28, 1), (4, 'Avenida de Francia 12', 13, 28, 2),
(2, 'Avenida de Francia 12', 13, 29, 1), (15, 'Avenida de Francia 12', 13, 29, 1)
go
INSERT INTO ROOM_FURNITURE (FurnitureID, PropertyAddress, PropertyCityID, RoomNumber, Quantity)
VALUES
(2, 'Calle de la Iglesia 2', 14, 30, 1), (22, 'Calle de la Iglesia 2', 14, 30, 1),
(2, 'Calle de la Iglesia 2', 14, 31, 1), (4, 'Calle de la Iglesia 2', 14, 31, 1)
go
INSERT INTO ROOM_FURNITURE (FurnitureID, PropertyAddress, PropertyCityID, RoomNumber, Quantity)
VALUES
(2, 'Paseo de la Estación 33', 15, 32, 1), (15, 'Paseo de la Estación 33', 15, 32, 1),
(2, 'Paseo de la Estación 33', 15, 33, 1), (1, 'Paseo de la Estación 33', 15, 33, 1)
go
INSERT INTO ROOM_FURNITURE (FurnitureID, PropertyAddress, PropertyCityID, RoomNumber, Quantity)
VALUES
(2, 'Calle Real 50', 16, 34, 1), (18, 'Calle Real 50', 16, 34, 1),
(2, 'Calle Real 50', 16, 35, 1), (4, 'Calle Real 50', 16, 35, 1)
go
INSERT INTO ROOM_FURNITURE (FurnitureID, PropertyAddress, PropertyCityID, RoomNumber, Quantity)
VALUES
(2, 'Avenida de los Chopos 21', 17, 36, 1), (15, 'Avenida de los Chopos 21', 17, 36, 1),
(2, 'Avenida de los Chopos 21', 17, 37, 1), (21, 'Avenida de los Chopos 21', 17, 37, 2)
go
INSERT INTO ROOM_FURNITURE (FurnitureID, PropertyAddress, PropertyCityID, RoomNumber, Quantity)
VALUES
(2, 'Calle de las Flores 9', 18, 38, 1), (1, 'Calle de las Flores 9', 18, 38, 1),
(2, 'Calle de las Flores 9', 18, 39, 1), (4, 'Calle de las Flores 9', 18, 39, 1)
go
INSERT INTO ROOM_FURNITURE (FurnitureID, PropertyAddress, PropertyCityID, RoomNumber, Quantity)
VALUES
(2, 'Plaza de España 5', 19, 40, 1), (15, 'Plaza de España 5', 19, 40, 1);

go

insert into CONTRACT (SignatureDate,TenantDni,RoomNumber,PropertyAddress,PropertyCityID,PricePerMonth,StartingDate,EndingDate,Status)
values
('14/01/2025','72349581B',1,'Calle Mayor 12',1,'350,00','15/01/2025','14/10/2025','Ended'),
('29/01/2025','91368025L',2,'Calle Mayor 12',1,'400,00','30/01/2025','29/10/2025','Ended'),
('11/02/2025','24691358P',3,'Calle Mayor 12',1,'300,00','12/02/2025','11/11/2025','Ended'),
('25/02/2025','80257914K',4,'Avenida de la Libertad 45',2,'500,00','26/02/2025','25/11/2025','Ended'),
('08/03/2025','68035792I',5,'Avenida de la Libertad 45',2,'450,00','09/03/2025','08/12/2025','Ended'),
('19/03/2025','58271634E',6,'Calle del Mar 3',3,'280,00','20/03/2025','19/12/2025','Ended'),
('04/04/2025','13579246T',7,'Calle del Mar 3',3,'310,00','05/04/2025','04/01/2026','Ended'),
('22/04/2025','02479136X',8,'Plaza de la Constitución 1',4,'600,00','23/04/2025','22/01/2026','Ended'),
('03/05/2025','80257914V',9,'Plaza de la Constitución 1',4,'580,00','04/05/2025','03/02/2026','Ended'),
('17/05/2025','76543210S',10,'Plaza de la Constitución 1',4,'450,00','18/05/2025','17/02/2026','Ended'),
('30/05/2025','34567890K',11,'Calle San José 22',5,'340,00','31/05/2025','28/02/2026','Ended'),
('14/06/2025','23456789Q',12,'Calle San José 22',5,'340,00','15/06/2025','14/03/2026','Ended'),
('02/07/2025','67890123L',13,'Avenida Mediterráneo 88',6,'390,00','03/07/2025','02/04/2026','Ended'),
('26/07/2025','80257914A',14,'Avenida Mediterráneo 88',6,'320,00','27/07/2025','26/04/2026','Ended'),
('11/08/2025','89012345P',15,'Calle Nueva 15',7,'420,00','12/08/2025','11/05/2026','Ended'),
('29/08/2025','13580247Y',16,'Calle Nueva 15',7,'410,00','30/08/2025','29/05/2026','Ongoing'),
('15/09/2025','10582736C',17,'Calle de la Paz 5',8,'290,00','16/09/2025','15/06/2026','Ongoing'),
('05/10/2025','13580247D',18,'Calle de la Paz 5',8,'270,00','06/10/2025','05/07/2026','Ongoing'),
('21/10/2025','02479136C',19,'Avenida de Madrid 101',9,'650,00','22/10/2025','21/07/2026','Ongoing'),
('12/11/2025','46813570R',20,'Avenida de Madrid 101',9,'550,00','13/11/2025','12/08/2026','Ongoing'),
('03/12/2025','57924681X',21,'Avenida de Madrid 101',9,'450,00','04/12/2025','03/09/2026','Ongoing'),
('27/12/2025','35702469F',22,'Calle del Sol 7',10,'360,00','28/12/2025','27/09/2026','Ongoing'),
('09/01/2026','57924681S',23,'Calle del Sol 7',10,'350,00','10/01/2026','09/10/2026','Ongoing'),
('02/02/2026','12345098H',24,'Plaza Mayor 10',11,'480,00','03/02/2026','02/11/2026','Ongoing'),
('20/02/2026','90123456J',25,'Plaza Mayor 10',11,'460,00','21/02/2026','20/11/2026','Ongoing')

go

insert into REPORT (ReportDate,UserDni,RoomNumber,PropertyAddress,PropertyCityID,Issue,Details,Status)
values
('15/02/2025','72349581B',1,'Calle Mayor 12',1,'Cama rota','Se ha roto la cabecera de la cama','Checked'),
('28/02/2025','91368025L',2,'Calle Mayor 12',1,'Mesita de noche coja','Se ha roto una pata de la mesita de noche','Checked'),
('15/02/2025','24691358P',3,'Calle Mayor 12',1,'Luz rota','La luz de mi habitación no funciona','Checked'),
('02/03/2025','80257914K',4,'Avenida de la Libertad 45',2,'Nevera rota','La nevera no mantiene el frío','Checked'),
('10/05/2025','68035792I',5,'Avenida de la Libertad 45',2,'Escritorio cojo','El escritorio de mi habitación se tambalea','Checked'),
('21/03/2025','58271634E',6,'Calle del Mar 3',3,'Lavavajillas roto','El lavavajillas no limpia bien','Checked'),
('05/05/2025','13579246T',7,'Calle del Mar 3',3,'Cama rota','El colchón de mi cama es incómodo','Checked'),
('01/06/2025','02479136X',8,'Plaza de la Constitución 1',4,'Luz pasillo','La luz del pasillo parpadea al encenderla','Checked'),
('30/05/2025','80257914V',9,'Plaza de la Constitución 1',4,'Persiana rota','La persiana de mi habitación no baja','Checked'),
('10/10/2025','76543210S',10,'Plaza de la Constitución 1',4,'Espejo roto','El espejo del baño se ha roto al verme la cara','Checked')
go


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

------------------------------------------------------
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
-- No deletes are permitted on REPORTS
CREATE OR ALTER TRIGGER DELETE_REPORT_BLOCKADE
ON REPORT
INSTEAD OF DELETE
AS
BEGIN
	PRINT 'Deletes over REPORT are not permitted.'
END
GO

----------------------------------------------------------------
CREATE OR ALTER TRIGGER BLOCK_PROVINCE_DELETE_TRIGGER
ON PROVINCE
INSTEAD OF DELETE
AS
BEGIN
	PRINT 'Delete are not permitted for PROVINCE table.'
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
