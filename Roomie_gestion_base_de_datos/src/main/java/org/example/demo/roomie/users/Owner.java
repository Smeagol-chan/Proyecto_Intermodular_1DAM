package org.example.demo.roomie.users;

import org.example.demo.roomie.shared_usage.expections.UnableToAddException;
import org.example.demo.roomie.shared_usage.expections.UnableToRemoveException;
import org.example.demo.roomie.shared_usage.expections.UnrelatedRoomReportException;
import org.example.demo.roomie.paperwork.Report;
import org.example.demo.roomie.properties.Property;
import org.example.demo.roomie.properties.Room;
import org.example.demo.roomie.shared_usage.interfaces.ManagePropertiesOnList;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

public class Owner extends User implements ManagePropertiesOnList
{
    private HashSet<Property> propertiesList;

    public Owner(String dni, String name, String surnames, LocalDate birthdate, String phoneNumber, String email, String password)
    {
        propertiesList = new HashSet<>();
        super(dni, name, surnames, birthdate, phoneNumber, email, password);
    }

    public Set<Property> getPropertiesList()
    {
        return Collections.unmodifiableSet(propertiesList);
    }

    public void addProperty(Property property)
    {
        if(propertiesList.contains(property)) throw new UnableToAddException();
        else propertiesList.add(property);
    }

    public void removeProperty(Property property)
    {
        if(propertiesList.contains(property)) propertiesList.remove(property);
        else throw new UnableToRemoveException();
    }

    @Override
    public void createReport(Room room, String issue, String details)
    {
        if(propertiesList.contains(room.getProperty()))
            room.addReport(new Report(LocalDateTime.now(), this, room, issue, details));
        else
            throw new UnrelatedRoomReportException();
    }
}
