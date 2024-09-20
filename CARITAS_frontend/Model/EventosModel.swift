import Foundation

// Model for a single Event
struct Evento: Codable, Identifiable {
    let id: Int // Use ID_EVENTO as the unique identifier
    let CUPO: String
    let DESCRIPCION: String
    let FECHA: String
    let HORA: String
    let PUNTOS: String
    let TIPO_EVENTO: String
    let TITULO: String

    // Coding keys to map JSON fields to struct properties
    enum CodingKeys: String, CodingKey {
        case CUPO
        case DESCRIPCION
        case FECHA
        case HORA
        case PUNTOS
        case TIPO_EVENTO
        case TITULO
        case id = "ID_EVENTO" // Map ID_EVENTO to id
    }
}
