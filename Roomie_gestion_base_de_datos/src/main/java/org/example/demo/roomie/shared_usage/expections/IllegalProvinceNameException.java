package org.example.demo.roomie.shared_usage.expections;

public class IllegalProvinceNameException extends RuntimeException {
    public IllegalProvinceNameException() {
        super("The province does not exists.");
    }
}
