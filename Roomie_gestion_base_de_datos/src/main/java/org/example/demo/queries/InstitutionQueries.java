package org.example.demo.queries;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import org.example.demo.objects.locations.Institution;
import org.example.demo.objects.properties.Property;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Arrays;
import java.util.Queue;
import java.util.Stack;
import java.util.concurrent.ArrayBlockingQueue;

public class InstitutionQueries
{
    // INSTITUTION debería ser débil o, como mínimo, tener un constrain para evitar que repitan institutos en la misma ciudad.
    // El programa permite insertarlo y aquí petará.
    // @author Eric
    public static Integer getIdbyNameCity(Connection connection, String institutionString)
    {
        Queue<String> institutionNameCity = new ArrayBlockingQueue<>(3);

        institutionNameCity.addAll(Arrays.asList(institutionString.split(", ")));

        String query = "SELECT InstitutionID FROM INSTITUTION" +
                " WHERE InstitutionName = '"+ institutionNameCity.poll() +"'" +
                " AND CityID = "+ CityQueries.getCityIdByCityNameProvinceName(connection, institutionNameCity.poll() +", "+ institutionNameCity.poll());

        Statement stmt;
        ResultSet result;

        int institutionID;

        try
        {
            stmt = connection.createStatement();
            result = stmt.executeQuery(query);

            result.next();

            institutionID = result.getInt("InstitutionID");
        }
        catch(SQLException e)
        {
            System.out.println(e.getMessage());
            throw new RuntimeException(e);
        }
        return institutionID;
    }

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
