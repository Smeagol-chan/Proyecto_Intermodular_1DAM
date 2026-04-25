package org.example.demo;

import javafx.beans.property.ReadOnlyObjectWrapper;
import javafx.beans.property.SimpleIntegerProperty;
import javafx.beans.property.SimpleStringProperty;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.*;

import java.sql.Connection;
import java.time.LocalDate;

public class HelloController {

    static Connection bd;

    public Label actionLabel;
    public TableView<Estudiante> estudiantesTableView;
    public TableColumn<Estudiante,Integer> niaTableColumn;
    public TableColumn<Estudiante,String> nombreTableColumn;
    public TableColumn<Estudiante, LocalDate> fechaTableColumn;
    public Button editarButton;
    public Button eliminarButton;
    public TextField niaTextField;
    public TextField nombreTextField;
    public DatePicker fechaPicker;
    public Button insertarButton;
    public Button guardarButton;

    @FXML
    public void initialize(){

        bd = BaseDatos.conexion();

        niaTableColumn.setCellValueFactory(datos -> new SimpleIntegerProperty(datos.getValue().getNia()).asObject());
        nombreTableColumn.setCellValueFactory(datos -> new SimpleStringProperty(datos.getValue().getNombre()));
        fechaTableColumn.setCellValueFactory(datos -> new ReadOnlyObjectWrapper<>(datos.getValue().getFecha_nacimiento()));

        estudiantesTableView.setItems(BaseDatos.consulta(bd));

    }


    public void editarClickButton() {
        Estudiante seleccionado = estudiantesTableView.getSelectionModel().getSelectedItem();

        if (seleccionado == null){
            actionLabel.setText("No hay nada seleccionado.");
        }else {

            insertarButton.setDisable(true);
            guardarButton.setDisable(false);

            niaTextField.setText(Integer.toString(seleccionado.getNia()));
            nombreTextField.setText(seleccionado.getNombre());
            fechaPicker.setValue(seleccionado.getFecha_nacimiento());

            niaTextField.setDisable(true);

        }
    }

    public void eliminarClickButton() {

        Estudiante seleccionado = estudiantesTableView.getSelectionModel().getSelectedItem();

        if (seleccionado == null){
            actionLabel.setText("No hay nada seleccionado.");
        }else {

            BaseDatos.eliminar(bd,seleccionado);
            actionLabel.setText("Estudiante borrado.");
        }

        estudiantesTableView.setItems(BaseDatos.consulta(bd));
    }

    public void insertarButtonClick() {
        Integer nia = 0;

        try {
            nia = Integer.parseInt(niaTextField.getText());
        }catch (Exception e){
            actionLabel.setText("El nia tiene que ser numérico");
        }

        String nombre = nombreTextField.getText();
        LocalDate fecha = fechaPicker.getValue();

        if (nia == null || nombre == null || fecha == null){
           actionLabel.setText("Rellena todos los campos");
        }else{

            Estudiante estudiante = new Estudiante(nia,nombre,fecha);

            BaseDatos.insertar(bd,estudiante);

            nombreTextField.clear();
            niaTextField.clear();
            fechaPicker.setValue(null);

            estudiantesTableView.setItems(BaseDatos.consulta(bd));

        }

    }

    public void guardarButtonClick() {

        Integer nia = Integer.parseInt(niaTextField.getText());
        String nombre = nombreTextField.getText();
        LocalDate fecha = fechaPicker.getValue();

        BaseDatos.editar(bd,new Estudiante(nia,nombre,fecha));

        nombreTextField.clear();
        niaTextField.clear();
        fechaPicker.setValue(null);

        estudiantesTableView.setItems(BaseDatos.consulta(bd));

        insertarButton.setDisable(false);
        guardarButton.setDisable(true);

        niaTextField.setDisable(false);

    }
}
