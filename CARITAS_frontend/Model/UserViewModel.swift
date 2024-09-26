//
//  UserData.swift
//  CARITAS_frontend
//
//  Created by Alumno on 23/09/24.
//
import SwiftUI
import Combine

class UserViewModel: ObservableObject {
    @Published var id: Int = 0
    @Published var nombre: String = ""
    @Published var peso: Float = 0.0
    @Published var altura: Float = 0.0
    @Published var presion: String = ""
    @Published var puntaje: Int = 0
    @Published var aMaterno: String = ""
    @Published var aPaterno: String = ""
    @Published var usuario: String = ""

    init() {
        loadUser()
    }

    func loadUser() { // Lo uso en los onAppears
        // Attempt to retrieve and decode user data from UserDefaults
        if let savedUserData = UserDefaults.standard.data(forKey: "usuarioLogeado"),
           let savedUser = try? JSONDecoder().decode(Usuario.self, from: savedUserData) {
            
            print("Datos de usuario encontrados en UserDefaults: \(savedUser)")
            
            // Update the published properties
            DispatchQueue.main.async {
                self.id = savedUser.id
                self.nombre = "\(savedUser.nombre) \(savedUser.aPaterno) \(savedUser.aMaterno)"
                self.peso = savedUser.peso
                self.altura = savedUser.altura
                self.presion = savedUser.presion
                self.puntaje = savedUser.puntaje
                self.usuario = savedUser.usuario
                self.aMaterno = savedUser.aMaterno
                self.aPaterno = savedUser.aPaterno

                print("Datos cargados en la vista: userID: \(self.id), nombre: \(self.nombre), peso: \(self.peso), altura: \(self.altura), presion: \(self.presion), presion: \(self.puntaje), Usuario: \(self.usuario), ApellidoM: \(self.aMaterno), ApellidoP: \(self.aPaterno)")
            }
        } else {
            print("No se encontraron datos de usuario en UserDefaults")
        }
    }
}
