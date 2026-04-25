package org.example.demo.Clases;

public class Room {
    private int roomNumber;
    private String propertyAddress;
    private String type;
    private double surface;
    private String status;
    private double pricePerMonth;

    public Room(int roomNumber, Property property, String type, double surface, String status, double pricePerMonth) {
        this.roomNumber = roomNumber;
        this.propertyAddress = property.getAddress();
        this.type = type;
        this.surface = surface;
        this.status = status;
        this.pricePerMonth = pricePerMonth;
    }

    public int getRoomNumber() {
        return roomNumber;
    }

    public void setRoomNumber(int roomNumber) {
        this.roomNumber = roomNumber;
    }

    public String getPropertyAddress() {
        return propertyAddress;
    }

    public void setPropertyAddress(String propertyAddress) {
        this.propertyAddress = propertyAddress;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public double getSurface() {
        return surface;
    }

    public void setSurface(double surface) {
        this.surface = surface;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public double getPricePerMonth() {
        return pricePerMonth;
    }

    public void setPricePerMonth(double pricePerMonth) {
        this.pricePerMonth = pricePerMonth;
    }

    @Override
    public String toString() {
        return "Room{" +
                "roomNumber=" + roomNumber +
                ", propertyAddress='" + propertyAddress + '\'' +
                ", type='" + type + '\'' +
                ", surface=" + surface +
                ", status='" + status + '\'' +
                ", pricePerMonth=" + pricePerMonth +
                '}';
    }
}
