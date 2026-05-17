package org.example.demo.queries;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import org.example.demo.objects.paperwork.Contract;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;

public class ContractQueries
{
    public static ObservableList<Contract> selectAll(Connection connection)
    {
        ObservableList<Contract> contractsList = FXCollections.observableArrayList();

        String query = "SELECT * FROM [CONTRACT]";

        Statement stmt;
        ResultSet result;

        try
        {
            stmt = connection.createStatement();
            result = stmt.executeQuery(query);

            while(result.next())
            {
                int contractID = result.getInt("ContractID");
                int roomNumber = result.getInt("RoomNumber");
                int cityID = result.getInt("PropertyCityID");
                LocalDate signatureDate = result.getDate("SignatureDate").toLocalDate();
                LocalDate startingDate = result.getDate("StartingDate").toLocalDate();
                LocalDate endingDate = result.getDate("EndingDate").toLocalDate();
                double pricePerMonth = result.getDouble("PricePerMonth");
                String tenantDni = result.getString("TenantDni");
                String address = result.getString("PropertyAddress");
                String status = result.getString("Status");

                contractsList.add(new Contract(contractID, signatureDate, tenantDni, roomNumber
                        , address, cityID, pricePerMonth, startingDate, endingDate, status));
            }

        }
        catch(SQLException e)
        {
            System.out.println(e.getMessage());
            throw new RuntimeException(e);
        }
        return contractsList;
    }

    public static void insert(Connection connection, Contract contract)
    {
        String query = "INSERT INTO [CONTRACT] (SignatureDate, TenantDni, RoomNumber, PropertyAddress, PropertyCityID," +
                " PricePerMonth, StartingDate, EndingDate, Status)" +
                " VALUES ('"+ contract.getSignatureDate() +"'"+
                ", '"+ contract.getTenantDni() +"'"+
                ", "+ contract.getRoomNumber() +
                ", '"+ contract.getPropertyAddress() +"'"+
                ", "+ contract.getPropertyCityId() +
                ", "+ contract.getPricePerMonth() +
                ", '"+ contract.getStartingDate() +"'"+
                ", '"+ contract.getEndingDate() +"'"+
                ", '"+ contract.getStatus() +"')";

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

    public static void delete(Connection connection, int contractID)
    {
        String query = "DELETE FROM [CONTRACT]" +
                " WHERE ContractID = "+ contractID;

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

    public static void update(Connection connection, Contract contract)
    {
        String query = "UPDATE [CONTRACT]" +
                " SET ContractStatus = '"+ contract.getStatus() +"'" +
                " WHERE ContractID = " + contract.getContractID();

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
