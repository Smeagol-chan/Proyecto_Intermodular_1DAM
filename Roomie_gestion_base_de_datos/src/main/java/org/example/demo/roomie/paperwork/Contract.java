package org.example.demo.roomie.paperwork;

import org.example.demo.roomie.properties.Room;
import org.example.demo.roomie.shared_usage.expections.IllegalStatusException;
import org.example.demo.roomie.users.Tenant;

import java.time.LocalDate;
import java.util.Arrays;
import java.util.Objects;

public class Contract
{
    private static final String DEFAULT_STATUS = "Ongoing";
    private static final String[] STATUS_PERMITTED = {"Ongoing", "Ended"};

    private LocalDate signatureDate;
    private Tenant tenant;
    private Room room;
    private double price;
    private LocalDate startingDate;
    private LocalDate endingDate;
    private String status;

    public Contract(LocalDate signatureDate, Tenant tenant, Room room, double price, LocalDate startingDate, LocalDate endingDate, String status)
    {
        this.signatureDate = signatureDate;
        this.tenant = tenant;
        this.room = room;
        this.price = price;
        this.startingDate = startingDate;
        this.endingDate = endingDate;
        setStatus(status);
    }

    public Contract(LocalDate signatureDate, Tenant tenant, Room room, double price, LocalDate startingDate, LocalDate endingDate)
    {
        this(signatureDate, tenant, room, price, startingDate, endingDate, DEFAULT_STATUS);
    }

    public LocalDate getSignatureDate() {
        return signatureDate;
    }

    public Tenant getTenant() {
        return tenant;
    }

    public Room getRoom() {
        return room;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
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

    public void setStatus(String status)
    {
        if(Arrays.asList(STATUS_PERMITTED).contains(status)) this.status = status;
        else throw new IllegalStatusException();
    }

    @Override
    public boolean equals(Object o) {
        if (o == null || getClass() != o.getClass()) return false;
        Contract contract = (Contract) o;
        return Objects.equals(signatureDate, contract.signatureDate) && Objects.equals(tenant, contract.tenant) && Objects.equals(room, contract.room);
    }

    @Override
    public int hashCode() {
        return Objects.hash(signatureDate, tenant, room);
    }
}
