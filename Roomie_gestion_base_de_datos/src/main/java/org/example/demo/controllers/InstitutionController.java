package org.example.demo.controllers;

import javafx.beans.property.SimpleDoubleProperty;
import javafx.beans.property.SimpleIntegerProperty;
import javafx.beans.property.SimpleStringProperty;
import javafx.fxml.FXML;
import javafx.scene.control.*;
import org.example.demo.Database;
import org.example.demo.RoomieAplication;
import org.example.demo.objects.locations.Institution;
import org.example.demo.queries.CityQueries;
import org.example.demo.queries.InstitutionQueries;

import java.io.IOException;
import java.sql.Connection;

public class InstitutionController
{
    private static Connection connection;

    private static boolean currentlyInserting = false;
    private static boolean currentlyUpdating = false;

    @FXML
    private TableView<Institution> institutionTableView;

    @FXML
    private TableColumn<Institution, Integer> institutionIdTableColumn;

    @FXML
    private TableColumn<Institution, String> institutionNameTableColumn;

    @FXML
    private TableColumn<Institution, Integer> cityIdTableColumn;

    @FXML
    private TextField institutionNameTextField;

    @FXML
    private ChoiceBox<String> cityChoiceBox;

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

        institutionIdTableColumn.setCellValueFactory(dato -> new SimpleIntegerProperty(dato.getValue().getInstitutionId()).asObject());
        cityIdTableColumn.setCellValueFactory(dato -> new SimpleIntegerProperty(dato.getValue().getCityId()).asObject());
        institutionNameTableColumn.setCellValueFactory(dato -> new SimpleStringProperty(dato.getValue().getInstitutionName()));

        cityChoiceBox.setItems(CityQueries.selectCitiesNameProvince(connection));

        institutionTableView.setItems(InstitutionQueries.selectAll(connection));
    }

    @FXML
    private void onModifyClickButton()
    {
        Institution institution = institutionTableView.getSelectionModel().getSelectedItem();

        if(institution == null)
        {
            warningMessageLabel.setText("No institution was selected.");
            statusMessageLabel.setText("");
        }
        else
        {
            warningMessageLabel.setText("");
            statusMessageLabel.setText("");

            institutionNameTextField.setText(institution.getInstitutionName());
            cityChoiceBox.setValue(CityQueries.getPorpertyCityName(connection, institution.getCityId()));

            activateDataFields(true);
            currentlyUpdating = true;
        }
    }

    @FXML
    private void onDeleteClickButton()
    {
        Institution institution = institutionTableView.getSelectionModel().getSelectedItem();

        if(institution == null)
        {
            warningMessageLabel.setText("No institution was selected.");
            statusMessageLabel.setText("");
        }
        else
        {
            InstitutionQueries.delete(connection, institution.getInstitutionId());

            warningMessageLabel.setText("");
            statusMessageLabel.setText("Institution deleted.");
            institutionTableView.setItems(InstitutionQueries.selectAll(connection));
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
        String institutionName = institutionNameTextField.getText();
        Integer cityID = CityQueries.getCityIdByCityNameProvinceID(connection, cityChoiceBox.getValue());

        if(institutionName == null || cityID == null)
        {
            warningMessageLabel.setText("Empty fields left.");
            statusMessageLabel.setText("");
        }
        else
        {
            warningMessageLabel.setText("");

            if(currentlyInserting)
            {
                InstitutionQueries.insert(connection, new Institution(institutionName, cityID));
                statusMessageLabel.setText("Institution inserted.");
                currentlyInserting = false;
            }
            else if(currentlyUpdating)
            {
                Integer institutionID = institutionTableView.getSelectionModel().getSelectedItem().getInstitutionId();

                InstitutionQueries.update(connection, new Institution(institutionID, institutionName, cityID));
                statusMessageLabel.setText("Institution updated.");
                currentlyUpdating = false;
            }

            activateDataFields(false);
            institutionTableView.setItems(InstitutionQueries.selectAll(connection));
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
        institutionTableView.setDisable(isActive);

        institutionNameTextField.setDisable(!isActive);
        cancelButton.setDisable(!isActive);
        confirmButton.setDisable(!isActive);

        cityChoiceBox.setDisable(!currentlyInserting);
    }

    private void reset()
    {
        cityChoiceBox.setValue(null);
        institutionNameTextField.clear();
        statusMessageLabel.setText("");
        warningMessageLabel.setText("");
        currentlyInserting = false;
        currentlyUpdating = false;
    }
}
