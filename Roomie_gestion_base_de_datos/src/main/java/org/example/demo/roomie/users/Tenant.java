package org.example.demo.roomie.users;

import org.example.demo.roomie.paperwork.Contract;

import java.time.LocalDate;

public class Tenant extends User
{
    private String studentLicense;
    private Contract currentContract;

    public Tenant(String studentLicense, String dni, String name, String surnames, LocalDate birthdate, String phoneNumber, String email, String password)
    {
        this.studentLicense = studentLicense;
        currentContract = null;
        super(dni, name, surnames, birthdate, phoneNumber, email, password);
    }

    public Tenant(String dni, String name, String surnames, LocalDate birthdate, String phoneNumber, String email, String password)
    {
        this(null, dni, name, surnames, birthdate, phoneNumber, email, password);
    }

    public String getStudentLicense() {
        return studentLicense;
    }

    public void setStudentLicense(String studentLicense) {
        this.studentLicense = studentLicense;
    }

    public void addContract(Contract contract)
    {
        currentContract = contract;
    }

    public void endContract()
    {
        currentContract = null;
    }
}
