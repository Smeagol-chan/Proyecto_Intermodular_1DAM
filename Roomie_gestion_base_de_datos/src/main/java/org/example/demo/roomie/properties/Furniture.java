package org.example.demo.roomie.properties;

public class Furniture
{
    private int number;
    private Room room;
    private String name;
    private FurnitureCategory category;
    private int quantity;

    public Furniture(int number, Room room, String name, FurnitureCategory category, int quantity)
    {
        this.number = number;
        this.room = room;
        this.name = name;
        this.category = category;
        this.quantity = quantity;
    }

    public int getNumber() {
        return number;
    }

    public Room getRoom() {
        return room;
    }

    public String getName() {
        return name;
    }

    public FurnitureCategory getCategory() {
        return category;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}
