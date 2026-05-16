package org.example.demo.controllers;

import javafx.beans.property.SimpleIntegerProperty;
import javafx.beans.property.SimpleStringProperty;
import javafx.fxml.FXML;
import javafx.scene.control.*;
import org.example.demo.Database;
import org.example.demo.RoomieAplication;
import org.example.demo.objects.locations.City;
import org.example.demo.queries.CityQueries;
import org.example.demo.queries.ProvinceQueries;

import java.io.IOException;
import java.sql.Connection;

public class CitiesController
{
    private static Connection connection;

    private static boolean currentlyInserting = false;
    private static boolean currentlyUpdating = false;

    @FXML
    private TableView<City> cityTableView;

    @FXML
    private TableColumn<City, Integer> cityIdTableColumn;

    @FXML
    private TableColumn<City, String> cityNameTableColumn;

    @FXML
    private TableColumn<City, String> provinceIdTableColumn;

    @FXML
    private ChoiceBox provinceNameChoiceBox;

    @FXML
    private TextField cityNameTextField;

    @FXML
    private Label warningMessageLabel;

    @FXML
    private Label statusMessageLabel;

    @FXML
    private Button detailsButton;

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

        cityIdTableColumn.setCellValueFactory(dato -> new SimpleIntegerProperty(dato.getValue().getCityId()).asObject());
        cityNameTableColumn.setCellValueFactory(dato -> new SimpleStringProperty(dato.getValue().getCityName()));
        provinceIdTableColumn.setCellValueFactory(dato -> new SimpleStringProperty(dato.getValue().getProvinceId()));

        provinceNameChoiceBox.setItems(ProvinceQueries.selectAllNames(connection));

        cityTableView.setItems(CityQueries.selectAll(connection));
    }

    @FXML
    private void onPropertiesClickButton() throws IOException
    {
        RoomieAplication.setRoot("properties");
    }

    @FXML
    private void onFurnitureClickButton() throws IOException
    {
        RoomieAplication.setRoot("furniture");
    }

    @FXML
    private void onUsersClickButton() throws IOException
    {
        RoomieAplication.setRoot("users");
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

    @FXML
    private void onDetailsClickButton()
    {
        activateDataFields(true);
        warningMessageLabel.setText("No hay funcionalidad.");
        statusMessageLabel.setText("No hay funcionalidad.");
    }

    @FXML
    private void onModifyClickButton()
    {
        City city = cityTableView.getSelectionModel().getSelectedItem();

        if(city == null)
        {
            warningMessageLabel.setText("No city was selected.");
            statusMessageLabel.setText("");
        }
        else
        {
            warningMessageLabel.setText("");
            statusMessageLabel.setText("");
            cityNameTextField.setText(city.getCityName());
            provinceNameChoiceBox.setValue(ProvinceQueries.obtainNameByID(connection, city.getProvinceId()));

            activateDataFields(true);
            currentlyUpdating = true;
        }
    }

    @FXML
    private void onDeleteClickButton()
    {
        City city = cityTableView.getSelectionModel().getSelectedItem();

        if(city == null)
        {
            warningMessageLabel.setText("No city was selected.");
            statusMessageLabel.setText("");
        }
        else
        {
            CityQueries.delete(connection, city.getCityId());

            warningMessageLabel.setText("");
            statusMessageLabel.setText("City '"+ city.getCityName() +"' deleted.");
            cityTableView.setItems(CityQueries.selectAll(connection));
        }
    }

    @FXML
    private void onCancelClickButton()
    {
        activateDataFields(false);
        reset();
    }

    @FXML
    private void onConfirmClickButton()
    {
        String cityName = cityNameTextField.getText();
        Object provinceName = provinceNameChoiceBox.getValue();

        if(cityName == null || provinceName == null)
        {
            warningMessageLabel.setText("Empty fields left.");
            statusMessageLabel.setText("");
        }
        else
        {
            warningMessageLabel.setText("");
            String provinceID = ProvinceQueries.obtainIDByName(connection, provinceName.toString());

            if(currentlyInserting)
            {
                CityQueries.insert(connection, new City(cityName, provinceID));
                statusMessageLabel.setText("City #" + CityQueries.getLastCityIDInserted(connection) + " inserted.");
                currentlyInserting = false;
            }
            else if(currentlyUpdating)
            {
                Integer cityID = cityTableView.getSelectionModel().getSelectedItem().getCityId();

                CityQueries.update(connection, new City(cityID, cityName, provinceID));
                statusMessageLabel.setText("City #"+ cityID +" updated.");
                currentlyUpdating = false;
            }

            activateDataFields(false);
            cityTableView.setItems(CityQueries.selectAll(connection));
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

    private void activateDataFields(boolean isActive)
    {
        detailsButton.setDisable(isActive);
        modifyButton.setDisable(isActive);
        deleteButton.setDisable(isActive);
        insertButton.setDisable(isActive);
        cityTableView.setDisable(isActive);

        cityNameTextField.setDisable(!isActive);
        provinceNameChoiceBox.setDisable(!isActive);
        cancelButton.setDisable(!isActive);
        confirmButton.setDisable(!isActive);
    }

    private void reset()
    {
        cityNameTextField.clear();
        provinceNameChoiceBox.setValue(null);
        statusMessageLabel.setText("");
        warningMessageLabel.setText("");
        currentlyInserting = false;
        currentlyUpdating = false;
    }
}
