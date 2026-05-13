
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


