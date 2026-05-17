package org.example.demo.queries;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import org.example.demo.objects.properties.Room;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class RoomQueries
{
    public static ObservableList<Room> selectAll(Connection connection)
    {
        ObservableList<Room> roomList = FXCollections.observableArrayList();

        String query = "SELECT * FROM ROOM";

        Statement stmt;
        ResultSet result;

        try
        {
            stmt = connection.createStatement();
            result = stmt.executeQuery(query);

            while(result.next())
            {
                int roomNumber = result.getInt("RoomNumber");
                String address = result.getString("Address");
                int cityID = result.getInt("CityID");
                String type = result.getString("Type");
                String status = result.getString("Status");
                double surface = result.getDouble("Surface");
                double pricePerMonth = result.getDouble("PricePerMonth");
                roomList.add(new Room(roomNumber, address, cityID, type, surface, status, pricePerMonth));
            }
        }
        catch(SQLException e)
        {
            System.out.println(e.getMessage());
            throw new RuntimeException(e);
        }
        return roomList;
    }

    public static void insert(Connection connection, Room room)
    {
        String query = "INSERT INTO ROOM (PropertyAddress, PropertyCityID, Type, Status, Surface, PricePerMonth)" +
                " VALUES ('"+ room.getPropertyAddress() +"'"+
                ", "+ room.getCityID() +
                ", '"+ room.getType() +"'"+
                ", '"+ room.getStatus() +"'"+
                ", "+ room.getSurface() +
                ", "+ room.getPricePerMonth();

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

    public static void delete(Connection connection, Room room)
    {
        String query = "DELETE FROM ROOM" +
                " WHERE PropertyAddress = '"+ room.getPropertyAddress() +"'" +
                " AND PropertyCityID = "+ room.getCityID() +
                " AND RoomNumber = "+ room.getRoomNumber();

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

    public static void update(Connection connection, Room room)
    {
        String query = "UPDATE ROOM" +
                " SET Type = '"+ room.getType() +"'" +
                ", Status = '" + room.getStatus() +"'" +
                ", Surface = " + room.getSurface() +
                ", PricePerMonth = "+ room.getPricePerMonth() +
                " WHERE Address = '"+ room.getPropertyAddress() +"'" +
                " AND PropertyCityID = "+ room.getCityID() +
                " AND RoomNumber = "+ room.getRoomNumber();

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
