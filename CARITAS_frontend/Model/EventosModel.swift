import Foundation

// Model for a single Event
struct Evento: Codable, Identifiable {
    var id = UUID() // Unique identifier for SwiftUI
    let CUPO: String
    let DESCRIPCION: String
    let FECHA: String
    let HORA: String
    let ID_EVENTO: Int
    let PUNTOS: String
    let TIPO_EVENTO: String
    let TITULO: String
}
