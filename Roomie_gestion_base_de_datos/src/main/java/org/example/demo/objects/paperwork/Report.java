package org.example.demo.objects.paperwork;

import java.time.LocalDateTime;

public class Report
{
    private LocalDateTime reportDate;
    private String userDni;
    private int roomNumber;
    private String propertyAddress;
    private String issue;
    private String details;
    private String status;

    public Report(LocalDateTime reportDate, String userDni, int roomNumber, String propertyAddress, String issue, String details, String status) {
        this.reportDate = reportDate;
        this.userDni = userDni;
        this.roomNumber = roomNumber;
        this.propertyAddress = propertyAddress;
        this.issue = issue;
        this.details = details;
        this.status = status;
    }

    public LocalDateTime getReportDate() {
        return reportDate;
    }

    public String getUserDni() {
        return userDni;
    }

    public int getRoomNumber() {
        return roomNumber;
    }

    public String getPropertyAddress() {
        return propertyAddress;
    }

    public String getIssue() {
        return issue;
    }

    public String getDetails() {
        return details;
    }

    public String getStatus() {
        return status;
    }
}
