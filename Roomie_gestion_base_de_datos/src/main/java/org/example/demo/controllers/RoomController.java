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

/**
 * Controller class for ROOM.
 * All controllers have the same functionality besides the attributes and querie classes to use.
 *
 * @author Eric
 */
public class RoomController
{
    private static Connection connection;

    /**
     * These two booleans mark if the user have clicked on modify (currentlyUpdating = true) or
     * on insert (currentlyInserting = true).
     *
     * It is used for calling the right method on onConfirmClickButton and for enabling the correct data fields.
     */
    private static boolean currentlyInserting = false;
    private static boolean currentlyUpdating = false;

    /**
     * ObservableLists to add data in the choice boxes. These contain static values; do not depend on de data stored in the database.
     */
    private static final ObservableList<String> STATUS_LIST = FXCollections.observableArrayList("Shared Space", "Rented", "Available");
    private static final ObservableList<String> TYPE_LIST = FXCollections.observableArrayList("Storage Room", "Dinning Room", "Bedroom", "Hall",
            "Bathroom", "Balcony", "Living Room", "Kitchen");

    /**
     * Declarations for the table, its columns, labels, the action buttons and the data fields in the window.
     */
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

    /**
     * This procedure adds the data to the table and the choice boxes and displays it.
     */
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

        // There are two ways to insert values to the choice boxes in this program:
        // - cityChoiceBox depends on the data stored in the database, in CITY table. So to set its items, I invoke a function
        // on CityQueries that returns all city names with its province name.
        cityChoiceBox.setItems(CityQueries.selectCitiesNameProvinceName(connection));
        // - status and typeChoiceBox have fixed items and are declared at the begining of the class.
        statusChoiceBox.setItems(STATUS_LIST);
        typeChoiceBox.setItems(TYPE_LIST);

        roomTableView.setItems(RoomQueries.selectAll(connection));
    }

    /**
     * This method is for alter and see the data inside ROOM_FURNITURE table.
     * The table is a many to many relationship between ROOM and FURNITURE. It is only accessible through room view.
     * This kind of method is only present here and in property and institution views 'cause both tables have also a many to many relationship.
     *
     * The procedure redirects the user to room-furniture-view and filters the data on the table by showing only the furniture of the selected room.
     *
     * @throws IOException
     */
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

    /**
     * Inserts the selected table item attributes on the filds bellow, dissabling those that form the PK, so the user can edit them.
     */
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

    /**
     * Deletes the selected table item from the database.
     */
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

    /**
     * Enables all fields so the user can insert a new row into the database.
     */
    @FXML
    private void onInsertClickButton()
    {
        currentlyInserting = true;
        activateDataFields(true);
        statusMessageLabel.setText("");
        warningMessageLabel.setText("");
    }

    /**
     * The method retrieves the data of all fields and, depending on the values of currentlyInsering and currentlyUpdating,
     * it invokes insert() or update() from the corresponding query class.
     */
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

    /**
     * Resets all fields and labels and cancel all ongoing actions.
     */
    @FXML
    private void onCancelClickButton()
    {
        reset();
        activateDataFields(false);
    }

    // The following on click methods are for navegate the navegation menu and are the same for evey single class.
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

    /**
     * Procedure that disables and enables the fields on command.
     *
     * activateDataFields(true) disables the table and modify, delete and insert button, enabling all fields and cancel and confirm buttons.
     * activateDataFields(false) enables the table and modify, delete and insert button, disabling all fields and cancel and confirm buttons.
     *
     * @param isActive - Boolean that enables or disables every button and field depending on the process the user have selected.
     */
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

    /**
     * Resets all fields and curruntlyUpdating and Inserting values to false.
     */
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
