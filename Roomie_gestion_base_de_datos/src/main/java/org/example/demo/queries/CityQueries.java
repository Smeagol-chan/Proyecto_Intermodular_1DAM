package org.example.demo.queries;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import org.example.demo.objects.locations.City;

import java.sql.*;
import java.util.Arrays;
import java.util.Stack;

public class CityQueries
{
    public static Integer getCityIdByCityNameProvinceID(Connection connection, String city)
    {
        Stack<String> cityNameProvince = new Stack<>();

        cityNameProvince.addAll(Arrays.asList(city.split(", ")));

        String query = "SELECT CityID FROM CITY" +
                " WHERE ProvinceID = '"+ cityNameProvince.pop() +"'"+
                " AND CityName = '"+ cityNameProvince.pop() +"'";

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

    public static String getPorpertyCityName(Connection connection, int cityID)
    {
        String query = "SELECT CityName, ProvinceID FROM CITY WHERE CityID = "+ cityID;

        Statement stmt;
        ResultSet result;

        String city;

        try
        {
            stmt = connection.createStatement();
            result = stmt.executeQuery(query);

            result.next();

            String cityName = result.getString("CityName");
            String provinceID = result.getString("ProvinceID");
            city = cityName +", "+ provinceID;
        }
        catch(SQLException e)
        {
            System.out.println(e.getMessage());
            throw new RuntimeException(e);
        }
        return city;
    }

    public static ObservableList<String> selectCitiesNameProvince(Connection connection)
    {
        ObservableList<String> citiesNamesList = FXCollections.observableArrayList();

        String query = "SELECT c.CityName AS 'CityName', p.ProvinceName AS 'ProvinceName'" +
                " FROM CITY c" +
                " JOIN PROVINCE p ON c.ProvinceID = p.ProvinceID";

        Statement stmt;
        ResultSet result;

        try
        {
            stmt = connection.createStatement();
            result = stmt.executeQuery(query);

            while(result.next())
            {
                String cityName = result.getString("CityName");
                String provinceName = result.getString("ProvinceName");
                citiesNamesList.add(cityName +", "+ provinceName);
            }
        }
        catch(SQLException e)
        {
            System.out.println(e.getMessage());
            throw new RuntimeException(e);
        }
        return citiesNamesList;
    }

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
