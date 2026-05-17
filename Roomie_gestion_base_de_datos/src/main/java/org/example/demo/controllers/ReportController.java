package org.example.demo.controllers;

import javafx.beans.property.ReadOnlyObjectWrapper;
import javafx.beans.property.SimpleDoubleProperty;
import javafx.beans.property.SimpleIntegerProperty;
import javafx.beans.property.SimpleStringProperty;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.scene.control.*;
import org.example.demo.Database;
import org.example.demo.RoomieAplication;
import org.example.demo.objects.paperwork.Report;
import org.example.demo.queries.CityQueries;
import org.example.demo.queries.ReportQueries;

import java.io.IOException;
import java.sql.Connection;
import java.time.LocalDate;
import java.time.LocalDateTime;

public class ReportController
{
    private static Connection connection;

    private static final ObservableList<String> STATUS_LIST = FXCollections.observableArrayList("Pending", "Checked");

    private static boolean currentlyInserting = false;
    private static boolean currentlyUpdating = false;

    @FXML
    private TableView<Report> reportTableView;

    @FXML
    private TableColumn<Report, Integer> reportIdTableColumn;

    @FXML
    private TableColumn<Report, LocalDateTime> reportDateTableColumn;

    @FXML
    private TableColumn<Report, String> userDniTableColumn;

    @FXML
    private TableColumn<Report, Integer> roomNumberTableColumn;

    @FXML
    private TableColumn<Report, String> propertyAddressTableColumn;

    @FXML
    private TableColumn<Report, Integer> propertyCiyIdTableColumn;

    @FXML
    private TableColumn<Report, String> issueTableColumn;

    @FXML
    private TableColumn<Report, String> detailsTableColumn;

    @FXML
    private TableColumn<Report, String> statusTableColumn;

    @FXML
    private DatePicker reportDateDatePicker;

    @FXML
    private TextField userDniTextField;

    @FXML
    private TextField roomNumberTextField;

    @FXML
    private TextField addressTextField;

    @FXML
    private ChoiceBox<String> cityChoiceBox;

    @FXML
    private TextField issueTextField;

    @FXML
    private TextArea detailsTextArea;

    @FXML
    private ChoiceBox<String> statusChoiceBox;

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

        reportIdTableColumn.setCellValueFactory(dato -> new SimpleIntegerProperty(dato.getValue().getReportID()).asObject());
        roomNumberTableColumn.setCellValueFactory(dato -> new SimpleIntegerProperty(dato.getValue().getRoomNumber()).asObject());
        propertyCiyIdTableColumn.setCellValueFactory(dato -> new SimpleIntegerProperty(dato.getValue().getPropertyCityId()).asObject());

        userDniTableColumn.setCellValueFactory(dato -> new SimpleStringProperty(dato.getValue().getUserDni()));
        propertyAddressTableColumn.setCellValueFactory(dato -> new SimpleStringProperty(dato.getValue().getPropertyAddress()));
        statusTableColumn.setCellValueFactory(dato -> new SimpleStringProperty(dato.getValue().getStatus()));
        issueTableColumn.setCellValueFactory(dato -> new SimpleStringProperty(dato.getValue().getIssue()));
        detailsTableColumn.setCellValueFactory(dato -> new SimpleStringProperty(dato.getValue().getDetails()));

        reportDateTableColumn.setCellValueFactory(dato -> new ReadOnlyObjectWrapper<>(dato.getValue().getReportDate()));

        reportTableView.setItems(ReportQueries.selectAll(connection));

        statusChoiceBox.setItems(STATUS_LIST);
        cityChoiceBox.setItems(CityQueries.selectCitiesNameProvince(connection));
    }

    @FXML
    private void onModifyClickButton()
    {
        Report report = reportTableView.getSelectionModel().getSelectedItem();

        if(report == null)
        {
            warningMessageLabel.setText("No report was selected.");
            statusMessageLabel.setText("");
        }
        else
        {
            warningMessageLabel.setText("");
            statusMessageLabel.setText("");

            reportDateDatePicker.setValue(report.getReportDate().toLocalDate());
            userDniTextField.setText(report.getUserDni());
            addressTextField.setText(report.getPropertyAddress());
            cityChoiceBox.setValue(CityQueries.getPorpertyCityName(connection, report.getPropertyCityId()));
            roomNumberTextField.setText(String.valueOf(report.getRoomNumber()));
            issueTextField.setText(report.getIssue());
            detailsTextArea.setText(report.getDetails());
            statusChoiceBox.setValue(report.getStatus());

            activateDataFields(true);
            currentlyUpdating = true;
        }
    }

    @FXML
    private void onDeleteClickButton()
    {
        Report report = reportTableView.getSelectionModel().getSelectedItem();

        if(report == null)
        {
            warningMessageLabel.setText("No report was selected.");
            statusMessageLabel.setText("");
        }
        else
        {
            ReportQueries.delete(connection, report.getReportID());

            warningMessageLabel.setText("");
            statusMessageLabel.setText("Report deleted.");
            reportTableView.setItems(ReportQueries.selectAll(connection));
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
        LocalDate reportDate = reportDateDatePicker.getValue();
        String userDni = userDniTextField.getText();
        String address = addressTextField.getText();
        Integer cityID = CityQueries.getCityIdByCityNameProvinceID(connection, cityChoiceBox.getValue());
        Integer roomNumber;
        String issue = issueTextField.getText();
        String details = detailsTextArea.getText();
        String status = statusChoiceBox.getValue();

        try
        {
            roomNumber = Integer.parseInt(roomNumberTextField.getText());
        }
        catch (NumberFormatException e)
        {
            warningMessageLabel.setText("Room number field only admits numeric values.");
            System.out.println(e.getMessage());
            throw  new RuntimeException(e);
        }

        if(reportDate == null || address == null || cityID == null || roomNumber == null
                || details == null || issue == null)
        {
            warningMessageLabel.setText("Empty fields left.");
            statusMessageLabel.setText("");
        }
        else
        {
            warningMessageLabel.setText("");

            if(currentlyInserting)
            {
                ReportQueries.insert(connection, new Report(reportDate.atStartOfDay(), userDni, roomNumber, address, cityID, issue, details, status));
                statusMessageLabel.setText("Report inserted.");
                currentlyInserting = false;
            }
            else if(currentlyUpdating)
            {
                Integer reportID = reportTableView.getSelectionModel().getSelectedItem().getReportID();

                ReportQueries.update(connection, new Report(reportID, reportDate.atStartOfDay(),
                        userDni, roomNumber, address, cityID, issue, details, status));
                statusMessageLabel.setText("Report updated.");
                currentlyUpdating = false;
            }

            activateDataFields(false);
            reportTableView.setItems(ReportQueries.selectAll(connection));
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
        reportTableView.setDisable(isActive);

        statusChoiceBox.setDisable(!isActive);
        cancelButton.setDisable(!isActive);
        confirmButton.setDisable(!isActive);

        reportDateDatePicker.setDisable(!currentlyInserting);
        userDniTextField.setDisable(!currentlyInserting);
        addressTextField.setDisable(!currentlyInserting);
        cityChoiceBox.setDisable(!currentlyInserting);
        roomNumberTextField.setDisable(!currentlyInserting);
        detailsTextArea.setDisable(!currentlyInserting);
        issueTextField.setDisable(!currentlyInserting);
    }

    private void reset()
    {
        reportDateDatePicker.setValue(null);
        userDniTextField.clear();
        addressTextField.clear();
        cityChoiceBox.setValue(null);
        roomNumberTextField.clear();
        issueTextField.clear();
        detailsTextArea.clear();
        statusChoiceBox.setValue(null);

        statusMessageLabel.setText("");
        warningMessageLabel.setText("");
        currentlyInserting = false;
        currentlyUpdating = false;
    }
}
