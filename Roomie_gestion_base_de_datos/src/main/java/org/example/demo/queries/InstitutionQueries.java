package org.example.demo.queries;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import org.example.demo.objects.locations.Institution;
import org.example.demo.objects.properties.Property;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class InstitutionQueries
{
    public static ObservableList<Institution> selectAll(Connection connection)
    {
        ObservableList<Institution> institutionsList = FXCollections.observableArrayList();

        String query = "SELECT * FROM INSTITUTION";

        Statement stmt;
        ResultSet result;

        try
        {
            stmt = connection.createStatement();
            result = stmt.executeQuery(query);

            while(result.next())
            {
                int institutionID = result.getInt("InstitutionID");
                int cityID = result.getInt("CityID");
                String institutionName = result.getString("InstitutionName");
                institutionsList.add(new Institution(institutionID, institutionName, cityID));
            }

        }
        catch(SQLException e)
        {
            System.out.println(e.getMessage());
            throw new RuntimeException(e);
        }
        return institutionsList;
    }

    public static void insert(Connection connection, Institution institution)
    {
        String query = "INSERT INTO INSTITUTION (CityID, InstitutionName)" +
                " VALUES ("+ institution.getCityId() +
                ", '"+ institution.getInstitutionName() +"')";

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

    public static void delete(Connection connection, int institutionID)
    {
        String query = "DELETE FROM INSTITUTION" +
                " WHERE InstitutionID = "+ institutionID;

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

    public static void update(Connection connection, Institution institution)
    {
        String query = "UPDATE INSTITUTION" +
                " SET InstitutionName = '"+ institution.getInstitutionName() +"'" +
                " WHERE CityID = "+ institution.getInstitutionId();

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
