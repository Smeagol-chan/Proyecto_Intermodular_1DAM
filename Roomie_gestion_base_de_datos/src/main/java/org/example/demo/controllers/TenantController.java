package org.example.demo.controllers;

import javafx.beans.property.ReadOnlyObjectWrapper;
import javafx.beans.property.SimpleIntegerProperty;
import javafx.beans.property.SimpleStringProperty;
import javafx.fxml.FXML;
import javafx.scene.control.*;
import org.example.demo.Database;
import org.example.demo.RoomieAplication;
import org.example.demo.objects.users.Tenant;
import org.example.demo.queries.OwnerQueries;
import org.example.demo.queries.TenantQueries;

import java.io.IOException;
import java.sql.Connection;
import java.time.LocalDate;

public class TenantController
{
    private static Connection connection;

    private static boolean currentlyInserting = false;
    private static boolean currentlyUpdating = false;

    @FXML
    private TableView<Tenant> tenantsTableView;

    @FXML
    private TableColumn<Tenant, String> tenantDniTableColumn;

    @FXML
    private TableColumn<Tenant, String> nameTableColumn;

    @FXML
    private TableColumn<Tenant, String> surnamesTableColumn;

    @FXML
    private TableColumn<Tenant, LocalDate> birthdateTableColumn;

    @FXML
    private TableColumn<Tenant, String> phoneNumberTableColumn;

    @FXML
    private TableColumn<Tenant, String> emailTableColumn;

    @FXML
    private TableColumn<Tenant, String> studentLicenseTableColumn;

    @FXML
    private TextField tenantDniTextField;

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
    private TextField studentLicenseTextField;

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

        tenantDniTableColumn.setCellValueFactory(dato -> new SimpleStringProperty(dato.getValue().getDni()));
        nameTableColumn.setCellValueFactory(dato -> new SimpleStringProperty(dato.getValue().getUserName()));
        surnamesTableColumn.setCellValueFactory(dato -> new SimpleStringProperty(dato.getValue().getSurnames()));
        birthdateTableColumn.setCellValueFactory(dato -> new ReadOnlyObjectWrapper<>(dato.getValue().getBirthdate()));
        phoneNumberTableColumn.setCellValueFactory(dato -> new SimpleStringProperty(dato.getValue().getPhoneNumber()));
        emailTableColumn.setCellValueFactory(dato -> new SimpleStringProperty(dato.getValue().getEmail()));
        studentLicenseTableColumn.setCellValueFactory(dato -> new SimpleStringProperty(dato.getValue().getStudentLicense()));

        tenantsTableView.setItems(TenantQueries.selectAll(connection));
    }

    @FXML
    private void onModifyClickButton()
    {
        Tenant tenant = tenantsTableView.getSelectionModel().getSelectedItem();

        if(tenant == null)
        {
            warningMessageLabel.setText("No tenant was selected.");
            statusMessageLabel.setText("");
        }
        else
        {
            warningMessageLabel.setText("");
            statusMessageLabel.setText("");

            nameTextField.setText(tenant.getUserName());
            surnamesTextField.setText(tenant.getSurnames());
            emailTextField.setText(tenant.getEmail());
            phoneNumberTextField.setText(tenant.getPhoneNumber());
            tenantDniTextField.setText(tenant.getDni());
            birthdateDatePicker.setValue(tenant.getBirthdate());
            passwordPasswordField.setText(tenant.getPassword());

            activateDataFields(true);
            currentlyUpdating = true;
        }
    }

    @FXML
    private void onDeleteClickButton()
    {
        Tenant tenant = tenantsTableView.getSelectionModel().getSelectedItem();

        if(tenant == null)
        {
            warningMessageLabel.setText("No tenant was selected.");
            statusMessageLabel.setText("");
        }
        else
        {
            TenantQueries.delete(connection, tenant.getDni());

            warningMessageLabel.setText("");
            statusMessageLabel.setText("Tenant deleted.");
            tenantsTableView.setItems(TenantQueries.selectAll(connection));
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
        String name = nameTextField.getText();
        String surnames = surnamesTextField.getText();
        String phone = emailTextField.getText();
        String email = phoneNumberTextField.getText();
        String dni = tenantDniTextField.getText();
        LocalDate birth = birthdateDatePicker.getValue();
        String password = passwordPasswordField.getText();
        String license = studentLicenseTextField.getText();

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
                TenantQueries.insert(connection, new Tenant(dni, name, surnames, birth, phone, email, password, license));
                statusMessageLabel.setText("Tenant inserted.");
                currentlyInserting = false;
            }
            else if(currentlyUpdating)
            {
                TenantQueries.update(connection, new Tenant(dni, name, surnames, birth, phone, email, password, license));
                statusMessageLabel.setText("Tenant updated.");
                currentlyUpdating = false;
            }

            activateDataFields(false);
            tenantsTableView.setItems(TenantQueries.selectAll(connection));
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
        tenantsTableView.setDisable(isActive);

        nameTextField.setDisable(!isActive);
        surnamesTextField.setDisable(!isActive);
        emailTextField.setDisable(!isActive);
        phoneNumberTextField.setDisable(!isActive);
        studentLicenseTextField.setDisable(!isActive);
        cancelButton.setDisable(!isActive);
        confirmButton.setDisable(!isActive);

        tenantDniTextField.setDisable(!currentlyInserting);
        birthdateDatePicker.setDisable(!currentlyInserting);
        passwordPasswordField.setDisable(!currentlyInserting);
    }

    private void reset()
    {
        nameTextField.clear();
        surnamesTextField.clear();
        emailTextField.clear();
        phoneNumberTextField.clear();
        tenantDniTextField.clear();
        birthdateDatePicker.setValue(null);
        passwordPasswordField.clear();
        studentLicenseTextField.clear();

        statusMessageLabel.setText("");
        warningMessageLabel.setText("");
        currentlyInserting = false;
        currentlyUpdating = false;
    }
}
