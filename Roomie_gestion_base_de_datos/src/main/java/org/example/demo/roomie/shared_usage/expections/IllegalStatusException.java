package org.example.demo.roomie.shared_usage.expections;

public class IllegalStatusException extends RuntimeException {
    public IllegalStatusException() {
        super("Invalid status.");
    }
}
