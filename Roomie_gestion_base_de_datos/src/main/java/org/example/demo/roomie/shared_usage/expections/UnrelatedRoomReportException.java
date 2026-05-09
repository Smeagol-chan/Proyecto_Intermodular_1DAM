package org.example.demo.roomie.shared_usage.expections;

public class UnrelatedRoomReportException extends RuntimeException {
    public UnrelatedRoomReportException() {
        super("The user has no relation with this room.");
    }
}
