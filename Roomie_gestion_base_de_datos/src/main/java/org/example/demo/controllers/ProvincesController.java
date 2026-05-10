package org.example.demo.controllers;

import javafx.beans.property.SimpleStringProperty;
import javafx.fxml.FXML;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import org.example.demo.Database;
import org.example.demo.RoomieAplication;
import org.example.demo.objects.locations.Province;
import org.example.demo.queries.ProvinceQueries;

import java.io.IOException;
import java.sql.Connection;

public class ProvincesController
{
    private static Connection connection;

    @FXML
    private TableView<Province> provinceTableView;

    @FXML
    private TableColumn<Province, String> provinceIdTableColumn;

    @FXML
    private TableColumn<Province, String> provinceNameTableColumn;

    @FXML
    private void initialize()
    {
        connection = Database.conexion();

        provinceIdTableColumn.setCellValueFactory(dato -> new SimpleStringProperty(dato.getValue().getProvinceId()));
        provinceNameTableColumn.setCellValueFactory(dato -> new SimpleStringProperty(dato.getValue().getProvinceName()));

        provinceTableView.setItems(ProvinceQueries.selectAll(connection));
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
}
