package org.example.demo.Clases;

public class Furniture {
    private int furnitureNumber;
    private String propertyAddress;
    private int roomNumber;
    private String name;
    private int category;
    private int quantity;

    public Furniture(int furnitureNumber, Property property, Room room, String name, Furniture_category Fcategory, int quantity) {
        this.furnitureNumber = furnitureNumber;
        this.propertyAddress = property.getAddress();
        this.roomNumber = room.getRoomNumber();
        this.name = name;
        this.category = Fcategory.getCategoryId();
        this.quantity = quantity;
    }

    public int getFurnitureNumber() {
        return furnitureNumber;
    }

    public void setFurnitureNumber(int furnitureNumber) {
        this.furnitureNumber = furnitureNumber;
    }

    public String getPropertyAddress() {
        return propertyAddress;
    }

    public void setPropertyAddress(String propertyAddress) {
        this.propertyAddress = propertyAddress;
    }

    public int getRoomNumber() {
        return roomNumber;
    }

    public void setRoomNumber(int roomNumber) {
        this.roomNumber = roomNumber;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getCategory() {
        return category;
    }

    public void setCategory(int category) {
        this.category = category;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    @Override
    public String toString() {
        return "Furniture{" +
                "furnitureNumber=" + furnitureNumber +
                ", propertyAddress='" + propertyAddress + '\'' +
                ", roomNumber=" + roomNumber +
                ", name='" + name + '\'' +
                ", category=" + category +
                ", quantity=" + quantity +
                '}';
    }
}
