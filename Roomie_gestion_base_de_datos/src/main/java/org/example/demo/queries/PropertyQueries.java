package org.example.demo.queries;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import org.example.demo.objects.properties.Property;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class PropertyQueries
{
    public static ObservableList<Property> selectAll(Connection connection)
    {
        ObservableList<Property> propertiesList = FXCollections.observableArrayList();

        String query = "SELECT * FROM PROPERTY";

        Statement stmt;
        ResultSet result;

        try
        {
            stmt = connection.createStatement();
            result = stmt.executeQuery(query);

            while(result.next())
            {
                String address = result.getString("Address");
                int cityID = result.getInt("CityID");
                String ownerDni = result.getString("OwnerDni");
                String status = result.getString("Status");
                double surface = result.getDouble("Surface");
                propertiesList.add(new Property(address, cityID, ownerDni, status, surface));
            }

        }
        catch(SQLException e)
        {
            System.out.println(e.getMessage());
            throw new RuntimeException(e);
        }
        return propertiesList;
    }

    public static void insert(Connection connection, Property property)
    {
        String query = "INSERT INTO PROPERTY (Address, CityID, OwnerDni, Status, Surface)" +
                " VALUES ('"+ property.getAddress() +
                "', '"+ property.getCityID() +
                "', '"+ property.getOwnerDni() +
                "', '"+ property.getStatus() +
                "', '"+ property.getSurface() +"')";

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

    public static void delete(Connection connection, Property property)
    {
        String query = "DELETE FROM PROPERTY" +
                " WHERE Address = '"+ property.getAddress() +"' " +
                "AND CityID = "+ property.getCityID();

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

    public static void update(Connection connection, Property property)
    {
        String query = "UPDATE PROPERTY" +
                " SET OwnerDni = '"+ property.getOwnerDni() +"'" +
                ", Status = '" + property.getStatus() +"'" +
                ", Surface = " + property.getSurface() +
                " WHERE Address = '"+ property.getAddress() +"'" +
                " AND CityID = "+ property.getCityID();

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
