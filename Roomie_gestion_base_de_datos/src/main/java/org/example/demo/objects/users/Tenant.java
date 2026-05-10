package org.example.demo.objects.users;

import java.time.LocalDate;

public class Tenant extends User
{
    private String studentLicense;

    public Tenant(String dni, String userName, String surnames, LocalDate birthdate, String phoneNumber, String email, String password, String studentLicense)
    {
        super(dni, userName, surnames, birthdate, phoneNumber, email, password);
        this.studentLicense = studentLicense;
    }

    public String getStudentLicense() {
        return studentLicense;
    }
}
