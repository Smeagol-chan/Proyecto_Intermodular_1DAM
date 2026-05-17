package org.example.demo.controllers;

import javafx.beans.property.SimpleIntegerProperty;
import javafx.beans.property.SimpleStringProperty;
import javafx.fxml.FXML;
import javafx.scene.control.*;
import org.example.demo.Database;
import org.example.demo.RoomieAplication;
import org.example.demo.objects.properties.Furniture;
import org.example.demo.queries.FurnitureQueries;

import java.io.IOException;
import java.sql.Connection;

public class FurnitureController
{
    private static Connection connection;

    private static boolean currentlyInserting = false;
    private static boolean currentlyUpdating = false;

    @FXML
    private TableView<Furniture> furnitureTableView;

    @FXML
    private TableColumn<Furniture, Integer> furnitureIdTableColumn;

    @FXML
    private TableColumn<Furniture, String> furnitureNameTableColumn;

    @FXML
    private TableColumn<Furniture, String> furnitureDescriptionTableColumn;

    @FXML
    private TextField furnitureNameTextField;

    @FXML
    private TextArea furnitureDescriptionTextArea;

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

        furnitureIdTableColumn.setCellValueFactory(dato -> new SimpleIntegerProperty(dato.getValue().getFurnitureId()).asObject());
        furnitureNameTableColumn.setCellValueFactory(dato -> new SimpleStringProperty(dato.getValue().getFurnitureName()));
        furnitureDescriptionTableColumn.setCellValueFactory(dato -> new SimpleStringProperty(dato.getValue().getDescription()));

        furnitureTableView.setItems(FurnitureQueries.selectAll(connection));
    }

    @FXML
    private void onModifyClickButton()
    {
        Furniture furniture = furnitureTableView.getSelectionModel().getSelectedItem();

        if(furniture == null)
        {
            warningMessageLabel.setText("No furniture was selected.");
            statusMessageLabel.setText("");
        }
        else
        {
            warningMessageLabel.setText("");
            statusMessageLabel.setText("");
            furnitureNameTextField.setText(furniture.getFurnitureName());
            furnitureDescriptionTextArea.setText(furniture.getDescription());

            activateDataFields(true);
            currentlyUpdating = true;
        }
    }

    @FXML
    private void onDeleteClickButton()
    {
        Furniture furniture = furnitureTableView.getSelectionModel().getSelectedItem();

        if(furniture == null)
        {
            warningMessageLabel.setText("No furniture was selected.");
            statusMessageLabel.setText("");
        }
        else
        {
            FurnitureQueries.delete(connection, furniture.getFurnitureId());

            warningMessageLabel.setText("");
            statusMessageLabel.setText("Furniture deleted.");
            furnitureTableView.setItems(FurnitureQueries.selectAll(connection));
        }
    }

    @FXML
    private void onInsertClickButton()
    {
        activateDataFields(true);
        statusMessageLabel.setText("");
        warningMessageLabel.setText("");
        currentlyInserting = true;
    }

    @FXML
    private void onConfirmClickButton()
    {
        String furnitureName = furnitureNameTextField.getText();
        String furnitureDescription = furnitureDescriptionTextArea.getText();

        if(furnitureName == null)
        {
            warningMessageLabel.setText("Furniture name can not be left empty.");
            statusMessageLabel.setText("");
        }
        else
        {
            warningMessageLabel.setText("");

            if(currentlyInserting)
            {
                FurnitureQueries.insert(connection, new Furniture(furnitureName, furnitureDescription));
                statusMessageLabel.setText("Furniture inserted.");
                currentlyInserting = false;
            }
            else if(currentlyUpdating)
            {
                Integer furnitureID = furnitureTableView.getSelectionModel().getSelectedItem().getFurnitureId();

                FurnitureQueries.update(connection, new Furniture(furnitureID, furnitureName, furnitureDescription));
                statusMessageLabel.setText("Furniture updated.");
                currentlyUpdating = false;
            }

            activateDataFields(false);
            furnitureTableView.setItems(FurnitureQueries.selectAll(connection));
        }
    }

    @FXML
    private void onCancelClickButton()
    {
        activateDataFields(false);
        reset();
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
        furnitureTableView.setDisable(isActive);

        furnitureNameTextField.setDisable(!isActive);
        furnitureDescriptionTextArea.setDisable(!isActive);
        cancelButton.setDisable(!isActive);
        confirmButton.setDisable(!isActive);
    }

    private void reset()
    {
        furnitureNameTextField.clear();
        furnitureDescriptionTextArea.clear();
        statusMessageLabel.setText("");
        warningMessageLabel.setText("");
        currentlyInserting = false;
        currentlyUpdating = false;
    }
}
