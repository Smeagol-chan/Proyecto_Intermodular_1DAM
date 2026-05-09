package org.example.demo.roomie.users;

import org.example.demo.roomie.shared_usage.expections.TenantContractInconsistencyException;
import org.example.demo.roomie.shared_usage.expections.UnrelatedRoomReportException;
import org.example.demo.roomie.paperwork.Contract;
import org.example.demo.roomie.paperwork.Report;
import org.example.demo.roomie.properties.Room;

import java.time.LocalDate;
import java.time.LocalDateTime;

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

    public String getStudentLicense() {
        return studentLicense;
    }

    public void setStudentLicense(String studentLicense) {
        this.studentLicense = studentLicense;
    }

    public void signContract(Contract contract)
    {
        if(currentContract == null) currentContract = contract;
        else throw new TenantContractInconsistencyException("The tenant "+ getSurnames() +", "+ getName() +" has a contract ongoing.");
    }

    public void cancelContract()
    {
        if(currentContract != null) currentContract = null;
        else throw new TenantContractInconsistencyException("The tenant "+ getSurnames() +", "+ getName() +" has no contract signed.");
    }

    @Override
    public void createReport(Room room, String issue, String details)
    {
        if(currentContract == null || currentContract.getRoom().getProperty().equals(room.getProperty()))
            throw new UnrelatedRoomReportException();
        else
            room.addReport(new Report(LocalDateTime.now(), this, room, issue, details));
    }
}
