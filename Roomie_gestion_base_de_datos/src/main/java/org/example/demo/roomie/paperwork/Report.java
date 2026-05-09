package org.example.demo.roomie.paperwork;

import org.example.demo.roomie.properties.Room;
import org.example.demo.roomie.shared_usage.expections.IllegalStatusException;
import org.example.demo.roomie.users.User;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.Objects;

public class Report
{
    private static final String DEFAULT_STATUS = "Pending";
    private static final String[] STATUS_PERMITTED = {"Pending", "Checked"};

    private LocalDateTime reportDate;
    private User user;
    private Room room;
    private String issue;
    private String details;
    private String status;

    public Report(LocalDateTime reportDate, User user, Room room, String issue, String details, String status)
    {
        this.reportDate = reportDate;
        this.user = user;
        this.room = room;
        this.issue = issue;
        this.details = details;
        setStatus(status);
    }

    public Report(LocalDateTime reportDate, User user, Room room, String issue, String details)
    {
        this(reportDate, user, room, issue, details, DEFAULT_STATUS);
    }

    public LocalDateTime getReportDate() {
        return reportDate;
    }

    public User getUser() {
        return user;
    }

    public Room getRoom() {
        return room;
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

    public void setStatus(String status)
    {
        if(Arrays.asList(STATUS_PERMITTED).contains(status)) this.status = status;
        else throw new IllegalStatusException();
    }

    @Override
    public boolean equals(Object o) {
        if (o == null || getClass() != o.getClass()) return false;
        Report report = (Report) o;
        return Objects.equals(reportDate, report.reportDate) && Objects.equals(user, report.user) && Objects.equals(room, report.room);
    }

    @Override
    public int hashCode() {
        return Objects.hash(reportDate, user, room);
    }
}
