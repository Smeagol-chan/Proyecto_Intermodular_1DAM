package org.example.demo.controllers;

import javafx.beans.property.SimpleIntegerProperty;
import javafx.beans.property.SimpleStringProperty;
import javafx.fxml.FXML;
import javafx.scene.control.*;
import org.example.demo.Database;
import org.example.demo.RoomieAplication;
import org.example.demo.objects.properties.Room;
import org.example.demo.objects.properties.RoomFurniture;
import org.example.demo.queries.CityQueries;
import org.example.demo.queries.FurnitureQueries;
import org.example.demo.queries.RoomFurnitureQueries;

import java.io.IOException;
import java.sql.Connection;

public class RoomFurnitureController
{
    private static Connection connection;

    public static Room currentRoom;

    private static boolean currentlyInserting = false;
    private static boolean currentlyUpdating = false;

    @FXML
    private TableView<RoomFurniture> roomFurnitureTableView;

    @FXML
    private TableColumn<RoomFurniture, String> furnitureNameTableColumn;

    @FXML
    private TableColumn<RoomFurniture, Integer> furnitureIdTableColumn;

    @FXML
    private TableColumn<RoomFurniture, Integer> qtyTableColumn;

    @FXML
    private TextField qtyTextField;

    @FXML
    private ChoiceBox<String> furnitureChoiceBox;

    @FXML
    private Label currentRoomLabel;

    @FXML
    private Label currentPropertyLabel;

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
        qtyTableColumn.setCellValueFactory(dato -> new SimpleIntegerProperty(dato.getValue().getQuantity()).asObject());

        furnitureChoiceBox.setItems(FurnitureQueries.selectFurnitureNames(connection));

        roomFurnitureTableView.setItems(RoomFurnitureQueries.selectAll(connection, currentRoom));

        currentRoomLabel.setText(currentRoomLabel.getText() + currentRoom.getRoomNumber());
        currentPropertyLabel.setText(currentRoom.getPropertyAddress() +", "+ CityQueries.getPorpertyCityName(connection, currentRoom.getCityID()));
    }

    @FXML
    private void onModifyClickButton()
    {
        RoomFurniture roomFurniture = roomFurnitureTableView.getSelectionModel().getSelectedItem();

        if(roomFurniture == null)
        {
            warningMessageLabel.setText("No item was selected.");
            statusMessageLabel.setText("");
        }
        else
        {
            warningMessageLabel.setText("");
            statusMessageLabel.setText("");

            furnitureChoiceBox.setValue(roomFurniture.getFurnitureName());
            qtyTextField.setText(String.valueOf(roomFurniture.getQuantity()));

            activateDataFields(true);
            currentlyUpdating = true;
        }
    }

    @FXML
    private void onDeleteClickButton()
    {
        RoomFurniture roomFurniture = roomFurnitureTableView.getSelectionModel().getSelectedItem();

        if(roomFurniture == null)
        {
            warningMessageLabel.setText("No item was selected.");
            statusMessageLabel.setText("");
        }
        else
        {
            RoomFurnitureQueries.delete(connection, roomFurniture);

            warningMessageLabel.setText("");
            statusMessageLabel.setText("Item deleted.");
            roomFurnitureTableView.setItems(RoomFurnitureQueries.selectAll(connection, currentRoom));
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
        Integer furnitureID = FurnitureQueries.getFurnitureIdByFurnitureName(connection, furnitureChoiceBox.getValue());
        Integer qty;
        try
        {
            qty = Integer.parseInt(qtyTextField.getText());
        }
        catch (NumberFormatException e)
        {
            warningMessageLabel.setText("Quantity field only admits numeric values.");
            System.out.println(e.getMessage());
            throw new RuntimeException(e);
        }

        if(qty == null || furnitureID == null)
        {
            warningMessageLabel.setText("Empty fields left.");
            statusMessageLabel.setText("");
        }
        else
        {
            warningMessageLabel.setText("");

            if(currentlyInserting)
            {
                RoomFurnitureQueries.insert(connection, new RoomFurniture(furnitureID, currentRoom.getCityID(), currentRoom.getPropertyAddress()
                        , currentRoom.getRoomNumber(), qty));
                statusMessageLabel.setText("Item inserted.");
                currentlyInserting = false;
            }
            else if(currentlyUpdating)
            {
                RoomFurnitureQueries.update(connection, new RoomFurniture(furnitureID, currentRoom.getCityID(), currentRoom.getPropertyAddress()
                        , currentRoom.getRoomNumber(), qty));
                statusMessageLabel.setText("Item updated.");
                currentlyUpdating = false;
            }

            activateDataFields(false);
            roomFurnitureTableView.setItems(RoomFurnitureQueries.selectAll(connection, currentRoom));
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
        currentRoom = null;
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
        roomFurnitureTableView.setDisable(isActive);

        qtyTextField.setDisable(!isActive);
        cancelButton.setDisable(!isActive);
        confirmButton.setDisable(!isActive);

        furnitureChoiceBox.setDisable(!currentlyInserting);
    }

    private void reset()
    {
        qtyTextField.clear();
        furnitureChoiceBox.setValue(null);
        statusMessageLabel.setText("");
        warningMessageLabel.setText("");
        currentlyInserting = false;
        currentlyUpdating = false;
    }
}
