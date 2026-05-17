package org.example.demo.objects.properties;

import org.example.demo.queries.FurnitureQueries;

public class Furniture
{
    private Integer furnitureId;
    private String furnitureName;
    private String description;

    public Furniture(Integer furnitureId, String furnitureName, String description) {
        this.furnitureId = furnitureId;
        this.furnitureName = furnitureName;
        this.description = description;
    }

    public Furniture(String furnitureName, String description)
    {
        this(null, furnitureName, description);
    }

    public Integer getFurnitureId() {
        return furnitureId;
    }

    public String getFurnitureName() {
        return furnitureName;
    }

    public String getDescription() {
        return description;
    }
}
