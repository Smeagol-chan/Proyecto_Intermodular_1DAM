package org.example.demo.roomie.properties;

import java.util.ArrayList;

public class Room
{
    private int number;
    private Property property;
    private String type;
    private double surface;
    private String status;
    private double price;
    private ArrayList<Furniture> furnituresList;

    public Room(int number, Property property, String type, double surface, String status, double price)
    {
        this.number = number;
        this.property = property;
        this.type = type;
        this.surface = surface;
        this.status = status;
        this.price = price;
        furnituresList = new ArrayList<>();
    }

    public int getNumber() {
        return number;
    }

    public Property getProperty() {
        return property;
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

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }
}
