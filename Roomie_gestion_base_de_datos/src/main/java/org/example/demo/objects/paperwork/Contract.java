package org.example.demo.objects.paperwork;

import java.time.LocalDate;

public class Contract
{
    private LocalDate signatureDate;
    private String tenantDni;
    private int roomNumber;
    private String propertyAddress;
    private double pricePerMonth;
    private LocalDate startingDate;
    private LocalDate endingDate;
    private String status;

    public Contract(LocalDate signatureDate, String tenantDni, int roomNumber, String propertyAddress, double pricePerMonth, LocalDate startingDate, LocalDate endingDate, String status) {
        this.signatureDate = signatureDate;
        this.tenantDni = tenantDni;
        this.roomNumber = roomNumber;
        this.propertyAddress = propertyAddress;
        this.pricePerMonth = pricePerMonth;
        this.startingDate = startingDate;
        this.endingDate = endingDate;
        this.status = status;
    }

    public LocalDate getSignatureDate() {
        return signatureDate;
    }

    public String getTenantDni() {
        return tenantDni;
    }

    public int getRoomNumber() {
        return roomNumber;
    }

    public String getPropertyAddress() {
        return propertyAddress;
    }

    public double getPricePerMonth() {
        return pricePerMonth;
    }

    public LocalDate getStartingDate() {
        return startingDate;
    }

    public LocalDate getEndingDate() {
        return endingDate;
    }

    public String getStatus() {
        return status;
    }
}
