package com.example.ms_ubicaciones;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class MsUbicacionesApplication {



	public static void main(String[] args) {
    System.setProperty("TNS_ADMIN_PATH", "C:/Users/Usuario/Desktop/prueba3FullStrack/ms-proveedores/src/main/resources/Wallet");
    SpringApplication.run(MsUbicacionesApplication.class, args);
}

}
