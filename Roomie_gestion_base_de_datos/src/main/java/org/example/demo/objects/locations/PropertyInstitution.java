package org.example.demo.objects.locations;

public class PropertyInstitution
{
    private Integer institutionID;
    private String propertyAddress;
    private Integer propertyCityID;

    public PropertyInstitution(Integer institutionID, String propertyAddress, Integer propertyCityID) {
        this.institutionID = institutionID;
        this.propertyAddress = propertyAddress;
        this.propertyCityID = propertyCityID;
    }

    public Integer getInstitutionID() {
        return institutionID;
    }

    public String getPropertyAddress() {
        return propertyAddress;
    }

    public Integer getPropertyCityID() {
        return propertyCityID;
    }
}
