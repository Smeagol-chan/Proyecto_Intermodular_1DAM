package org.example.demo.objects.properties;

public class RoomFurniture
{
    private int furnitureId;
    private String propertyAddress;
    private int roomNumber;
    private int quantity;

    public RoomFurniture(int furnitureId, String propertyAddress, int roomNumber, int quantity) {
        this.furnitureId = furnitureId;
        this.propertyAddress = propertyAddress;
        this.roomNumber = roomNumber;
        this.quantity = quantity;
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
}
