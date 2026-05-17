package org.example.demo.objects.users;

import java.time.LocalDate;

public class Owner extends User
{
    private Integer numberProperties;

    public Owner(String dni, String name, String surnames, LocalDate birthdate, String phoneNumber, String email, String password, Integer numberProperties)
    {
        super(dni, name, surnames, birthdate, phoneNumber, email, password);
        this.numberProperties = numberProperties;
    }

    public Owner(String dni, String name, String surnames, LocalDate birthdate, String phoneNumber, String email, String password)
    {
        this(dni, name, surnames, birthdate, phoneNumber, email, password, 0);
    }

    public Integer getNumeberProperties() {
        return numberProperties;
    }
}
