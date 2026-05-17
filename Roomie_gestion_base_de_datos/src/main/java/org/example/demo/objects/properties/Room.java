package org.example.demo.objects.properties;

public class Room
{
    private Integer roomNumber;
    private String propertyAddress;
    private Integer cityID;
    private String type;
    private Double surface;
    private String status;
    private Double pricePerMonth;

    public Room(Integer roomNumber, String propertyAddress, Integer cityID, String type, Double surface, String status, Double pricePerMonth) {
        this.roomNumber = roomNumber;
        this.propertyAddress = propertyAddress;
        this.cityID = cityID;
        this.type = type;
        this.surface = surface;
        this.status = status;
        this.pricePerMonth = pricePerMonth;
    }

    public Room(String propertyAddress, Integer cityID, String type, Double surface, String status, Double pricePerMonth)
    {
        this(null, propertyAddress, cityID, type, surface, status, pricePerMonth);
    }

    public Integer getRoomNumber() {
        return roomNumber;
    }

    public String getPropertyAddress() {
        return propertyAddress;
    }

    public Integer getCityID() {
        return cityID;
    }

    public String getType() {
        return type;
    }

    public Double getSurface() {
        return surface;
    }

    public String getStatus() {
        return status;
    }

    public Double getPricePerMonth() {
        return pricePerMonth;
    }
}
