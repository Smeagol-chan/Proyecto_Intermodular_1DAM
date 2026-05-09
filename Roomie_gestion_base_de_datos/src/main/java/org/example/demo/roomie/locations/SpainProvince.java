package org.example.demo.roomie.locations;

import org.example.demo.roomie.shared_usage.expections.IllegalProvinceNameException;

public enum SpainProvince
{
    VI("Ávala"),
    AB("Albacete"),
    A("Alicante"),
    AL("Almería"),
    O("Asturias"),
    AV("Ávila"),
    BA("Badajoz"),
    B("Barcelona"),
    BU("Burgos"),
    CA("Cádiz"),
    S("Cantabria"),
    CC("Cáceres"),
    CS("Castellón"),
    CE("Ceuta"),
    CR("Ciudad Real"),
    CO("Córdoba"),
    C("La Coruña"),
    CU("Cuenca"),
    GC("Las Palmas de Gran Canaria"),
    GI("Girona"),
    GR("Granada"),
    GU("Guadalajara"),
    SS("Guipúzcua"),
    H("Huelva"),
    IB("Islas Baleares"),
    J("Jaén"),
    LE("León"),
    L("Lérida"),
    LO("La Rioja"),
    LU("Lugo"),
    M("Madrid"),
    MA("Málaga"),
    ML("Melilla"),
    MU("Murcia"),
    NA("Navarra"),
    OU("Ourense"),
    P("Palencia"),
    PO("Pontevedra"),
    SA("Salamanca"),
    SG("Segovia"),
    SE("Sevilla"),
    SO("Soria"),
    T("Tarragona"),
    TF("Santa Cruz de Tenerife"),
    TE("Teruel"),
    TO("Toledo"),
    V("Valencia"),
    VA("Valladolid"),
    BI("Vizcaya"),
    ZA("Zamora"),
    Z("Zaragoza");

    private final String provinceName;

    SpainProvince(String provinceName)
    {
        this.provinceName = provinceName;
    }

    public String getProvinceName() {
        return provinceName;
    }

    public static SpainProvince getProvinceByName(String name)
    {
        for(SpainProvince province : values())
            if(province.getProvinceName().equals(name))
                return province;

        throw new IllegalProvinceNameException();
    }
}
