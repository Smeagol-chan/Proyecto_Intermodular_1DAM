package org.example.demo.objects.locations;

public class Institution
{
    private int institutionId;
    private String institutionName;
    private int cityId;

    public Institution(int institutionId, String institutionName, int cityId) {
        this.institutionId = institutionId;
        this.institutionName = institutionName;
        this.cityId = cityId;
    }

    public int getInstitutionId() {
        return institutionId;
    }

    public String getInstitutionName() {
        return institutionName;
    }

    public int getCityId() {
        return cityId;
    }
}
