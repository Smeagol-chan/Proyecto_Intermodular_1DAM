package org.example.demo.roomie.locations;

import java.util.Objects;

public class City
{
    private int id;
    private String name;
    private SpainProvince province;

    public City(int id, String name, String provinceName)
    {
        this.id = id;
        this.name = name;
        setProvince(provinceName);
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public SpainProvince getProvince() {
        return province;
    }

    public void setProvince(String provinceName)
    {
        province = SpainProvince.getProvinceByName(provinceName);
    }

    @Override
    public boolean equals(Object o) {
        if (o == null || getClass() != o.getClass()) return false;
        City city = (City) o;
        return id == city.id;
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(id);
    }
}
