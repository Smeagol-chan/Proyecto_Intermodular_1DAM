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
import org.example.demo.objects.properties.Room;
import org.example.demo.queries.CityQueries;
import org.example.demo.queries.RoomQueries;

import java.io.IOException;
import java.sql.Connection;

public class RoomController
{
    private static Connection connection;

    private static boolean currentlyInserting = false;
    private static boolean currentlyUpdating = false;

    private static final ObservableList<String> STATUS_LIST = FXCollections.observableArrayList("Shared Space", "Rented", "Available");
    private static final ObservableList<String> TYPE_LIST = FXCollections.observableArrayList("Storage Room", "Dinning Room", "Bedroom", "Hall",
            "Bathroom", "Balcony", "Living Room", "Kitchen");

    @FXML
    private TableView<Room> roomTableView;

    @FXML
    private TableColumn<Room, Integer> roomNumberTableColumn;

    @FXML
    private TableColumn<Room, String> addressTableColumn;

    @FXML
    private TableColumn<Room, Integer> cityIdTableColumn;

    @FXML
    private TableColumn<Room, String> typeTableColumn;

    @FXML
    private TableColumn<Room, String> statusTableColumn;

    @FXML
    private TableColumn<Room, Double> surfaceTableColumn;

    @FXML
    private TableColumn<Room, Double> pricePerMonthTableColumn;

    @FXML
    private TextField addressTextField;

    @FXML
    private ChoiceBox<String> cityChoiceBox;

    @FXML
    private ChoiceBox<String> typeChoiceBox;

    @FXML
    private ChoiceBox<String> statusChoiceBox;

    @FXML
    private TextField surfaceTextField;

    @FXML
    private TextField pricePerMonthTextField;

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
    private Button addFurnitureButton;

    @FXML
    private void initialize()
    {
        connection = Database.conexion();

        roomNumberTableColumn.setCellValueFactory(dato -> new SimpleIntegerProperty(dato.getValue().getRoomNumber()).asObject());
        addressTableColumn.setCellValueFactory(dato -> new SimpleStringProperty(dato.getValue().getPropertyAddress()));
        cityIdTableColumn.setCellValueFactory(dato -> new SimpleIntegerProperty(dato.getValue().getCityID()).asObject());
        typeTableColumn.setCellValueFactory(dato -> new SimpleStringProperty(dato.getValue().getType()));
        surfaceTableColumn.setCellValueFactory(dato -> new SimpleDoubleProperty(dato.getValue().getSurface()).asObject());
        statusTableColumn.setCellValueFactory(dato -> new SimpleStringProperty(dato.getValue().getStatus()));
        pricePerMonthTableColumn.setCellValueFactory(dato -> new SimpleDoubleProperty(dato.getValue().getPricePerMonth()).asObject());

        cityChoiceBox.setItems(CityQueries.selectCitiesNameProvinceName(connection));
        statusChoiceBox.setItems(STATUS_LIST);
        typeChoiceBox.setItems(TYPE_LIST);

        roomTableView.setItems(RoomQueries.selectAll(connection));
    }

    @FXML
    private void onAddFurnitureClickButton()throws IOException
    {
        Room room = roomTableView.getSelectionModel().getSelectedItem();

        if(room == null) warningMessageLabel.setText("No room was selected.");
        else
        {
            RoomFurnitureController.currentRoom = room;
            RoomieAplication.setRoot("room-furniture");
        }
    }

    @FXML
    private void onModifyClickButton()
    {
        Room room = roomTableView.getSelectionModel().getSelectedItem();

        if(room == null)
        {
            warningMessageLabel.setText("No room was selected.");
            statusMessageLabel.setText("");
        }
        else
        {
            warningMessageLabel.setText("");
            statusMessageLabel.setText("");
            addressTextField.setText(room.getPropertyAddress());
            cityChoiceBox.setValue(CityQueries.getCityNameProvinceName(connection, room.getCityID()));
            typeChoiceBox.setValue(room.getType());
            statusChoiceBox.setValue(room.getStatus());
            surfaceTextField.setText(String.valueOf(room.getSurface()));
            pricePerMonthTextField.setText(String.valueOf(room.getPricePerMonth()));

            activateDataFields(true);
            currentlyUpdating = true;
        }
    }

    @FXML
    private void onDeleteClickButton()
    {
        Room room = roomTableView.getSelectionModel().getSelectedItem();

        if(room == null)
        {
            warningMessageLabel.setText("No room was selected.");
            statusMessageLabel.setText("");
        }
        else
        {
            RoomQueries.delete(connection, room);

            warningMessageLabel.setText("");
            statusMessageLabel.setText("Room deleted.");
            roomTableView.setItems(RoomQueries.selectAll(connection));
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
        Integer cityID = CityQueries.getCityIdByCityNameProvinceName(connection, cityChoiceBox.getValue());
        String type = typeChoiceBox.getValue();
        String status = statusChoiceBox.getValue();
        Double surface, pricePerMonth;

        try
        {
            surface = Double.parseDouble(surfaceTextField.getText());
            pricePerMonth = Double.parseDouble(pricePerMonthTextField.getText());
        }
        catch (NumberFormatException e)
        {
            warningMessageLabel.setText("Surface and Price per Month fields only admit numeric values.");
            System.out.println(e.getMessage());
            throw new RuntimeException(e);
        }

        if(address == null || cityID == null || type == null || surface == null || pricePerMonth == null)
        {
            warningMessageLabel.setText("Empty fields left.");
            statusMessageLabel.setText("");
        }
        else
        {
            warningMessageLabel.setText("");

            if(currentlyInserting)
            {
                RoomQueries.insert(connection, new Room(address, cityID, type, surface, status, pricePerMonth));
                statusMessageLabel.setText("Property inserted.");
                currentlyInserting = false;
            }
            else if(currentlyUpdating)
            {
                Integer roomNumber = roomTableView.getSelectionModel().getSelectedItem().getRoomNumber();

                RoomQueries.update(connection, new Room(address, cityID, type, surface, status, pricePerMonth));
                statusMessageLabel.setText("Property updated.");
                currentlyUpdating = false;
            }

            activateDataFields(false);
            roomTableView.setItems(RoomQueries.selectAll(connection));
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
        roomTableView.setDisable(isActive);
        addFurnitureButton.setDisable(isActive);

        typeChoiceBox.setDisable(!isActive);
        surfaceTextField.setDisable(!isActive);
        statusChoiceBox.setDisable(!isActive);
        pricePerMonthTextField.setDisable(!isActive);
        cancelButton.setDisable(!isActive);
        confirmButton.setDisable(!isActive);

        cityChoiceBox.setDisable(!currentlyInserting);
        addressTextField.setDisable(!currentlyInserting);
    }

    private void reset()
    {
        addressTextField.clear();
        cityChoiceBox.setValue(null);
        typeChoiceBox.setValue(null);
        statusChoiceBox.setValue(null);
        surfaceTextField.clear();
        pricePerMonthTextField.clear();
        statusMessageLabel.setText("");
        warningMessageLabel.setText("");
        currentlyInserting = false;
        currentlyUpdating = false;
    }
}
