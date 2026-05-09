package org.example.demo.roomie.properties;

import java.util.Objects;

public class Furniture
{
    private String name;
    private FurnitureCategory category;

    public Furniture(String name, FurnitureCategory category)
    {
        this.name = name;
        this.category = category;
    }

    public String getName() {
        return name;
    }

    public FurnitureCategory getCategory() {
        return category;
    }

    @Override
    public boolean equals(Object o) {
        if (o == null || getClass() != o.getClass()) return false;
        Furniture furniture = (Furniture) o;
        return Objects.equals(name, furniture.name) && Objects.equals(category, furniture.category);
    }

    @Override
    public int hashCode() {
        return Objects.hash(name, category);
    }
}
