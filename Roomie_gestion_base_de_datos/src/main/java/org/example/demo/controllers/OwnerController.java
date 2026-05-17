package org.example.demo.controllers;

import javafx.beans.property.ReadOnlyObjectWrapper;
import javafx.beans.property.SimpleIntegerProperty;
import javafx.beans.property.SimpleStringProperty;
import javafx.fxml.FXML;
import javafx.scene.control.*;
import org.example.demo.Database;
import org.example.demo.RoomieAplication;
import org.example.demo.objects.users.Owner;
import org.example.demo.queries.OwnerQueries;

import java.io.IOException;
import java.sql.Connection;
import java.time.LocalDate;

public class OwnerController
{
    private static Connection connection;

    private static boolean currentlyInserting = false;
    private static boolean currentlyUpdating = false;

    @FXML
    private TableView<Owner> ownersTableView;

    @FXML
    private TableColumn<Owner, String> ownerDniTableColumn;

    @FXML
    private TableColumn<Owner, String> nameTableColumn;

    @FXML
    private TableColumn<Owner, String> surnamesTableColumn;

    @FXML
    private TableColumn<Owner, LocalDate> birthdateTableColumn;

    @FXML
    private TableColumn<Owner, String> phoneNumberTableColumn;

    @FXML
    private TableColumn<Owner, String> emailTableColumn;

    @FXML
    private TableColumn<Owner, Integer> numberPropertiesTableColumn;

    @FXML
    private TextField ownerDniTextField;

    @FXML
    private DatePicker birthdateDatePicker;

    @FXML
    private TextField nameTextField;

    @FXML
    private TextField surnamesTextField;

    @FXML
    private TextField emailTextField;

    @FXML
    private PasswordField passwordPasswordField;

    @FXML
    private TextField phoneNumberTextField;

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

        ownerDniTableColumn.setCellValueFactory(dato -> new SimpleStringProperty(dato.getValue().getDni()));
        nameTableColumn.setCellValueFactory(dato -> new SimpleStringProperty(dato.getValue().getUserName()));
        surnamesTableColumn.setCellValueFactory(dato -> new SimpleStringProperty(dato.getValue().getSurnames()));
        birthdateTableColumn.setCellValueFactory(dato -> new ReadOnlyObjectWrapper<>(dato.getValue().getBirthdate()));
        phoneNumberTableColumn.setCellValueFactory(dato -> new SimpleStringProperty(dato.getValue().getPhoneNumber()));
        emailTableColumn.setCellValueFactory(dato -> new SimpleStringProperty(dato.getValue().getEmail()));
        numberPropertiesTableColumn.setCellValueFactory(dato -> new SimpleIntegerProperty(dato.getValue().getNumeberProperties()).asObject());

        ownersTableView.setItems(OwnerQueries.selectAll(connection));
    }

    @FXML
    private void onModifyClickButton()
    {
        Owner owner = ownersTableView.getSelectionModel().getSelectedItem();

        if(owner == null)
        {
            warningMessageLabel.setText("No owner was selected.");
            statusMessageLabel.setText("");
        }
        else
        {
            warningMessageLabel.setText("");
            statusMessageLabel.setText("");

            nameTextField.setText(owner.getUserName());
            surnamesTextField.setText(owner.getSurnames());
            emailTextField.setText(owner.getEmail());
            phoneNumberTextField.setText(owner.getPhoneNumber());
            ownerDniTextField.setText(owner.getDni());
            birthdateDatePicker.setValue(owner.getBirthdate());
            passwordPasswordField.setText(owner.getPassword());

            activateDataFields(true);
            currentlyUpdating = true;
        }
    }

    @FXML
    private void onDeleteClickButton()
    {
        Owner owner = ownersTableView.getSelectionModel().getSelectedItem();

        if(owner == null)
        {
            warningMessageLabel.setText("No owner was selected.");
            statusMessageLabel.setText("");
        }
        else
        {
            OwnerQueries.delete(connection, owner.getDni());

            warningMessageLabel.setText("");
            statusMessageLabel.setText("Owner deleted.");
            ownersTableView.setItems(OwnerQueries.selectAll(connection));
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
        String name = nameTextField.getText();
        String surnames = surnamesTextField.getText();
        String phone = emailTextField.getText();
        String email = phoneNumberTextField.getText();
        String dni = ownerDniTextField.getText();
        LocalDate birth = birthdateDatePicker.getValue();
        String password = passwordPasswordField.getText();

        if(name == null || surnames == null || phone == null || email == null || dni == null || birth == null || password == null)
        {
            warningMessageLabel.setText("Empty fields left.");
            statusMessageLabel.setText("");
        }
        else
        {
            warningMessageLabel.setText("");

            if(currentlyInserting)
            {
                OwnerQueries.insert(connection, new Owner(dni, name, surnames, birth, phone, email, password));
                statusMessageLabel.setText("Owner inserted.");
                currentlyInserting = false;
            }
            else if(currentlyUpdating)
            {
                OwnerQueries.update(connection, new Owner(dni, name, surnames, birth, phone, email, password));
                statusMessageLabel.setText("Owner updated.");
                currentlyUpdating = false;
            }

            activateDataFields(false);
            ownersTableView.setItems(OwnerQueries.selectAll(connection));
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
        ownersTableView.setDisable(isActive);

        nameTextField.setDisable(!isActive);
        surnamesTextField.setDisable(!isActive);
        emailTextField.setDisable(!isActive);
        phoneNumberTextField.setDisable(!isActive);
        cancelButton.setDisable(!isActive);
        confirmButton.setDisable(!isActive);

        ownerDniTextField.setDisable(!currentlyInserting);
        birthdateDatePicker.setDisable(!currentlyInserting);
        passwordPasswordField.setDisable(!currentlyInserting);
    }

    private void reset()
    {
        nameTextField.clear();
        surnamesTextField.clear();
        emailTextField.clear();
        phoneNumberTextField.clear();
        ownerDniTextField.clear();
        birthdateDatePicker.setValue(null);
        passwordPasswordField.clear();

        statusMessageLabel.setText("");
        warningMessageLabel.setText("");
        currentlyInserting = false;
        currentlyUpdating = false;
    }
}
