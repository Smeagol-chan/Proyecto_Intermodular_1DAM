package org.example.demo.roomie.shared_usage.expections;

public class TenantContractInconsistencyException extends RuntimeException {
    public TenantContractInconsistencyException(String message) {
        super(message);
    }
}
