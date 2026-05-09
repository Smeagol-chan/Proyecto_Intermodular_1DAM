package org.example.demo.roomie.users;

import org.example.demo.roomie.properties.Property;

import java.time.LocalDate;
import java.util.ArrayList;

public class Owner extends User
{
    private ArrayList<Property> propertiesList;

    public Owner(String dni, String name, String surnames, LocalDate birthdate, String phoneNumber, String email, String password)
    {
        propertiesList = new ArrayList<>();
        super(dni, name, surnames, birthdate, phoneNumber, email, password);
    }

    public ArrayList<Property> getPropertiesList() {
        return propertiesList;
    }
}
