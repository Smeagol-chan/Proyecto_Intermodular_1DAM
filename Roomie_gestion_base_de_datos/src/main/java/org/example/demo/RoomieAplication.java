package org.example.demo;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;

import java.io.IOException;

public class RoomieAplication extends Application
{
    private static Scene scene;

    private static Parent loadFXML(String fxml) throws IOException
    {
        FXMLLoader fxmlLoader = new FXMLLoader(RoomieAplication.class.getResource(fxml + ".fxml"));
        return fxmlLoader.load();
    }

    public static void setRoot(String fxml) throws IOException
    {
        scene.setRoot(loadFXML(fxml));
    }

    @Override
    public void start(Stage stage) throws IOException
    {
        final String VENTANA_INICIAL = "login-view";
        final String NOMBRE_VENTANA = "Roomie";

        scene = new Scene(loadFXML(VENTANA_INICIAL), 600, 400);

        stage.setTitle(NOMBRE_VENTANA);
        stage.setScene(scene);
        stage.show();
    }
}