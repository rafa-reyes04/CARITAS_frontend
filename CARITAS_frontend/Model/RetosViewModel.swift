import Foundation

class RetosViewModel: ObservableObject {
    @Published var retos: [Reto] = []
    @Published var retosRegistrados: [Reto] = [] // Lista para los retos del usuario

    // Función combinada que hace ambas llamadas secuenciales
    func fetchAllRetos(for usuarioId: Int) async {
        // Llamada para obtener los eventos del usuario
        await fetchRetosRegistrados(for: usuarioId)
        
        // Llamada para obtener todos los eventos
        await fetchRetos(for: usuarioId)
    }

    // Función que obtiene los eventos registrados por el usuario
    private func fetchRetosRegistrados(for usuarioId: Int) async {
        let urlString = "https://realmadswift.tc2007b.tec.mx:10206/\(usuarioId)/mis-retos"
        guard let url = URL(string: urlString) else { return }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedData = try JSONDecoder().decode([String: [Reto]].self, from: data)
            DispatchQueue.main.async {
                self.retosRegistrados = decodedData["Retos"] ?? []
            }
        } catch {
            print("Error fetching user retos: \(error)")
        }
    }

    // Función que obtiene todos los eventos disponibles
    private func fetchRetos(for usuarioId: Int) async {
        guard let url = URL(string: "https://realmadswift.tc2007b.tec.mx:10206/\(usuarioId)/retos") else { return }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedData = try JSONDecoder().decode([String: [Reto]].self, from: data)
            DispatchQueue.main.async {
                self.retos = decodedData["Retos"] ?? []
            }
        } catch {
            print("Error fetching retos: \(error)")
        }
    }
}

