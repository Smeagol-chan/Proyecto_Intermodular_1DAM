package org.example.demo.controllers;

import javafx.beans.property.SimpleStringProperty;
import javafx.fxml.FXML;
import javafx.scene.control.*;
import org.example.demo.Database;
import org.example.demo.RoomieAplication;
import org.example.demo.objects.locations.City;
import org.example.demo.objects.locations.Province;
import org.example.demo.queries.CityQueries;
import org.example.demo.queries.ProvinceQueries;

import java.io.IOException;
import java.sql.Connection;

public class ProvincesController
{
    private static Connection connection;

    private static boolean currentlyInserting = false;
    private static boolean currentlyUpdating = false;

    @FXML
    private TableView<Province> provinceTableView;

    @FXML
    private TableColumn<Province, String> provinceIdTableColumn;

    @FXML
    private TableColumn<Province, String> provinceNameTableColumn;

    @FXML
    private TextField provinceNameTextField;

    @FXML
    private TextField provinceIDTextField;

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

        provinceIdTableColumn.setCellValueFactory(dato -> new SimpleStringProperty(dato.getValue().getProvinceId()));
        provinceNameTableColumn.setCellValueFactory(dato -> new SimpleStringProperty(dato.getValue().getProvinceName()));

        provinceTableView.setItems(ProvinceQueries.selectAll(connection));
    }

    @FXML
    private void onModifyClickButton()
    {
        Province province = provinceTableView.getSelectionModel().getSelectedItem();

        if(province == null)
        {
            warningMessageLabel.setText("No province was selected.");
            statusMessageLabel.setText("");
        }
        else
        {
            warningMessageLabel.setText("");
            statusMessageLabel.setText("");
            provinceNameTextField.setText(province.getProvinceName());
            provinceIDTextField.setText(province.getProvinceId());

            activateDataFields(true);
            currentlyUpdating = true;
        }
    }

    @FXML
    private void onDeleteClickButton()
    {
        Province province = provinceTableView.getSelectionModel().getSelectedItem();

        if(province == null)
        {
            warningMessageLabel.setText("No province was selected.");
            statusMessageLabel.setText("");
        }
        else
        {
            ProvinceQueries.delete(connection, province.getProvinceId());

            warningMessageLabel.setText("");
            statusMessageLabel.setText("Province '"+ province.getProvinceName() +"' deleted.");
            provinceTableView.setItems(ProvinceQueries.selectAll(connection));
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
        String provinceID = provinceIDTextField.getText();
        String provinceName = provinceNameTextField.getText();

        if(provinceID == null || provinceName == null)
        {
            warningMessageLabel.setText("Empty fields left.");
            statusMessageLabel.setText("");
        }
        else
        {
            warningMessageLabel.setText("");

            if(currentlyInserting)
            {
                ProvinceQueries.insert(connection, new Province(provinceID, provinceName));
                statusMessageLabel.setText("Province " + provinceName + " inserted.");
                currentlyInserting = false;
            }
            else if(currentlyUpdating)
            {
                provinceIDTextField.setDisable(true);

                ProvinceQueries.update(connection, new Province(provinceID, provinceName));
                statusMessageLabel.setText("Province "+ provinceName +" updated.");
                currentlyUpdating = false;
            }

            activateDataFields(false);
            provinceTableView.setItems(ProvinceQueries.selectAll(connection));
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
        provinceTableView.setDisable(isActive);

        provinceNameTextField.setDisable(!isActive);
        cancelButton.setDisable(!isActive);
        confirmButton.setDisable(!isActive);

        provinceIDTextField.setDisable(!currentlyInserting);
    }

    private void reset()
    {
        provinceNameTextField.clear();
        provinceIDTextField.clear();
        statusMessageLabel.setText("");
        warningMessageLabel.setText("");
        currentlyInserting = false;
        currentlyUpdating = false;
    }
}
