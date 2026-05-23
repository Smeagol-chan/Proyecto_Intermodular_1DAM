package org.example.demo.queries;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import org.example.demo.objects.properties.Furniture;
import org.example.demo.objects.properties.Room;
import org.example.demo.objects.properties.RoomFurniture;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class RoomFurnitureQueries
{
    public static ObservableList<RoomFurniture> selectAll(Connection connection, Room room)
    {
        ObservableList<RoomFurniture> roomFurnitureList = FXCollections.observableArrayList();

        String query = "SELECT rf.FurnitureID AS 'ID on union', rf.Quantity, f.FurnitureName" +
                " FROM ROOM_FURNITURE rf" +
                " INNER JOIN FURNITURE f ON rf.FurnitureID = f.FurnitureID" +
                " WHERE RoomNumber = "+ room.getRoomNumber() +
                " AND PropertyAddress = '"+ room.getPropertyAddress() +"'" +
                " AND PropertyCityID = "+ room.getCityID();

        Statement stmt;
        ResultSet result;

        try
        {
            stmt = connection.createStatement();
            result = stmt.executeQuery(query);

            while(result.next())
            {
                int furnitureID = result.getInt("ID on union");
                int qty = result.getInt("Quantity");
                String furnitureName = result.getString("FurnitureName");
                roomFurnitureList.add(new RoomFurniture(furnitureID, room.getCityID(), room.getPropertyAddress(), room.getRoomNumber(), qty, furnitureName));
            }
        }
        catch(SQLException e)
        {
            System.out.println(e.getMessage());
            throw new RuntimeException(e);
        }
        return roomFurnitureList;
    }

    public static void insert(Connection connection, RoomFurniture roomFurniture)
    {
        String query = "INSERT INTO ROOM_FURNITURE (PropertyAddress, PropertyCityID, RoomNumber, FurnitureID, Quantity)" +
                " VALUES ('"+ roomFurniture.getPropertyAddress() +"'"+
                ", "+ roomFurniture.getCityID() +
                ", "+ roomFurniture.getRoomNumber() +
                ", "+ roomFurniture.getFurnitureId() +
                ", "+ roomFurniture.getQuantity() +")";

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

    public static void delete(Connection connection, RoomFurniture roomFurniture)
    {
        String query = "DELETE FROM ROOM_FURNITURE" +
                " WHERE PropertyAddress = '"+ roomFurniture.getPropertyAddress() +"'" +
                " AND PropertyCityID = "+ roomFurniture.getCityID() +
                " AND RoomNumber = "+ roomFurniture.getRoomNumber() +
                " AND FurnitureID = "+ roomFurniture.getFurnitureId();

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

    public static void update(Connection connection, RoomFurniture roomFurniture)
    {
        String query = "UPDATE ROOM_FURNITURE" +
                " SET Quantity = "+ roomFurniture.getQuantity() +
                " WHERE PropertyAddress = '"+ roomFurniture.getPropertyAddress() +"'" +
                " AND PropertyCityID = "+ roomFurniture.getCityID() +
                " AND RoomNumber = "+ roomFurniture.getRoomNumber() +
                " AND FurnitureID = "+ roomFurniture.getFurnitureId();

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
