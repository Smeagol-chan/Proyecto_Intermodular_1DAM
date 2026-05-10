package org.example.demo.controllers;

import javafx.fxml.FXML;
import org.example.demo.RoomieAplication;

import java.io.IOException;

public class WelcomeController
{
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
