//
//  UsuarioModel.swift
//  CARITAS_frontend
//
//  Created by MacBook Air on 17/09/24.
//

import Foundation

struct Usuario: Codable {
    var id: Int
    var nombre: String
    var aPaterno: String
    var aMaterno: String
    var peso: Double
    var altura: Double
    var presion: String
    var puntaje: Int
    var usuario: String
}
