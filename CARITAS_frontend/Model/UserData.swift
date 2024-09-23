//
//  UserData.swift
//  CARITAS_frontend
//
//  Created by Alumno on 23/09/24.
//

import SwiftUI

func loadUser() -> Usuario? {
    print("Intentando cargar los datos de usuario desde UserDefaults")
    
    guard let savedUserData = UserDefaults.standard.data(forKey: "usuarioLogeado") else {
        print("No se encontraron datos para la clave 'usuarioLogeado' en UserDefaults")
        return nil
    }
    
    print("Datos encontrados en UserDefaults: \(savedUserData)")
    
    do {
        let savedUser = try JSONDecoder().decode(Usuario?.self, from: savedUserData)
        print("Datos de usuario decodificados correctamente: \(savedUser)")
        return savedUser
    } catch {
        print("Error al decodificar los datos del usuario: \(error)")
        return nil
    }
}
