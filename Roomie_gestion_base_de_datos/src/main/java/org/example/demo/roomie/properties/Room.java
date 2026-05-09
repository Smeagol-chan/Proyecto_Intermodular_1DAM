package org.example.demo.roomie.properties;

import org.example.demo.roomie.paperwork.Report;
import org.example.demo.roomie.shared_usage.expections.IllegalStatusException;
import org.example.demo.roomie.shared_usage.expections.UnableToRemoveException;

import java.util.*;

public class Room
{
    private static final String[] STATUS_PERMITTED = {"Available", "Rented", "Shared Space"};

    private int number;
    private Property property;
    private RoomType type;
    private double surface;
    private String status;
    private double price;
    private HashMap<Furniture, Integer> furnitureMap;
    private ArrayList<Report> reportsList;

    private void setAttributes(int number, Property property, String type, double surface, double price)
    {
        this.number = number;
        this.property = property;
        setType(type);
        this.surface = surface;
        this.price = price;
        furnitureMap = new HashMap<>();
        reportsList = new ArrayList<>();
    }

    public Room(int number, Property property, String type, double surface, double price)
    {
        setAttributes(number, property, type, surface, price);
        setDefaultStatus();
    }

    public Room(int number, Property property, String type, double surface, String status, double price)
    {
        setAttributes(number, property, type, surface, price);
        setStatus(status);
    }

    public int getNumber() {
        return number;
    }

    public Property getProperty() {
        return property;
    }

    public String getType()
    {
        return type.getRoomName();
    }

    public void setType(String type)
    {
        this.type = RoomType.valueOf(type.toUpperCase());
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

    public void setStatus(String status)
    {
        if(Arrays.asList(STATUS_PERMITTED).contains(status)) this.status = status;
        else throw new IllegalStatusException();
    }

    private void setDefaultStatus()
    {
        if(type.getSharedSpace()) status = "Shared Space";
        else status = "Available";
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public Map<Furniture, Integer> getFurnitureMap()
    {
        return Collections.unmodifiableMap(furnitureMap);
    }

    public void addFurniture(Furniture furniture, Integer quantity)
    {
        if(furnitureMap.containsKey(furniture)) furnitureMap.put(furniture, furnitureMap.get(furniture) + quantity);
        else furnitureMap.put(furniture, quantity);
    }

    public void removeFurniture(Furniture furniture, Integer quantity)
    {
        if(furnitureMap.containsKey(furniture))
        {
            if(furnitureMap.get(furniture) >= quantity) furnitureMap.put(furniture, furnitureMap.get(furniture) - quantity);
            else furnitureMap.remove(furniture);
        }
        else throw new UnableToRemoveException();
    }

    public List<Report> getReportsList()
    {
        return Collections.unmodifiableList(reportsList);
    }

    public void addReport(Report report)
    {
        reportsList.add(report);
    }

    @Override
    public boolean equals(Object o) {
        if (o == null || getClass() != o.getClass()) return false;
        Room room = (Room) o;
        return number == room.number && Objects.equals(property, room.property);
    }

    @Override
    public int hashCode() {
        return Objects.hash(number, property);
    }
}
