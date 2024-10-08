import Foundation

struct Evento: Codable, Identifiable {
    let id: Int
    let CUPO: String
    let DESCRIPCION: String
    let FECHA: String
    let HORA: String
    let PUNTOS: String
    let TIPO_EVENTO: String
    let TITULO: String

    enum CodingKeys: String, CodingKey {
        case CUPO
        case DESCRIPCION
        case FECHA
        case HORA
        case PUNTOS
        case TIPO_EVENTO
        case TITULO
        case id = "ID_EVENTO" 
    }
}
