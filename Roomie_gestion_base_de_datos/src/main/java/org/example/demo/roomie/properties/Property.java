package org.example.demo.roomie.properties;

import org.example.demo.roomie.shared_usage.expections.IllegalStatusException;
import org.example.demo.roomie.users.Owner;

import java.util.*;

public class Property
{
    private static final String DEFAULT_STATUS = "Pending";
    private static final String[] STATUS_PERMITTED = {"Pending", "Confirmed", "Denied"};

    private String address;
    private Owner owner;
    private String status;
    private double surface;
    private HashSet<Room> roomList;

    public Property(String address, Owner owner, String status, double surface)
    {
        this.address = address;
        this.owner = owner;
        setStatus(status);
        this.surface = surface;
        roomList = new HashSet<>();
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

    public void setStatus(String status)
    {
        if(Arrays.asList(STATUS_PERMITTED).contains(status)) this.status = status;
        else throw new IllegalStatusException();
    }

    public double getSurface() {
        return surface;
    }

    public void setSurface(double surface) {
        this.surface = surface;
    }

    public Set<Room> getRoomList()
    {
        return Collections.unmodifiableSet(roomList);
    }

    public boolean addRoom(Room room)
    {
        if(roomList.contains(room)) return false;
        else
        {
            roomList.add(room);
            return true;
        }
    }

    public boolean removeRoom(Room room)
    {
        if(roomList.contains(room))
        {
            roomList.remove(room);
            return true;
        }
        else return false;
    }

    @Override
    public boolean equals(Object o) {
        if (o == null || getClass() != o.getClass()) return false;
        Property property = (Property) o;
        return Objects.equals(address, property.address);
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(address);
    }
}
