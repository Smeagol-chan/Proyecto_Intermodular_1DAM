package org.example.demo.objects.locations;

public class City
{
    private Integer cityId;
    private String cityName;
    private String provinceId;

    public City(Integer cityId, String cityName, String provinceId)
    {
        this.cityId = cityId;
        this.cityName = cityName;
        this.provinceId = provinceId;
    }

    public City(String cityName, String provinceId)
    {
        this(null, cityName, provinceId);
    }

    public Integer getCityId() {
        return cityId;
    }

    public String getCityName() {
        return cityName;
    }

    public String getProvinceId() {
        return provinceId;
    }
}
