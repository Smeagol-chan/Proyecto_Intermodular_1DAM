package org.example.demo.roomie.shared_usage.expections;

public class UnableToRemoveException extends RuntimeException {
    public UnableToRemoveException() {
        super("The item is not in the list.");
    }
}
