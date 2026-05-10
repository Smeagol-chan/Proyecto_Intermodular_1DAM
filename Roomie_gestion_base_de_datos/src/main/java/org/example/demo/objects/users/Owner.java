package org.example.demo.objects.users;

import java.time.LocalDate;

public class Owner extends User
{
    public Owner(String dni, String name, String surnames, LocalDate birthdate, String phoneNumber, String email, String password)
    {
        super(dni, name, surnames, birthdate, phoneNumber, email, password);
    }
}
