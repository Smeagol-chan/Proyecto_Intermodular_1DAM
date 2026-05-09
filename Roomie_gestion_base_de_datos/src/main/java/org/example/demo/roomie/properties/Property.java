package org.example.demo.roomie.properties;

import org.example.demo.roomie.users.Owner;

import java.util.ArrayList;

public class Property
{
    private static final String DEFAULT_STATUS = "Pending";

    private String address;
    private Owner owner;
    private String status;
    private double surface;
    private ArrayList<Room> roomList;

    public Property(String address, Owner owner, String status, double surface)
    {
        this.address = address;
        this.owner = owner;
        this.status = status;
        this.surface = surface;
        roomList = new ArrayList<>();
    }

    public Property(String address, Owner owner, double surface)
    {
        this(address, owner, DEFAULT_STATUS, surface);
    }

    public String getAddress() {
        return address;
    }

    public Owner getOwner() {
        return owner;
    }

    public void setOwner(Owner owner) {
        this.owner = owner;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public double getSurface() {
        return surface;
    }

    public void setSurface(double surface) {
        this.surface = surface;
    }
}
