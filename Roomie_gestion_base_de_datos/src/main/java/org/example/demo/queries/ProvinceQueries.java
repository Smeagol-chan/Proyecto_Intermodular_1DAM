package org.example.demo.queries;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import org.example.demo.objects.locations.City;
import org.example.demo.objects.locations.Province;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class ProvinceQueries
{
    public static String obtainIDByName(Connection connection, String provinceName)
    {
        String query = "SELECT ProvinceID FROM PROVINCE WHERE ProvinceName = '" + provinceName + "'";

        Statement stmt;
        ResultSet result;

        String provinceID;

        try
        {
            stmt = connection.createStatement();
            result = stmt.executeQuery(query);

            result.next();

            provinceID = result.getString("ProvinceID");
        }
        catch (SQLException e)
        {
            System.out.println(e.getMessage());
            throw new RuntimeException(e);
        }
        return provinceID;
    }

    public static String obtainNameByID(Connection connection, String provinceID)
    {
        String query = "SELECT ProvinceName FROM PROVINCE WHERE ProvinceID = '" + provinceID + "'";

        Statement stmt;
        ResultSet result;

        String provinceName;

        try
        {
            stmt = connection.createStatement();
            result = stmt.executeQuery(query);

            result.next();

            provinceName = result.getString("ProvinceName");
        }
        catch (SQLException e)
        {
            System.out.println(e.getMessage());
            throw new RuntimeException(e);
        }
        return provinceName;
    }

    public static ObservableList<String> selectAllNames(Connection connection)
    {
        ObservableList<String> provinceNameList = FXCollections.observableArrayList();

        String query = "SELECT DISTINCT ProvinceName FROM PROVINCE";

        Statement stmt;
        ResultSet result;

        try
        {
            stmt = connection.createStatement();
            result = stmt.executeQuery(query);

            while(result.next())
            {
                String provinceName = result.getString("ProvinceName");
                provinceNameList.add(provinceName);
            }

        }
        catch(SQLException e)
        {
            System.out.println(e.getMessage());
            throw new RuntimeException(e);
        }
        return provinceNameList;
    }

    public static ObservableList<Province> selectAll(Connection connection)
    {
        ObservableList<Province> provincesList = FXCollections.observableArrayList();

        String query = "SELECT * FROM PROVINCE";

        Statement stmt;
        ResultSet result;

        try
        {
            stmt = connection.createStatement();
            result = stmt.executeQuery(query);

            while(result.next())
            {
                String provinceID = result.getString("ProvinceID");
                String provinceName = result.getString("ProvinceName");
                provincesList.add(new Province(provinceID, provinceName));
            }

        }
        catch(SQLException e)
        {
            System.out.println(e.getMessage());
            throw new RuntimeException(e);
        }
        return provincesList;
    }

    public static void insert(Connection connection, Province province)
    {
        String query = "INSERT INTO PROVINCE (ProvinceID, ProvinceName)" +
                " VALUES ('"+ province.getProvinceId() +"', '"+ province.getProvinceName() +"')";

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

    public static void delete(Connection connection, String provinceID)
    {
        String query = "DELETE FROM PROVINCE" +
                " WHERE ProvinceID = '"+ provinceID +"'";

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

    public static void update(Connection connection, Province province)
    {
        String query = "UPDATE PROVINCE" +
                " SET ProvinceName = '"+ province.getProvinceName() +"'" +
                " WHERE ProvinceID = '" + province.getProvinceId() +"'";

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
