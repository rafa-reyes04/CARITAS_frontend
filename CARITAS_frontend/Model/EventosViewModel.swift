import Foundation

class EventosViewModel: ObservableObject {
    @Published var eventos: [Evento] = []
    @Published var eventosRegistrados: [Evento] = [] // Lista para los eventos del usuario

    // Función combinada que hace ambas llamadas secuenciales
    func fetchAllEventos(for usuarioId: Int) async {
        // Llamada para obtener los eventos del usuario
        await fetchEventosRegistrados(for: usuarioId)
        
        // Llamada para obtener todos los eventos
        await fetchEventos()
    }

    // Función que obtiene los eventos registrados por el usuario
    private func fetchEventosRegistrados(for usuarioId: Int) async {
        let urlString = "http://127.0.0.1:3000/\(usuarioId)/mis-eventos"
        guard let url = URL(string: urlString) else { return }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedData = try JSONDecoder().decode([String: [Evento]].self, from: data)
            DispatchQueue.main.async {
                self.eventosRegistrados = decodedData["Eventos"] ?? []
            }
        } catch {
            print("Error fetching user events: \(error)")
        }
    }

    // Función que obtiene todos los eventos disponibles
    private func fetchEventos() async {
        guard let url = URL(string: "http://127.0.0.1:3000/events") else { return }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedData = try JSONDecoder().decode([String: [Evento]].self, from: data)
            DispatchQueue.main.async {
                self.eventos = decodedData["Eventos"] ?? []
            }
        } catch {
            print("Error fetching events: \(error)")
        }
    }
}
