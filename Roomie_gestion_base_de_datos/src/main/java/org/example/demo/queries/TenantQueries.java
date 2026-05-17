package org.example.demo.queries;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import org.example.demo.objects.users.Tenant;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;

public class TenantQueries
{
    public static ObservableList<Tenant> selectAll(Connection connection)
    {
        ObservableList<Tenant> tenantsList = FXCollections.observableArrayList();

        String query = "SELECT t.Dni AS 'DniOfTenant', u.Name, u.Surnames, u.Birthday" +
                ", u.PhoneNumber, u.Email, u.Password, t.StudentLicense" +
                " FROM TENANT t" +
                " INNER JOIN [USER] u ON t.Dni = u.Dni";

        Statement stmt;
        ResultSet result;

        try
        {
            stmt = connection.createStatement();
            result = stmt.executeQuery(query);

            while(result.next())
            {
                String dni = result.getString("DniOfOwner");
                String name = result.getString("Name");
                String surnames = result.getString("Surnames");
                LocalDate birth = result.getDate("Birthday").toLocalDate();
                String phone = result.getString("PhoneNumber");
                String email = result.getString("Email");
                String password = result.getString("Password");
                String studentLicense = result.getString("StudentLicense");

                tenantsList.add(new Tenant(dni, name, surnames, birth, phone, email, password, studentLicense));
            }
        }
        catch(SQLException e)
        {
            System.out.println(e.getMessage());
            throw new RuntimeException(e);
        }
        return tenantsList;
    }

    public static void insert(Connection connection, Tenant tenant)
    {
        String query = "INSERT INTO [USER] (Dni, Name, Surnames, Birthday, PhoneNumber, Email, Password)" +
                " VALUES ('"+ tenant.getDni() +"'" +
                ", '"+ tenant.getUserName() +"'" +
                ", '"+ tenant.getSurnames() +"'" +
                ", '"+ tenant.getBirthdate() +"'" +
                ", '"+ tenant.getPhoneNumber() +"'" +
                ", '"+ tenant.getEmail() +"'" +
                ", '"+ tenant.getPassword() +"')";

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

        insertTenant(connection, tenant);
    }

    private static void insertTenant(Connection connection, Tenant tenant)
    {
        String query = "INSERT INTO TENANT (Dni, StudentLicense)" +
                " VALUES ('"+ tenant.getDni() +"', '"+ tenant.getStudentLicense() +"')";

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

    public static void delete(Connection connection, String dni)
    {
        String query = "DELETE FROM [USER]" +
                " WHERE Dni = '"+ dni +"'";

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

    public static void update(Connection connection, Tenant tenant)
    {
        String query = "UPDATE [USER]" +
                " SET Name = '"+ tenant.getUserName() +"'" +
                ", Surnames = '" + tenant.getSurnames() +"'" +
                ", PhoneNumber = '" + tenant.getPhoneNumber() +"'" +
                ", Email = '" + tenant.getEmail() +"'" +
                " WHERE Dni = '" + tenant.getDni() +"'";

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
        updateTenant(connection, tenant);
    }

    private static void updateTenant(Connection connection, Tenant tenant)
    {
        String query = "UPDATE TENANT" +
                " SET StudentLicense = '"+ tenant.getStudentLicense() +"'" +
                " WHERE Dni = '" + tenant.getDni() +"'";

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
