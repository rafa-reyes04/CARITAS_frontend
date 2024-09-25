import Foundation

class EventosViewModel: ObservableObject {
    @Published var eventos: [Evento] = []
    @Published var eventosRegistrados: [Evento] = [] // Lista para los eventos del usuario

    init() {
        fetchEventos()
    }

    func fetchEventos() {
        guard let url = URL(string: "http://127.0.0.1:3000/events") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode([String: [Evento]].self, from: data)
                    DispatchQueue.main.async {
                        self.eventos = decodedData["Eventos"] ?? []
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
    }

    // Función para obtener eventos registrados por el usuario
    func fetchEventosRegistrados(for usuarioId: Int) {
        let urlString = "http://127.0.0.1:3000/\(usuarioId)/mis-eventos"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching user events: \(error)")
                return
            }

            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode([String: [Evento]].self, from: data)
                    DispatchQueue.main.async {
                        self.eventosRegistrados = decodedData["Eventos"] ?? []
                    }
                } catch {
                    print("Error decoding JSON for user events: \(error)")
                }
            }
        }.resume()
    }
}
