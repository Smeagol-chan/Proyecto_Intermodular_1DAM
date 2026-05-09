package org.example.demo.roomie.locations;

public class City
{
    private int id;
    private String name;
    private SpainProvince province;

    public City(int id, String name, String provinceName)
    {
        this.id = id;
        this.name = name;
        province = SpainProvince.getIdByName(provinceName);
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

    public void setProvince(SpainProvince province) {
        this.province = province;
    }
}
