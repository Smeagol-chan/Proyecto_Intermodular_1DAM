package org.example.demo.controllers;

import javafx.beans.property.SimpleDoubleProperty;
import javafx.beans.property.SimpleIntegerProperty;
import javafx.beans.property.SimpleStringProperty;
import javafx.fxml.FXML;
import javafx.scene.control.*;
import org.example.demo.Database;
import org.example.demo.RoomieAplication;
import org.example.demo.objects.locations.Institution;
import org.example.demo.objects.locations.PropertyInstitution;
import org.example.demo.objects.properties.Property;
import org.example.demo.queries.CityQueries;
import org.example.demo.queries.PropertyInstituteQueries;

import java.io.IOException;
import java.sql.Connection;

public class PropertiesNearbyController
{
    private static Connection connection;

    public static Institution currentInstitution;

    @FXML
    private TableView<Property> propertiesTableView;

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
    private ChoiceBox<String> cityChoiceBox;

    @FXML
    private TextField addressTextField;

    @FXML
    private Label targetInstitutionIdLabel;

    @FXML
    private Label targetInstitutionNameLabel;

    @FXML
    private Label warningMessageLabel;

    @FXML
    private Label statusMessageLabel;

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

        cityChoiceBox.setItems(PropertyInstituteQueries.getAllPropertyCitiesExceptAlreadyAdded(connection, currentInstitution.getCityId()));

        propertiesTableView.setItems(PropertyInstituteQueries.selectPropertiesNearByInstitution(connection, currentInstitution.getCityId()));

        targetInstitutionIdLabel.setText(targetInstitutionIdLabel.getText() + currentInstitution.getInstitutionId());
        targetInstitutionNameLabel.setText(currentInstitution.getInstitutionName() +", "+ CityQueries.getCityNameProvinceName(connection, currentInstitution.getCityId()));
    }

    @FXML
    private void onDeleteClickButton()
    {
        Property property = propertiesTableView.getSelectionModel().getSelectedItem();

        if(property == null)
        {
            warningMessageLabel.setText("No property was selected.");
            statusMessageLabel.setText("");
        }
        else
        {
            PropertyInstituteQueries.delete(connection, new PropertyInstitution(currentInstitution.getInstitutionId(), property.getAddress(), property.getCityID()));

            warningMessageLabel.setText("");
            statusMessageLabel.setText("Property deleted.");
            propertiesTableView.setItems(PropertyInstituteQueries.selectPropertiesNearByInstitution(connection, currentInstitution.getCityId()));
        }
    }

    @FXML
    private void onInsertClickButton()
    {
        activateDataFields(true);
        statusMessageLabel.setText("");
        warningMessageLabel.setText("");
    }

    @FXML
    private void onConfirmClickButton()
    {
        String address = addressTextField.getText();
        Integer cityID = CityQueries.getCityIdByCityNameProvinceName(connection, cityChoiceBox.getValue());

        if(address == null || cityID == null)
        {
            warningMessageLabel.setText("Empty fields left.");
            statusMessageLabel.setText("");
        }
        else
        {
            warningMessageLabel.setText("");

            if(PropertyInstituteQueries.tryInsertProperty(connection, new PropertyInstitution(currentInstitution.getInstitutionId(), address, cityID)))
            {
                statusMessageLabel.setText("Property inserted.");

                activateDataFields(false);
                propertiesTableView.setItems(PropertyInstituteQueries.selectPropertiesNearByInstitution(connection, currentInstitution.getInstitutionId()));
            }
            else warningMessageLabel.setText("The property does not exist.");
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
        currentInstitution = null;
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
        deleteButton.setDisable(isActive);
        insertButton.setDisable(isActive);
        propertiesTableView.setDisable(isActive);

        cityChoiceBox.setDisable(!isActive);
        addressTextField.setDisable(!isActive);
        cancelButton.setDisable(!isActive);
        confirmButton.setDisable(!isActive);
    }

    private void reset()
    {
        addressTextField.clear();
        cityChoiceBox.setValue(null);
        statusMessageLabel.setText("");
        warningMessageLabel.setText("");
    }
}
