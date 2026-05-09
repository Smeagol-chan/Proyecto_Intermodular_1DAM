package org.example.demo.roomie.shared_usage.interfaces;

import org.example.demo.roomie.properties.Property;

import java.util.Set;

public interface ManagePropertiesOnList
{
    void addProperty(Property property);
    void removeProperty(Property property);
    Set<Property> getPropertiesList();
}
