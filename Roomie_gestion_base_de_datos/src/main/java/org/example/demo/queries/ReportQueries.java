package org.example.demo.queries;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import org.example.demo.objects.paperwork.Report;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDateTime;

public class ReportQueries
{
    public static ObservableList<Report> selectAll(Connection connection)
    {
        ObservableList<Report> reportsList = FXCollections.observableArrayList();

        String query = "SELECT * FROM REPORT";

        Statement stmt;
        ResultSet result;

        try
        {
            stmt = connection.createStatement();
            result = stmt.executeQuery(query);

            while(result.next())
            {
                int reportID = result.getInt("ReportID");
                int roomNumber = result.getInt("RoomNumber");
                int cityID = result.getInt("PropertyCityID");

                LocalDateTime reportDate = result.getDate("ReportDate").toLocalDate().atStartOfDay();

                String userDni = result.getString("UserDni");
                String address = result.getString("PropertyAddress");
                String issue = result.getString("Issue");
                String details = result.getString("Details");
                String status = result.getString("Status");

                reportsList.add(new Report(reportID, reportDate, userDni, roomNumber, address, cityID, issue, details, status));
            }

        }
        catch(SQLException e)
        {
            System.out.println(e.getMessage());
            throw new RuntimeException(e);
        }
        return reportsList;
    }

    public static void insert(Connection connection, Report report)
    {
        String query = "INSERT INTO REPORT (ReportDate, UserDni, RoomNumber" +
                ", PropertyAddress, PropertyCityID, Issue, Details, Status)" +
                " VALUES ('"+ report.getReportDate() +"'" +
                ", '"+ report.getUserDni() +"'"+
                ", "+ report.getRoomNumber() +
                ", '"+ report.getPropertyAddress() +"'"+
                ", "+ report.getPropertyCityId() +
                ", '"+ report.getIssue() +"'"+
                ", '"+ report.getDetails() +"'"+
                ", '"+ report.getStatus() +"')";

        Statement stmt;

        try
        {
            stmt = connection.createStatement();
            stmt.executeUpdate(query);
        }
        catch(SQLException e)
        {
            System.out.println(e.getMessage());
            throw new RuntimeException(e);
        }
    }

    public static void delete(Connection connection, int reportID)
    {
        String query = "DELETE FROM REPORT" +
                " WHERE ReportID = "+ reportID;

        Statement stmt;

        try
        {
            stmt = connection.createStatement();
            stmt.executeUpdate(query);
        }
        catch(SQLException e)
        {
            System.out.println(e.getMessage());
            throw new RuntimeException(e);
        }
    }

    public static void update(Connection connection, Report report)
    {
        String query = "UPDATE REPORT" +
                " SET Status = '"+ report.getStatus() +"'" +
                " WHERE ReportID = " + report.getReportID();

        Statement stmt;

        try
        {
            stmt = connection.createStatement();
            stmt.executeUpdate(query);
        }
        catch(SQLException e)
        {
            System.out.println(e.getMessage());
            throw new RuntimeException(e);
        }
    }
}
