package org.example.demo.controllers;

import javafx.beans.property.ReadOnlyObjectWrapper;
import javafx.beans.property.SimpleDoubleProperty;
import javafx.beans.property.SimpleIntegerProperty;
import javafx.beans.property.SimpleStringProperty;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.scene.control.*;
import org.example.demo.Database;
import org.example.demo.RoomieAplication;
import org.example.demo.objects.paperwork.Contract;
import org.example.demo.queries.CityQueries;
import org.example.demo.queries.ContractQueries;

import java.io.IOException;
import java.sql.Connection;
import java.time.LocalDate;

public class ContractController
{
    private static Connection connection;

    private static final ObservableList<String> STATUS_LIST = FXCollections.observableArrayList("Ongoing", "Ended");

    private static boolean currentlyInserting = false;
    private static boolean currentlyUpdating = false;

    @FXML
    private TableView<Contract> contractTableView;

    @FXML
    private TableColumn<Contract, Integer> contractIdTableColumn;

    @FXML
    private TableColumn<Contract, LocalDate> signatureDateTableColumn;

    @FXML
    private TableColumn<Contract, String> tenantDniTableColumn;

    @FXML
    private TableColumn<Contract, Integer> roomNumberTableColumn;

    @FXML
    private TableColumn<Contract, String> propertyAddressTableColumn;

    @FXML
    private TableColumn<Contract, Integer> propertyCiyIdTableColumn;

    @FXML
    private TableColumn<Contract, Double> pricePerMonthTableColumn;

    @FXML
    private TableColumn<Contract, LocalDate> startingDateTableColumn;

    @FXML
    private TableColumn<Contract, LocalDate> endingDateTableColumn;

    @FXML
    private TableColumn<Contract, String> statusTableColumn;

    @FXML
    private DatePicker signatureDateDatePicker;

    @FXML
    private DatePicker startingDateDatePicker;

    @FXML
    private DatePicker endingDateDatePicker;

    @FXML
    private TextField tenantDniTextField;

    @FXML
    private TextField roomNumberTextField;

    @FXML
    private TextField addressTextField;

    @FXML
    private TextField pricePerMonthTextField;

    @FXML
    private ChoiceBox<String> cityChoiceBox;

    @FXML
    private ChoiceBox<String> statusChoiceBox;

    @FXML
    private Label warningMessageLabel;

    @FXML
    private Label statusMessageLabel;

    @FXML
    private Button modifyButton;

    @FXML
    private Button deleteButton;

    @FXML
    private Button insertButton;

    @FXML
    private Button cancelButton;

    @FXML
    private Button confirmButton;

    @FXML
    private void initialize()
    {
        connection = Database.conexion();

        contractIdTableColumn.setCellValueFactory(dato -> new SimpleIntegerProperty(dato.getValue().getContractID()).asObject());
        roomNumberTableColumn.setCellValueFactory(dato -> new SimpleIntegerProperty(dato.getValue().getRoomNumber()).asObject());
        propertyCiyIdTableColumn.setCellValueFactory(dato -> new SimpleIntegerProperty(dato.getValue().getPropertyCityId()).asObject());

        pricePerMonthTableColumn.setCellValueFactory(dato -> new SimpleDoubleProperty(dato.getValue().getPricePerMonth()).asObject());

        tenantDniTableColumn.setCellValueFactory(dato -> new SimpleStringProperty(dato.getValue().getTenantDni()));
        propertyAddressTableColumn.setCellValueFactory(dato -> new SimpleStringProperty(dato.getValue().getPropertyAddress()));
        statusTableColumn.setCellValueFactory(dato -> new SimpleStringProperty(dato.getValue().getStatus()));

        signatureDateTableColumn.setCellValueFactory(dato -> new ReadOnlyObjectWrapper<>(dato.getValue().getSignatureDate()));
        startingDateTableColumn.setCellValueFactory(dato -> new ReadOnlyObjectWrapper<>(dato.getValue().getStartingDate()));
        endingDateTableColumn.setCellValueFactory(dato -> new ReadOnlyObjectWrapper<>(dato.getValue().getEndingDate()));

        contractTableView.setItems(ContractQueries.selectAll(connection));

        statusChoiceBox.setItems(STATUS_LIST);
        cityChoiceBox.setItems(CityQueries.selectCitiesNameProvinceName(connection));
    }

    @FXML
    private void onModifyClickButton()
    {
        Contract contract = contractTableView.getSelectionModel().getSelectedItem();

        if(contract == null)
        {
            warningMessageLabel.setText("No contract was selected.");
            statusMessageLabel.setText("");
        }
    else
        {
            warningMessageLabel.setText("");
            statusMessageLabel.setText("");

            signatureDateDatePicker.setValue(contract.getSignatureDate());
            tenantDniTextField.setText(contract.getTenantDni());
            addressTextField.setText(contract.getPropertyAddress());
            cityChoiceBox.setValue(CityQueries.getCityNameProvinceName(connection, contract.getPropertyCityId()));
            roomNumberTextField.setText(String.valueOf(contract.getRoomNumber()));
            startingDateDatePicker.setValue(contract.getStartingDate());
            endingDateDatePicker.setValue(contract.getEndingDate());
            pricePerMonthTextField.setText(String.valueOf(contract.getPricePerMonth()));
            statusChoiceBox.setValue(contract.getStatus());

            activateDataFields(true);
            currentlyUpdating = true;
        }
    }

    @FXML
    private void onDeleteClickButton()
    {
        Contract contract = contractTableView.getSelectionModel().getSelectedItem();

        if(contract == null)
        {
            warningMessageLabel.setText("No contract was selected.");
            statusMessageLabel.setText("");
        }
    else
        {
            ContractQueries.delete(connection, contract.getContractID());

            warningMessageLabel.setText("");
            statusMessageLabel.setText("Contract deleted.");
            contractTableView.setItems(ContractQueries.selectAll(connection));
        }
    }

    @FXML
    private void onInsertClickButton()
    {
        statusMessageLabel.setText("");
        warningMessageLabel.setText("");
        currentlyInserting = true;
        activateDataFields(true);
    }

    @FXML
    private void onConfirmClickButton()
    {
        LocalDate signatureDate = signatureDateDatePicker.getValue();
        String tenantDni = tenantDniTextField.getText();
        String address = addressTextField.getText();
        Integer cityID = CityQueries.getCityIdByCityNameProvinceName(connection, cityChoiceBox.getValue());
        Integer roomNumber;
        LocalDate startingDate = startingDateDatePicker.getValue();
        LocalDate endingDate = endingDateDatePicker.getValue();
        Double pricePerMonth;
        String status = statusChoiceBox.getValue();

        try
        {
            roomNumber = Integer.parseInt(roomNumberTextField.getText());
            pricePerMonth = Double.parseDouble(pricePerMonthTextField.getText());
        }
        catch (NumberFormatException e)
        {
            warningMessageLabel.setText("Room number and Price per Month fields only admit numeric values.");
            System.out.println(e.getMessage());
            throw  new RuntimeException(e);
        }

        if(signatureDate == null || address == null || cityID == null || roomNumber == null
                || startingDate == null || endingDate == null || pricePerMonth == null)
        {
            warningMessageLabel.setText("Empty fields left.");
            statusMessageLabel.setText("");
        }
        else
        {
            warningMessageLabel.setText("");

            if(currentlyInserting)
            {
                ContractQueries.insert(connection, new Contract(signatureDate, tenantDni, roomNumber
                        , address, cityID, pricePerMonth, startingDate, endingDate, status));
                statusMessageLabel.setText("Contract inserted.");
                currentlyInserting = false;
            }
            else if(currentlyUpdating)
            {
                Integer contractID = contractTableView.getSelectionModel().getSelectedItem().getContractID();

                ContractQueries.update(connection, new Contract(contractID, signatureDate, tenantDni, roomNumber
                        , address, cityID, pricePerMonth, startingDate, endingDate, status));
                statusMessageLabel.setText("Contract updated.");
                currentlyUpdating = false;
            }

            activateDataFields(false);
            contractTableView.setItems(ContractQueries.selectAll(connection));
        }
    }

    @FXML
    private void onCancelClickButton()
    {
        reset();
        activateDataFields(false);
    }

    @FXML
    private void onPropertiesClickMenuItem() throws IOException
    {
        RoomieAplication.setRoot("properties");
    }

    @FXML
    private void onRoomsClickMenuItem() throws IOException
    {
        RoomieAplication.setRoot("room");
    }

    @FXML
    private void onFurnitureClickMenuItem() throws IOException
    {
        RoomieAplication.setRoot("furniture");
    }

    @FXML
    private void onOwnerClickMenuItem() throws IOException
    {
        RoomieAplication.setRoot("owner");
    }

    @FXML
    private void onTenantClickMenuItem() throws IOException
    {
        RoomieAplication.setRoot("tenant");
    }

    @FXML
    private void onProvincesClickMenuItem() throws IOException
    {
        RoomieAplication.setRoot("provinces");
    }

    @FXML
    private void onCitiesClickMenuItem() throws IOException
    {
        RoomieAplication.setRoot("cities");
    }

    @FXML
    private void onInstitutionsClickMenuItem() throws IOException
    {
        RoomieAplication.setRoot("institutions");
    }

    @FXML
    private void onContractsClickMenuItem() throws IOException
    {
        RoomieAplication.setRoot("contracts");
    }

    @FXML
    private void onReportsClickMenuItem() throws IOException
    {
        RoomieAplication.setRoot("reports");
    }

    @FXML
    private void onLogoutClickButton() throws IOException
    {
        RoomieAplication.setRoot("login");
    }

    private void activateDataFields(boolean isActive)
    {
        modifyButton.setDisable(isActive);
        deleteButton.setDisable(isActive);
        insertButton.setDisable(isActive);
        contractTableView.setDisable(isActive);

        statusChoiceBox.setDisable(!isActive);
        cancelButton.setDisable(!isActive);
        confirmButton.setDisable(!isActive);

        signatureDateDatePicker.setDisable(!currentlyInserting);
        tenantDniTextField.setDisable(!currentlyInserting);
        addressTextField.setDisable(!currentlyInserting);
        cityChoiceBox.setDisable(!currentlyInserting);
        roomNumberTextField.setDisable(!currentlyInserting);
        startingDateDatePicker.setDisable(!currentlyInserting);
        endingDateDatePicker.setDisable(!currentlyInserting);
        pricePerMonthTextField.setDisable(!currentlyInserting);
    }

    private void reset()
    {
        signatureDateDatePicker.setValue(null);
        tenantDniTextField.clear();
        addressTextField.clear();
        cityChoiceBox.setValue(null);
        roomNumberTextField.clear();
        startingDateDatePicker.setValue(null);
        endingDateDatePicker.setValue(null);
        pricePerMonthTextField.clear();
        statusChoiceBox.setValue(null);

        statusMessageLabel.setText("");
        warningMessageLabel.setText("");
        currentlyInserting = false;
        currentlyUpdating = false;
    }
}
