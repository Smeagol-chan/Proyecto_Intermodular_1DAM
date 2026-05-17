package org.example.demo.objects.locations;

public class Institution
{
    private Integer institutionId;
    private String institutionName;
    private Integer cityId;

    public Institution(Integer institutionId, String institutionName, Integer cityId)
    {
        this.institutionId = institutionId;
        this.institutionName = institutionName;
        this.cityId = cityId;
    }

    public Institution(String institutionName, Integer cityId)
    {
        this(null, institutionName, cityId);
    }

    public Integer getInstitutionId() {
        return institutionId;
    }

    public String getInstitutionName() {
        return institutionName;
    }

    public int getCityId() {
        return cityId;
    }
}
