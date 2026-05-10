package org.example.demo.objects.locations;

public class City
{
    private int cityId;
    private String cityName;
    private String provinceId;

    public City(int cityId, String cityName, String provinceId)
    {
        this.cityId = cityId;
        this.cityName = cityName;
        this.provinceId = provinceId;
    }

    public int getCityId() {
        return cityId;
    }

    public String getCityName() {
        return cityName;
    }

    public String getProvinceId() {
        return provinceId;
    }
}
