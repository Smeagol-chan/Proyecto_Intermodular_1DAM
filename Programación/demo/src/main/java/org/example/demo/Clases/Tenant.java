package org.example.demo.Clases;

import java.time.LocalDate;

public class Tenant extends  User{
    private String studentLicense;

    public Tenant(String dni, String name, String lastname, LocalDate birthday, String phoneNumber, String email, String password,String studentLicense) {

        super(dni, name, lastname, birthday, phoneNumber, email, password);
        this.studentLicense = studentLicense;
    }

    public String getStudentLicense() {
        return studentLicense;
    }

    public void setStudentLicense(String studentLicense) {
        this.studentLicense = studentLicense;
    }

    @Override
    public String toString() {
        return "Tenant{" +
                "studentLicense='" + studentLicense + '\'' +
                "} " + super.toString();
    }
}
