package org.example.demo.roomie.locations;

import org.example.demo.roomie.properties.Property;
import org.example.demo.roomie.shared_usage.expections.UnableToAddException;
import org.example.demo.roomie.shared_usage.expections.UnableToRemoveException;
import org.example.demo.roomie.shared_usage.interfaces.ManagePropertiesOnList;

import java.util.Collections;
import java.util.HashSet;
import java.util.Objects;
import java.util.Set;

public class Institution implements ManagePropertiesOnList
{
    private int id;
    private String name;
    private City city;
    private HashSet<Property> propertiesNearBy;

    public Institution(int id, String name, City city)
    {
        this.id = id;
        this.name = name;
        this.city = city;
        propertiesNearBy = new HashSet<>();
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public City getCity() {
        return city;
    }

    public void setCity(City city) {
        this.city = city;
    }

    public Set<Property> getPropertiesList()
    {
        return Collections.unmodifiableSet(propertiesNearBy);
    }

    public void addProperty(Property property)
    {
        if(propertiesNearBy.contains(property)) throw new UnableToAddException();
        else propertiesNearBy.add(property);
    }

    public void removeProperty(Property property)
    {
        if(propertiesNearBy.contains(property)) propertiesNearBy.remove(property);
        else throw new UnableToRemoveException();
    }

    @Override
    public boolean equals(Object o) {
        if (o == null || getClass() != o.getClass()) return false;
        Institution that = (Institution) o;
        return id == that.id;
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(id);
    }
}
