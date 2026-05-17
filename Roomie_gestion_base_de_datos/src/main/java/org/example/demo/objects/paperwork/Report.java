package org.example.demo.objects.paperwork;

import java.time.LocalDateTime;

public class Report
{
    private Integer reportID;
    private LocalDateTime reportDate;
    private String userDni;
    private Integer roomNumber;
    private String propertyAddress;
    private Integer propertyCityId;
    private String issue;
    private String details;
    private String status;

    public Report(Integer reportID, LocalDateTime reportDate, String userDni, Integer roomNumber, String propertyAddress, Integer propertyCityId, String issue, String details, String status)
    {
        this.reportID = reportID;
        this.reportDate = reportDate;
        this.userDni = userDni;
        this.roomNumber = roomNumber;
        this.propertyAddress = propertyAddress;
        this.propertyCityId = propertyCityId;
        this.issue = issue;
        this.details = details;
        this.status = status;
    }

    public Report(LocalDateTime reportDate, String userDni, Integer roomNumber, String propertyAddress, Integer propertyCityId, String issue, String details, String status)
    {
        this(null, reportDate, userDni, roomNumber, propertyAddress, propertyCityId, issue, details, status);
    }

    public Integer getReportID() {
        return reportID;
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

    public Integer getPropertyCityId() {
        return propertyCityId;
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
