import Foundation


struct Reto: Codable, Identifiable {
    let id: Int
    let DESCRIPCION: String
    let NOMBRE: String
    let PUNTAJE: String

    enum CodingKeys: String, CodingKey {
        case DESCRIPCION
        case id = "ID_RETO" // Map ID_EVENTO to id
        case NOMBRE
        case PUNTAJE
    }
}
