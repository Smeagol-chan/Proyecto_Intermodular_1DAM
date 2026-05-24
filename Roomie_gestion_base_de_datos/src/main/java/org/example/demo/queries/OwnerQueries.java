package org.example.demo.queries;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import org.example.demo.objects.users.Owner;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;

public class OwnerQueries
{
    public static ObservableList<Owner> selectAll(Connection connection)
    {
        ObservableList<Owner> ownersList = FXCollections.observableArrayList();

        String query = "SELECT o.Dni AS 'DniOfOwner', u.Name, u.Surnames, u.Birthday, u.PhoneNumber, u.Email, u.Password" +
                ", COUNT(CONCAT(p.Address, p.CityID)) AS 'NumberProperties'" +
                " FROM [OWNER] o" +
                " INNER JOIN [USER] u ON o.Dni = u.Dni" +
                " JOIN PROPERTY p ON o.Dni = p.OwnerDni" +
                " GROUP BY o.Dni, u.Name, u.Surnames, u.Birthday, u.PhoneNumber, u.Email, u.Password";

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
                int numProperties = result.getInt("NumberProperties");

                ownersList.add(new Owner(dni, name, surnames, birth, phone, email, password, numProperties));
            }
        }
        catch(SQLException e)
        {
            System.out.println(e.getMessage());
            throw new RuntimeException(e);
        }
        return ownersList;
    }

    public static void insert(Connection connection, Owner owner)
    {
        String query1 = "INSERT INTO [USER] (Dni, Name, Surnames, Birthday, PhoneNumber, Email, Password)" +
                " VALUES ('"+ owner.getDni() +"'" +
                ", '"+ owner.getUserName() +"'" +
                ", '"+ owner.getSurnames() +"'" +
                ", '"+ owner.getBirthdate() +"'" +
                ", '"+ owner.getPhoneNumber() +"'" +
                ", '"+ owner.getEmail() +"'" +
                ", '"+ owner.getPassword() +"')";

        String query2 = "INSERT INTO [OWNER] (Dni)" +
                " VALUES ('"+ owner.getDni() +"')";

        Statement stmt1;
        Statement stmt2;

        try
        {
            stmt1 = connection.createStatement();
            stmt1.executeUpdate(query1);

            stmt2 = connection.createStatement();
            stmt2.executeUpdate(query2);
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

    public static void update(Connection connection, Owner owner)
    {
        String query = "UPDATE [USER]" +
                " SET Name = '"+ owner.getUserName() +"'" +
                ", Surnames = '" + owner.getSurnames() +"'" +
                ", PhoneNumber = '" + owner.getPhoneNumber() +"'" +
                ", Email = '" + owner.getEmail() +"'" +
                " WHERE Dni = '" + owner.getDni() +"'";

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
