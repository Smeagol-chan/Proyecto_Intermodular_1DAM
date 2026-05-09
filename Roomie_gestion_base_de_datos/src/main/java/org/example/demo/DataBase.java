package org.example.demo;

import java.sql.*;

public class DataBase
{
    public static Connection conexion()
    {
        Connection conexion;
        // Estructura: jdbc:sqlserver://[serverName][\instanceName][:portNumber];databaseName=[dbName]
        String host = "jdbc:sqlserver://localhost:1433;";
        String bd = "databaseName=ROOMIE;";
        String user = "sa"; // Usuario típico de SQL Server
        String psw = "roomie1234"; // SQL Server REQUIERE contraseña

        // Parámetros extra para evitar errores de certificados SSL en conexiones locales
        String seguridad = "encrypt=false;trustServerCertificate=true;";

        System.out.println("Conectando a SQL Server...");

        try
        {
            // En SQL Server, se suele concatenar todo en la URL
            conexion = DriverManager.getConnection(host + bd + seguridad, user, psw);
            System.out.println("Conexión realizada con éxito a SQL Server.");
        }
        catch (SQLException e)
        {
            System.out.println("Error de conexión: " + e.getMessage());
            throw new RuntimeException(e);
        }
        return conexion;
    }
}
