package org.example.demo.roomie.users;

import java.time.LocalDate;

public abstract class User
{
    protected String dni;
    protected String name;
    protected String surnames;
    protected LocalDate birthdate;
    protected String phoneNumber;
    protected String email;
    protected String password;

    public User(String dni, String name, String surnames, LocalDate birthdate, String phoneNumber, String email, String password)
    {
        this.dni = dni;
        this.name = name;
        this.surnames = surnames;
        this.birthdate = birthdate;
        this.phoneNumber = phoneNumber;
        this.email = email;
        this.password = password;
    }

    public String getDni() {
        return dni;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSurnames() {
        return surnames;
    }

    public void setSurnames(String surnames) {
        this.surnames = surnames;
    }

    public LocalDate getBirthdate() {
        return birthdate;
    }

    public void setBirthdate(LocalDate birthdate) {
        this.birthdate = birthdate;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}