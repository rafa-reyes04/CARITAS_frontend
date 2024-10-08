import Foundation

class RetosViewModel: ObservableObject {
    @Published var retos: [Reto] = []
    @Published var retosRegistrados: [Reto] = [] // Lista para los retos del usuario

    // Función combinada que hace ambas llamadas secuenciales
    func fetchAllRetos(for usuarioId: Int) async {
        // Llamada para obtener los eventos del usuario
        await fetchRetosRegistrados(for: usuarioId)
        
        // Llamada para obtener todos los eventos
        await fetchRetos()
    }

    // Función que obtiene los eventos registrados por el usuario
    private func fetchRetosRegistrados(for usuarioId: Int) async {
        let urlString = "http://127.0.0.1:3000/\(usuarioId)/mis-retos"
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
    private func fetchRetos() async {
        guard let url = URL(string: "http://127.0.0.1:3000/retos") else { return }

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

