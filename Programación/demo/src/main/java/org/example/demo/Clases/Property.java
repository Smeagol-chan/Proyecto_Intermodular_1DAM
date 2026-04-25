package org.example.demo.Clases;

public class Property {
    private String address;
    private String ownerDni;
    private String status;
    private double surface;

    public Property(String address, Owner owner, String status, double surface) {
        this.address = address;
        this.ownerDni = owner.getDni();
        this.status = status;
        this.surface = surface;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getOwnerDni() {
        return ownerDni;
    }

    public void setOwnerDni(String ownerDni) {
        this.ownerDni = ownerDni;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public double getSurface() {
        return surface;
    }

    public void setSurface(double surface) {
        this.surface = surface;
    }

    @Override
    public String toString() {
        return "Property{" +
                "address='" + address + '\'' +
                ", ownerDni='" + ownerDni + '\'' +
                ", status='" + status + '\'' +
                ", surface=" + surface +
                '}';
    }
}
