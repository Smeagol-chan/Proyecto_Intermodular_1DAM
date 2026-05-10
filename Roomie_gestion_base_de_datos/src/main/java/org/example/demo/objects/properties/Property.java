package org.example.demo.objects.properties;

import org.example.demo.objects.users.User;

public class Property
{
    private String address;
    private String ownerDni;
    private String status;
    private double surface;

    public Property(String address, String ownerDni, String status, double surface) {
        this.address = address;
        this.ownerDni = ownerDni;
        this.status = status;
        this.surface = surface;
    }

    public String getAddress() {
        return address;
    }

    public String getOwnerDni() {
        return ownerDni;
    }

    public String getStatus() {
        return status;
    }

    public double getSurface() {
        return surface;
    }
}
