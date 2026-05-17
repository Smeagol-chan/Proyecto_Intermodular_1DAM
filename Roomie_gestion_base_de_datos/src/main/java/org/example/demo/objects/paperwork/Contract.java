package org.example.demo.objects.paperwork;

import java.time.LocalDate;

public class Contract
{
    private Integer contractID;
    private LocalDate signatureDate;
    private String tenantDni;
    private Integer roomNumber;
    private String propertyAddress;
    private Integer propertyCityId;
    private Double pricePerMonth;
    private LocalDate startingDate;
    private LocalDate endingDate;
    private String status;

    public Contract(Integer contractID, LocalDate signatureDate, String tenantDni, Integer roomNumber, String propertyAddress
            , Integer propertyCityId, Double pricePerMonth, LocalDate startingDate, LocalDate endingDate, String status)
    {
        this.contractID = contractID;
        this.signatureDate = signatureDate;
        this.tenantDni = tenantDni;
        this.roomNumber = roomNumber;
        this.propertyAddress = propertyAddress;
        this.propertyCityId = propertyCityId;
        this.pricePerMonth = pricePerMonth;
        this.startingDate = startingDate;
        this.endingDate = endingDate;
        this.status = status;
    }

    public Contract(LocalDate signatureDate, String tenantDni, Integer roomNumber, String propertyAddress
            , Integer propertyCityId, Double pricePerMonth, LocalDate startingDate, LocalDate endingDate, String status)
    {
        this(null, signatureDate, tenantDni, roomNumber, propertyAddress, propertyCityId, pricePerMonth, startingDate, endingDate, status);
    }

    public Integer getPropertyCityId() {
        return propertyCityId;
    }

    public LocalDate getSignatureDate() {
        return signatureDate;
    }

    public String getTenantDni() {
        return tenantDni;
    }

    public Integer getRoomNumber() {
        return roomNumber;
    }

    public String getPropertyAddress() {
        return propertyAddress;
    }

    public Integer getContractID() {
        return contractID;
    }

    public Double getPricePerMonth() {
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
