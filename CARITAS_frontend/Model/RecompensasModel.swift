//
//  RecompensasModel.swift
//  CARITAS_frontend
//
//  Created by MacBook Air on 09/10/24.
//

import Foundation

struct Recompensa: Codable, Identifiable {
    var id: Int
    var nombre: String
    var descripcion: String
    var costo: String
    var restantes: Int
    var comprado: Bool

    enum CodingKeys: String, CodingKey {
        case id = "ID_RECOMPENSA"
        case nombre = "NOMBRE"
        case descripcion = "DESCRIPCION"
        case costo = "COSTO"
        case restantes = "RESTANTES"
        case comprado = "COMPRADO"
    }
}

