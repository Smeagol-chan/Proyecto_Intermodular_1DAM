package org.example.demo.objects.locations;

public class Province
{
    private String provinceId;
    private String provinceName;

    public Province(String provinceId, String provinceName) {
        this.provinceId = provinceId;
        this.provinceName = provinceName;
    }

    public String getProvinceId() {
        return provinceId;
    }

    public String getProvinceName() {
        return provinceName;
    }
}
