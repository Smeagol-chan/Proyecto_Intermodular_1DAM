package org.example.demo.roomie.paperwork;

import org.example.demo.roomie.properties.Room;
import org.example.demo.roomie.users.Tenant;

import java.time.LocalDate;

public class Contract
{
    private LocalDate signatureDate;
    private Tenant tenant;
    private Room room;
    private double price;
    private LocalDate startingDate;
    private LocalDate endingDate;
    private String status;
}
