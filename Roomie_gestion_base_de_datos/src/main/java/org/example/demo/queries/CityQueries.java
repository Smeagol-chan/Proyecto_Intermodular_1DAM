package org.example.demo.queries;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import org.example.demo.objects.locations.City;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class CityQueries
{
    public static ObservableList<City> selectAll(Connection connection)
    {
        ObservableList<City> citiesList = FXCollections.observableArrayList();

        String query = "SELECT * FROM CITY";

        Statement stmt;
        ResultSet result;

        try
        {
            stmt = connection.createStatement();
            result = stmt.executeQuery(query);

            while(result.next())
            {
                Integer cityID = result.getInt("CityID");
                String cityName = result.getString("CityName");
                String provinceID = result.getString("ProvinceID");
                citiesList.add(new City(cityID, cityName, provinceID));
            }
        }
        catch(SQLException e)
        {
            System.out.println(e.getMessage());
            throw new RuntimeException(e);
        }
        return citiesList;
    }

    public static void insert(Connection connection, City city)
    {
        String query = "INSERT INTO CITY (CityName, ProvinceID)" +
                " VALUES ('"+ city.getCityName() +"', '"+ city.getProvinceId() +"')";

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

    public static void delete(Connection connection, Integer cityID)
    {
        String query = "DELETE FROM CITY" +
                " WHERE CityID = "+ cityID;

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

    public static void update(Connection connection, City city)
    {
        String query = "UPDATE CITY" +
                " SET CityName = '"+ city.getCityName() +"'" +
                ", ProvinceID = '" + city.getProvinceId() + "'" +
                " WHERE CityID = " + city.getCityId();

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

    public static int getLastCityIDInserted(Connection connection)
    {
        String query = "SELECT TOP 1 CityID FROM CITY ORDER BY CityID DESC";

        Statement stmt;
        ResultSet result;

        int cityID;

        try
        {
            stmt = connection.createStatement();
            result = stmt.executeQuery(query);

            result.next();

            cityID = result.getInt("CityID");
        }
        catch(SQLException e)
        {
            System.out.println(e.getMessage());
            throw new RuntimeException(e);
        }
        return cityID;
    }
}
