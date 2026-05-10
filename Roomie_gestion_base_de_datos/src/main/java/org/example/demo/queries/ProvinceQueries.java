package org.example.demo.queries;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import org.example.demo.objects.locations.Province;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class ProvinceQueries
{
    public static ObservableList<Province> selectAll(Connection connection)
    {
        ObservableList<Province> provincesList = FXCollections.observableArrayList();

        String query = "SELECT * FROM PROVINCE GO";

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
                "VALUES ('"+ province.getProvinceId() +"', '"+ province.getProvinceName() +"') " +
                "GO";

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
                "WHERE ProvinceID = '"+ provinceID +"'" +
                "GO";

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
