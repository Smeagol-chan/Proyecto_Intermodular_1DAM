package org.example.demo.objects.properties;

public class Furniture
{
    private int furnitureId;
    private String furnitureName;
    private String description;

    public Furniture(int furnitureId, String furnitureName, String description) {
        this.furnitureId = furnitureId;
        this.furnitureName = furnitureName;
        this.description = description;
    }

    public int getFurnitureId() {
        return furnitureId;
    }

    public String getFurnitureName() {
        return furnitureName;
    }

    public String getDescription() {
        return description;
    }
}
