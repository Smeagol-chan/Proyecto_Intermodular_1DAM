package org.example.demo.objects.properties;

public class RoomFurniture
{
    private Integer furnitureId;
    private String propertyAddress;
    private Integer cityID;
    private Integer roomNumber;
    private Integer quantity;
    private String furnitureName;

    public RoomFurniture(Integer furnitureId, Integer cityID, String propertyAddress, Integer roomNumber, Integer quantity) {
        this.furnitureId = furnitureId;
        this. cityID = cityID;
        this.propertyAddress = propertyAddress;
        this.roomNumber = roomNumber;
        this.quantity = quantity;
    }

    public RoomFurniture(Integer furnitureId, Integer cityID, String propertyAddress, Integer roomNumber, Integer quantity, String furnitureName) {
        this(furnitureId, cityID, propertyAddress, roomNumber, quantity);
        this.furnitureName = furnitureName;
    }

    public int getFurnitureId() {
        return furnitureId;
    }

    public String getPropertyAddress() {
        return propertyAddress;
    }

    public int getRoomNumber() {
        return roomNumber;
    }

    public int getQuantity() {
        return quantity;
    }

    public Integer getCityID() {
        return cityID;
    }

    public String getFurnitureName() {
        return furnitureName;
    }
}
