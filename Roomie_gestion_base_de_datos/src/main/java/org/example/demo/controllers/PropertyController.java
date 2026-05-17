package org.example.demo.controllers;

import javafx.beans.property.SimpleDoubleProperty;
import javafx.beans.property.SimpleIntegerProperty;
import javafx.beans.property.SimpleStringProperty;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.scene.control.*;
import org.example.demo.Database;
import org.example.demo.RoomieAplication;
import org.example.demo.objects.properties.Property;
import org.example.demo.queries.CityQueries;
import org.example.demo.queries.PropertyQueries;

import java.io.IOException;
import java.sql.Connection;

public class PropertyController
{
    private static Connection connection;

    private static boolean currentlyInserting = false;
    private static boolean currentlyUpdating = false;

    private static final ObservableList<String> STATUS_LIST = FXCollections.observableArrayList("Denied", "Confirmed", "Pending");

    @FXML
    private TableView<Property> propertyTableView;

    @FXML
    private TableColumn<Property, String> addressTableColumn;

    @FXML
    private TableColumn<Property, Integer> cityIdTableColumn;

    @FXML
    private TableColumn<Property, String> ownerDniTableColumn;

    @FXML
    private TableColumn<Property, String> statusTableColumn;

    @FXML
    private TableColumn<Property, Double> surfaceTableColumn;

    @FXML
    private TextField addressTextField;

    @FXML
    private ChoiceBox<String> cityChoiceBox;

    @FXML
    private TextField ownerDniTextField;

    @FXML
    private ChoiceBox<String> statusChoiceBox;

    @FXML
    private TextField surfaceTextField;

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

        addressTableColumn.setCellValueFactory(dato -> new SimpleStringProperty(dato.getValue().getAddress()));
        cityIdTableColumn.setCellValueFactory(dato -> new SimpleIntegerProperty(dato.getValue().getCityID()).asObject());
        ownerDniTableColumn.setCellValueFactory(dato -> new SimpleStringProperty(dato.getValue().getOwnerDni()));
        statusTableColumn.setCellValueFactory(dato -> new SimpleStringProperty(dato.getValue().getStatus()));
        surfaceTableColumn.setCellValueFactory(dato -> new SimpleDoubleProperty(dato.getValue().getSurface()).asObject());

        statusChoiceBox.setItems(STATUS_LIST);
        cityChoiceBox.setItems(CityQueries.selectCitiesNameProvince(connection));

        propertyTableView.setItems(PropertyQueries.selectAll(connection));
    }

    @FXML
    private void onModifyClickButton()
    {
        Property property = propertyTableView.getSelectionModel().getSelectedItem();

        if(property == null)
        {
            warningMessageLabel.setText("No property was selected.");
            statusMessageLabel.setText("");
        }
        else
        {
            warningMessageLabel.setText("");
            statusMessageLabel.setText("");
            addressTextField.setText(property.getAddress());
            cityChoiceBox.setValue(CityQueries.getPorpertyCityName(connection, property.getCityID()));
            ownerDniTextField.setText(property.getOwnerDni());
            statusChoiceBox.setValue(property.getStatus());
            surfaceTextField.setText(String.valueOf(property.getSurface()));

            activateDataFields(true);
            currentlyUpdating = true;
        }
    }

    @FXML
    private void onDeleteClickButton()
    {
        Property property = propertyTableView.getSelectionModel().getSelectedItem();

        if(property == null)
        {
            warningMessageLabel.setText("No property was selected.");
            statusMessageLabel.setText("");
        }
        else
        {
            PropertyQueries.delete(connection, property);

            warningMessageLabel.setText("");
            statusMessageLabel.setText("Property deleted.");
            propertyTableView.setItems(PropertyQueries.selectAll(connection));
        }
    }

    @FXML
    private void onInsertClickButton()
    {
        currentlyInserting = true;
        activateDataFields(true);
        statusMessageLabel.setText("");
        warningMessageLabel.setText("");
    }

    @FXML
    private void onConfirmClickButton()
    {
        String address = addressTextField.getText();
        Integer cityID = CityQueries.getCityIdByCityNameProvinceID(connection, cityChoiceBox.getValue());
        String ownerDni = ownerDniTextField.getText();
        String status = statusChoiceBox.getValue();
        Double surface;
        try
        {
            surface = Double.parseDouble(surfaceTextField.getText());
        }
        catch (NumberFormatException e)
        {
            warningMessageLabel.setText("Surface field only admits numeric values.");
            System.out.println(e.getMessage());
            throw new RuntimeException(e);
        }

        if(address == null || cityID == null || ownerDni == null || surface == null)
        {
            warningMessageLabel.setText("Empty fields left.");
            statusMessageLabel.setText("");
        }
        else
        {
            warningMessageLabel.setText("");

            if(currentlyInserting)
            {
                PropertyQueries.insert(connection, new Property(address, cityID, ownerDni, status, surface));
                statusMessageLabel.setText("Property inserted.");
                currentlyInserting = false;
            }
            else if(currentlyUpdating)
            {
                PropertyQueries.update(connection, new Property(address, cityID, ownerDni, status, surface));
                statusMessageLabel.setText("Property updated.");
                currentlyUpdating = false;
            }

            activateDataFields(false);
            propertyTableView.setItems(PropertyQueries.selectAll(connection));
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
        propertyTableView.setDisable(isActive);

        ownerDniTextField.setDisable(!isActive);
        surfaceTextField.setDisable(!isActive);
        statusChoiceBox.setDisable(!isActive);
        cancelButton.setDisable(!isActive);
        confirmButton.setDisable(!isActive);

        cityChoiceBox.setDisable(!currentlyInserting);
        addressTextField.setDisable(!currentlyInserting);
    }

    private void reset()
    {
        addressTextField.clear();
        cityChoiceBox.setValue(null);
        ownerDniTextField.clear();
        statusChoiceBox.setValue(null);
        surfaceTextField.setText("");
        statusMessageLabel.setText("");
        warningMessageLabel.setText("");
        currentlyInserting = false;
        currentlyUpdating = false;
    }
}
