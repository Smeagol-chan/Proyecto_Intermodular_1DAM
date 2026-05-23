package org.example.demo.controllers;

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
import org.example.demo.queries.InstitutionQueries;
import org.example.demo.queries.PropertyInstituteQueries;

import java.io.IOException;
import java.sql.Connection;

public class InstitutionsNearbyController
{
    private static Connection connection;

    public static Property currentProperty;

    @FXML
    private TableView<Institution> institutionsTableView;

    @FXML
    private TableColumn<Institution, Integer> institutionIdTableColumn;

    @FXML
    private TableColumn<Institution, Integer> cityIdTableColumn;

    @FXML
    private TableColumn<Institution, String> institutionNameTableColumn;

    @FXML
    private ChoiceBox<String> institutionChoiceBox;

    @FXML
    private Label targetPropertyLabel;

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

        institutionIdTableColumn.setCellValueFactory(dato -> new SimpleIntegerProperty(dato.getValue().getInstitutionId()).asObject());
        cityIdTableColumn.setCellValueFactory(dato -> new SimpleIntegerProperty(dato.getValue().getCityId()).asObject());
        institutionNameTableColumn.setCellValueFactory(dato -> new SimpleStringProperty(dato.getValue().getInstitutionName()));

        institutionChoiceBox.setItems(PropertyInstituteQueries.getAllInstitutionsExceptAlreadyAdded(connection, currentProperty));

        institutionsTableView.setItems(PropertyInstituteQueries.selectInstitutionsNearByProperty(connection, currentProperty));

        targetPropertyLabel.setText(currentProperty.getAddress() +", "+ CityQueries.getCityNameProvinceName(connection, currentProperty.getCityID()));
    }

    @FXML
    private void onDeleteClickButton()
    {
        Institution institution = institutionsTableView.getSelectionModel().getSelectedItem();

        if(institution == null)
        {
            warningMessageLabel.setText("No institution was selected.");
            statusMessageLabel.setText("");
        }
        else
        {
            PropertyInstituteQueries.delete(connection, new PropertyInstitution(institution.getInstitutionId(), currentProperty.getAddress(), currentProperty.getCityID()));

            warningMessageLabel.setText("");
            statusMessageLabel.setText("Institution deleted.");
            institutionsTableView.setItems(PropertyInstituteQueries.selectInstitutionsNearByProperty(connection, currentProperty));
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
        Integer institutionID = InstitutionQueries.getIdbyNameCity(connection, institutionChoiceBox.getValue());

        if(institutionID == null)
        {
            warningMessageLabel.setText("Empty fields left.");
            statusMessageLabel.setText("");
        }
        else
        {
            warningMessageLabel.setText("");

            if(PropertyInstituteQueries.tryInsertInstitution(connection, new PropertyInstitution(institutionID, currentProperty.getAddress(), currentProperty.getCityID())))
            {
                statusMessageLabel.setText("Institution inserted.");

                activateDataFields(false);
                institutionsTableView.setItems(PropertyInstituteQueries.selectInstitutionsNearByProperty(connection, currentProperty));
            }
            else warningMessageLabel.setText("The institution does not exist.");
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
        currentProperty = null;
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
        deleteButton.setDisable(isActive);
        insertButton.setDisable(isActive);
        institutionsTableView.setDisable(isActive);

        institutionChoiceBox.setDisable(!isActive);
        cancelButton.setDisable(!isActive);
        confirmButton.setDisable(!isActive);
    }

    private void reset()
    {
        institutionChoiceBox.setValue(null);
        statusMessageLabel.setText("");
        warningMessageLabel.setText("");
    }
}
