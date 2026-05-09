package org.example.demo.roomie.expections;

public class IllegalProvinceNameException extends RuntimeException {
    public IllegalProvinceNameException() {
        super("The province does not exists.");
    }
}
