package org.example.demo.objects.properties;

import org.example.demo.objects.users.User;

public class Property
{
    private String address;
    private Integer cityID;
    private String ownerDni;
    private String status;
    private Double surface;

    public Property(String address, Integer cityID, String ownerDni, String status, Double surface) {
        this.address = address;
        this.cityID = cityID;
        this.ownerDni = ownerDni;
        this.status = status;
        this.surface = surface;
    }

    public String getAddress() {
        return address;
    }

    public Integer getCityID() {
        return cityID;
    }

    public String getOwnerDni() {
        return ownerDni;
    }

    public String getStatus() {
        return status;
    }

    public Double getSurface() {
        return surface;
    }
}
