package org.example.demo.controllers;

import javafx.fxml.FXML;
import javafx.scene.control.Label;
import javafx.scene.control.PasswordField;
import javafx.scene.control.TextField;
import org.example.demo.RoomieAplication;

import java.io.IOException;

public class LoginController
{
    @FXML
    private Label wrongUserLabel;

    @FXML
    private Label wrongPasswordLabel;

    @FXML
    private TextField usernameTextField;

    @FXML
    private PasswordField passwordPasswordField;

    @FXML
    public void onConfirmClickButton() throws IOException
    {
        cleanLabels();
        String user = usernameTextField.getText();
        String password = passwordPasswordField.getText();

        if(!user.equals("sa"))
        {
            cleanFields();
            wrongUserLabel.setText("The user does not exist");
        }
        else if(!password.equals("roomie1234"))
        {
            passwordPasswordField.setText("");
            wrongPasswordLabel.setText("Incorrect password");
        }
        else RoomieAplication.setRoot("welcome");
    }

    @FXML
    public void onResetClickButton()
    {
        cleanLabels();
        cleanFields();
    }

    private void cleanLabels()
    {
        wrongUserLabel.setText("");
        wrongPasswordLabel.setText("");
    }

    private void cleanFields()
    {
        usernameTextField.setText("");
        passwordPasswordField.setText("");
    }
}
