package org.example.demo.objects.properties;

public class Room
{
    private int roomNumber;
    private int propertyAddress;
    private String type;
    private double surface;
    private String status;
    private double pricePerMonth;

    public Room(int roomNumber, int propertyAddress, String type, double surface, String status, double pricePerMonth) {
        this.roomNumber = roomNumber;
        this.propertyAddress = propertyAddress;
        this.type = type;
        this.surface = surface;
        this.status = status;
        this.pricePerMonth = pricePerMonth;
    }

    public int getRoomNumber() {
        return roomNumber;
    }

    public int getPropertyAddress() {
        return propertyAddress;
    }

    public String getType() {
        return type;
    }

    public double getSurface() {
        return surface;
    }

    public String getStatus() {
        return status;
    }

    public double getPricePerMonth() {
        return pricePerMonth;
    }
}
