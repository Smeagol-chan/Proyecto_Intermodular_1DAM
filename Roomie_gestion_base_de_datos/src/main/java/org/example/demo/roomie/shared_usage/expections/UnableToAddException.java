package org.example.demo.roomie.shared_usage.expections;

public class UnableToAddException extends RuntimeException {
    public UnableToAddException() {
        super("The item is already in the list.");
    }
}
