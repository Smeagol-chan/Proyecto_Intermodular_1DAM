package org.example.demo.Clases;

import java.time.LocalDate;

public class Report {
    private LocalDate reportDate;
    private String userDni;
    private int roomNumber;
    private String propertyAddress;
    private String issue;
    private String details;
    private String status;

    public Report(LocalDate reportDate, User user, Room room, Property property, String issue, String details, String status) {
        this.reportDate = reportDate;
        this.userDni = user.getDni();
        this.roomNumber = room.getRoomNumber();
        this.propertyAddress = property.getAddress();
        this.issue = issue;
        this.details = details;
        this.status = status;
    }

    public LocalDate getReportDate() {
        return reportDate;
    }

    public void setReportDate(LocalDate reportDate) {
        this.reportDate = reportDate;
    }

    public String getUserDni() {
        return userDni;
    }

    public void setUserDni(String userDni) {
        this.userDni = userDni;
    }

    public int getRoomNumber() {
        return roomNumber;
    }

    public void setRoomNumber(int roomNumber) {
        this.roomNumber = roomNumber;
    }

    public String getPropertyAddress() {
        return propertyAddress;
    }

    public void setPropertyAddress(String propertyAddress) {
        this.propertyAddress = propertyAddress;
    }

    public String getIssue() {
        return issue;
    }

    public void setIssue(String issue) {
        this.issue = issue;
    }

    public String getDetails() {
        return details;
    }

    public void setDetails(String details) {
        this.details = details;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Report{" +
                "reportDate=" + reportDate +
                ", userDni='" + userDni + '\'' +
                ", roomNumber=" + roomNumber +
                ", propertyAddress='" + propertyAddress + '\'' +
                ", issue='" + issue + '\'' +
                ", details='" + details + '\'' +
                ", status='" + status + '\'' +
                '}';
    }
}
