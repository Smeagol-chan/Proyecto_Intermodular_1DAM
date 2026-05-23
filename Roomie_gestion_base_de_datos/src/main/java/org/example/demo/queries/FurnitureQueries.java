package org.example.demo.queries;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import org.example.demo.objects.properties.Furniture;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Arrays;
import java.util.Stack;

public class FurnitureQueries
{
    public static Integer getFurnitureIdByFurnitureName(Connection connection, String furnitureName)
    {
        String query = "SELECT FurnitureID FROM FURNITURE" +
                " WHERE FurnitureName = '"+ furnitureName +"'";

        Statement stmt;
        ResultSet result;

        int furnitureID;

        try
        {
            stmt = connection.createStatement();
            result = stmt.executeQuery(query);

            result.next();

            furnitureID = result.getInt("FurnitureID");
        }
        catch(SQLException e)
        {
            System.out.println(e.getMessage());
            throw new RuntimeException(e);
        }
        return furnitureID;
    }

    public static ObservableList<String> selectFurnitureNames(Connection connection)
    {
        ObservableList<String> furnitureNameList = FXCollections.observableArrayList();

        String query = "SELECT FurnitureName FROM FURNITURE";

        Statement stmt;
        ResultSet result;

        try
        {
            stmt = connection.createStatement();
            result = stmt.executeQuery(query);

            while(result.next())
            {
                furnitureNameList.add(result.getString("FurnitureName"));
            }
        }
        catch(SQLException e)
        {
            System.out.println(e.getMessage());
            throw new RuntimeException(e);
        }
        return furnitureNameList;
    }

    public static ObservableList<Furniture> selectAll(Connection connection)
    {
        ObservableList<Furniture> furnitureList = FXCollections.observableArrayList();

        String query = "SELECT * FROM FURNITURE";

        Statement stmt;
        ResultSet result;

        try
        {
            stmt = connection.createStatement();
            result = stmt.executeQuery(query);

            while(result.next())
            {
                int furnitureID = result.getInt("FurnitureID");
                String furnitureName = result.getString("FurnitureName");
                String description = result.getString("FurnitureDescription");
                furnitureList.add(new Furniture(furnitureID, furnitureName, description));
            }

        }
        catch(SQLException e)
        {
            System.out.println(e.getMessage());
            throw new RuntimeException(e);
        }
        return furnitureList;
    }

    public static void insert(Connection connection, Furniture furniture)
    {
        String query = "INSERT INTO FURNITURE (FurnitureName, FurnitureDescription)" +
                " VALUES ('"+ furniture.getFurnitureName() +"', '"+ furniture.getDescription() +"')";

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

    public static void delete(Connection connection, int furnitureID)
    {
        String query = "DELETE FROM FURNITURE" +
                " WHERE FurnitureID = "+ furnitureID;

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

    public static void update(Connection connection, Furniture furniture)
    {
        String query = "UPDATE FURNITURE" +
                " SET FurnitureName = '"+ furniture.getFurnitureName() +"'" +
                ", FurnitureDescription = '" + furniture.getDescription() +"'" +
                " WHERE FurnitureID = " + furniture.getFurnitureId();

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
