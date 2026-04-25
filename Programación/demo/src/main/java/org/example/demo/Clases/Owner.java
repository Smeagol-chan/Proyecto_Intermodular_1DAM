package org.example.demo.Clases;

import java.time.LocalDate;

public class Owner extends User{

    public Owner(String dni, String name, String lastname, LocalDate birthday, String phoneNumber, String email, String password) {
        super(dni, name, lastname, birthday, phoneNumber, email, password);
    }

    @Override
    public String toString() {
        return "Owner{} " + super.toString();
    }
}
