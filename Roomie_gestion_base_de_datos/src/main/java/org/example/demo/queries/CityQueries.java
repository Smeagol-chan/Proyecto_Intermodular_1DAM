package org.example.demo.queries;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import org.example.demo.objects.locations.City;

import java.sql.*;
import java.util.Arrays;
import java.util.Stack;

/**
 * Class that contains all requests to the database for the table CITY.
 *
 * As for the controllers, all queries classes have the same concept. All of them have the methods insert(), delete()
 * and update() but using the referencing table attibutes.
 *
 * Althought, some classes, as this is, have some extra methods. In summary, they are for obtain the id of the item via its name and viceversa.
 * There is a method to abtain all names in a string list to display it on the choice boxes.
 *
 * @author Eric
 */
public class CityQueries
{
    /**
     * Function to obtain a city id by its name and the name of the province it belongs.
     * The method recieves the concatenation: [city name] + ", " + [province name].
     * It splits its values by ", " and stores both names in a stack. Then, it retieves the values by using pop() in the query for obtaining the CityID.
     *
     * @param connection - The connection with the database ROOMIE.
     * @param cityString - The name of the city and the name of its province combined.
     * @return - The ID of the city founded.
     */
    public static Integer getCityIdByCityNameProvinceName(Connection connection, String cityString)
    {
        Stack<String> cityNameProvince = new Stack<>();

        cityNameProvince.addAll(Arrays.asList(cityString.split(", ")));

        String query = "SELECT CityID FROM CITY" +
                " WHERE ProvinceID = '"+ ProvinceQueries.obtainIDByName(connection, cityNameProvince.pop()) +"'"+
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

    /**
     * Function to obtain the name and the province name of a determidated city by its ID.
     * Both names are concatenate separated with ", " in a string.
     *
     * @param connection - The connection with the database ROOMIE.
     * @param cityID - int with the ID of the city.
     * @return - String with the city name and the province name.
     */
    public static String getCityNameProvinceName(Connection connection, int cityID)
    {
        String query = "SELECT c.CityName AS 'CityName', p.ProvinceName AS 'ProvinceName'" +
                " FROM CITY c" +
                " JOIN PROVINCE p ON c.ProvinceID = p.ProvinceID" +
                " WHERE c.CityID = "+ cityID;

        Statement stmt;
        ResultSet result;

        String city;

        try
        {
            stmt = connection.createStatement();
            result = stmt.executeQuery(query);

            result.next();

            String cityName = result.getString("CityName");
            String provinceID = result.getString("ProvinceName");
            city = cityName +", "+ provinceID;
        }
        catch(SQLException e)
        {
            System.out.println(e.getMessage());
            throw new RuntimeException(e);
        }
        return city;
    }

    /**
     * Function to obtain the full list of cities in the database and display them by their names instead of their IDs.
     *
     * @param connection - The connection with the database ROOMIE.
     * @return - ObservableList of strings containing all the city names with their corresponding province.
     */
    public static ObservableList<String> selectCitiesNameProvinceName(Connection connection)
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

    /**
     * Function to obtain all information in the table.
     *
     * @param connection - The connection with the database ROOMIE.
     * @return - ObvervableList of cities with all the data stored in CITY table.
     */
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

    /**
     * Procedure to insert a given city into CITY table.
     *
     * @param connection - The connection with the database ROOMIE.
     * @param city - City to insert.
     */
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

    /**
     * Procedure to delete a given city from CITY table.
     *
     * @param connection - The connection with the database ROOMIE.
     * @param cityID - Integer with the ID of the city to delete.
     */
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

    /**
     * Procedure to update a given city from CITY table.
     * Only those attibutes that don't form the PK are modified.
     *
     * @param connection - The connection with the database ROOMIE.
     * @param city - City to update.
     */
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

    /**
     * Function to obtain the ID of the last city inserted on the table.
     * It is used only once on the label informing about the successful operation.
     *
     * @param connection - The connection with the database ROOMIE.
     * @return - The ID of the last city inserted into CITY.
     */
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
