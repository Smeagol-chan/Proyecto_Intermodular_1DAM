package org.example.demo.Clases;

import java.time.LocalDate;

public class Contract {

    private LocalDate signatureDate;
    private String tenantDni;
    private int roomNumber;
    private String propertyAddress;
    private double pricePerMonth;
    private LocalDate startingDate;
    private LocalDate endingDate;
    private String status;

    public Contract(LocalDate signatureDate, Tenant tenant, Room room, Property property, double pricePerMonth, LocalDate startingDate, LocalDate endingDate, String status) {
        this.signatureDate = signatureDate;
        this.tenantDni = tenant.getDni();
        this.roomNumber = room.getRoomNumber();
        this.propertyAddress = property.getAddress();
        this.pricePerMonth = pricePerMonth;
        this.startingDate = startingDate;
        this.endingDate = endingDate;
        this.status = status;
    }

    public LocalDate getSignatureDate() {
        return signatureDate;
    }

    public void setSignatureDate(LocalDate signatureDate) {
        this.signatureDate = signatureDate;
    }

    public String getTenantDni() {
        return tenantDni;
    }

    public void setTenantDni(String tenantDni) {
        this.tenantDni = tenantDni;
    }

    public int getRoomNumber() {
        return roomNumber;
    }

    public void setRoomNumber(int roomNumber) {
        this.roomNumber = roomNumber;
    }

    public String getPropertyAddress() {
        return propertyAddress;
    }

    public void setPropertyAddress(String propertyAddress) {
        this.propertyAddress = propertyAddress;
    }

    public double getPricePerMonth() {
        return pricePerMonth;
    }

    public void setPricePerMonth(double pricePerMonth) {
        this.pricePerMonth = pricePerMonth;
    }

    public LocalDate getStartingDate() {
        return startingDate;
    }

    public void setStartingDate(LocalDate startingDate) {
        this.startingDate = startingDate;
    }

    public LocalDate getEndingDate() {
        return endingDate;
    }

    public void setEndingDate(LocalDate endingDate) {
        this.endingDate = endingDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Contract{" +
                "signatureDate=" + signatureDate +
                ", tenantDni='" + tenantDni + '\'' +
                ", roomNumber=" + roomNumber +
                ", propertyAddress='" + propertyAddress + '\'' +
                ", pricePerMonth=" + pricePerMonth +
                ", startingDate=" + startingDate +
                ", endingDate=" + endingDate +
                ", status='" + status + '\'' +
                '}';
    }
}
