package org.example.demo.objects.users;

import java.time.LocalDate;

public abstract class User
{
    protected String dni;
    protected String userName;
    protected String surnames;
    protected LocalDate birthdate;
    protected String phoneNumber;
    protected String email;
    protected String password;

    public User(String dni, String userName, String surnames, LocalDate birthdate, String phoneNumber, String email, String password) {
        this.dni = dni;
        this.userName = userName;
        this.surnames = surnames;
        this.birthdate = birthdate;
        this.phoneNumber = phoneNumber;
        this.email = email;
        this.password = password;
    }

    public String getDni() {
        return dni;
    }

    public String getUserName() {
        return userName;
    }

    public String getSurnames() {
        return surnames;
    }

    public LocalDate getBirthdate() {
        return birthdate;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public String getEmail() {
        return email;
    }

    public String getPassword() {
        return password;
    }
}