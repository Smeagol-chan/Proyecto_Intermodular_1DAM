package org.example.demo.queries;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import org.example.demo.objects.locations.Institution;
import org.example.demo.objects.locations.PropertyInstitution;
import org.example.demo.objects.properties.Property;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class PropertyInstituteQueries
{
    public static ObservableList<Property> selectPropertiesNearByInstitution(Connection connection, int institutionID)
    {
        ObservableList<Property> propertiesList = FXCollections.observableArrayList();

        String query = "SELECT *" +
                " FROM PROPERTY_INSTITUTION pi" +
                " INNER JOIN PROPERTY p ON pi.PropertyAddress = p.Address AND pi.PropertyCityID = p.CityID" +
                " WHERE pi.InstitutionID = "+ institutionID;

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
    public static ObservableList<String> getAllPropertyCitiesExceptAlreadyAdded(Connection connection, int institutionID)
    {
        ObservableList<String> propertiesList = FXCollections.observableArrayList();

        String query = "SELECT CityID" +
                " FROM PROPERTY" +
                " WHERE CONCAT(Address, CityID) NOT IN (" +
                "SELECT CONCAT(PropertyAddress, PropertyCityID)" +
                " FROM PROPERTY_INSTITUTION" +
                " WHERE InstitutionID = "+ institutionID +")";

        Statement stmt;
        ResultSet result;

        try
        {
            stmt = connection.createStatement();
            result = stmt.executeQuery(query);

            while(result.next())
            {
                propertiesList.add(CityQueries.getCityNameProvinceName(connection, result.getInt("CityID")));
            }
        }
        catch(SQLException e)
        {
            System.out.println(e.getMessage());
            throw new RuntimeException(e);
        }
        return propertiesList;
    }

    public static ObservableList<Institution> selectInstitutionsNearByProperty(Connection connection, Property property)
    {
        ObservableList<Institution> institutionsList = FXCollections.observableArrayList();

        String query = "SELECT i.InstitutionID AS 'InstitutionToget', i.InstitutionName, i.CityID" +
                " FROM PROPERTY_INSTITUTION pi" +
                " INNER JOIN INSTITUTION i ON pi.InstitutionID = i.InstitutionID" +
                " WHERE pi.PropertyAddress = '"+ property.getAddress() +"'" +
                " AND pi.PropertyCityID = "+ property.getCityID();

        Statement stmt;
        ResultSet result;

        try
        {
            stmt = connection.createStatement();
            result = stmt.executeQuery(query);

            while(result.next())
            {
                int institutionID = result.getInt("InstitutionToget");
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

    public static ObservableList<String> getAllInstitutionsExceptAlreadyAdded(Connection connection, Property property)
    {
        ObservableList<String> institutionsList = FXCollections.observableArrayList();

        String query = "SELECT *" +
                " FROM INSTITUTION" +
                " WHERE InstitutionID NOT IN (" +
                "SELECT InstitutionID" +
                " FROM PROPERTY_INSTITUTION" +
                " WHERE PropertyAddress = '"+ property.getAddress() +"'" +
                " AND PropertyCityID = "+ property.getCityID() +")";

        Statement stmt;
        ResultSet result;

        try
        {
            stmt = connection.createStatement();
            result = stmt.executeQuery(query);

            while(result.next())
            {
                String cityName = CityQueries.getCityNameProvinceName(connection, result.getInt("CityID"));
                String institutionName = result.getString("InstitutionName");
                institutionsList.add(institutionName +", "+ cityName);
            }
        }
        catch(SQLException e)
        {
            System.out.println(e.getMessage());
            throw new RuntimeException(e);
        }
        return institutionsList;
    }

    private static void insert(Connection connection, PropertyInstitution propertyInstitution)
    {
        String query = "INSERT INTO PROPERTY_INSTITUTION (InstitutionID, PropertyCityID, PropertyAddress)" +
                " VALUES ("+ propertyInstitution.getInstitutionID() +
                ", "+ propertyInstitution.getPropertyCityID() +
                ", '"+ propertyInstitution.getPropertyAddress() +"')";

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

    public static boolean tryInsertProperty(Connection connection, PropertyInstitution propertyInstitution)
    {
        String query = "SELECT *" +
                " FROM PROPERTY" +
                " WHERE Address = '"+ propertyInstitution.getPropertyAddress() +"'" +
                " AND CityID = "+ propertyInstitution.getPropertyCityID();

        Statement stmt;
        ResultSet result;

        try
        {
            stmt = connection.createStatement();
            result = stmt.executeQuery(query);
        }
        catch(SQLException e)
        {
            System.out.println(e.getMessage());
            throw new RuntimeException(e);
        }

        if(result == null) return false;
        else
        {
            insert(connection, propertyInstitution);
            return true;
        }
    }

    public static boolean tryInsertInstitution(Connection connection, PropertyInstitution propertyInstitution)
    {
        String query = "SELECT *" +
                " FROM INSTITUTION" +
                " WHERE InstitutionID = "+ propertyInstitution.getInstitutionID();

        Statement stmt;
        ResultSet result;

        try
        {
            stmt = connection.createStatement();
            result = stmt.executeQuery(query);
        }
        catch(SQLException e)
        {
            System.out.println(e.getMessage());
            throw new RuntimeException(e);
        }

        if(result == null) return false;
        else
        {
            insert(connection, propertyInstitution);
            return true;
        }
    }

    public static void delete(Connection connection, PropertyInstitution propertyInstitution)
    {
        String query = "DELETE FROM PROPERTY_INSTITUTION" +
                " WHERE PropertyAddress = '"+ propertyInstitution.getPropertyAddress() +"'" +
                " AND PropertyCityID = "+ propertyInstitution.getPropertyCityID() +
                " AND IntsitutionID = "+ propertyInstitution.getInstitutionID();

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
