package org.example.demo;

import javafx.fxml.FXML;

import java.io.IOException;

public class ActionsController
{
    @FXML
    public void onLogoutClickButton() throws IOException
    {
        RoomieAplication.setRoot("login-view");
    }
}
