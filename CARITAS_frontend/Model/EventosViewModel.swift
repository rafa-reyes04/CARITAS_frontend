//
//  EventosViewModel.swift
//  CARITAS_frontend
//
//  Created by Alumno on 20/09/24.
//


import Foundation

class EventosViewModel: ObservableObject {
    @Published var eventos: [Evento] = []

    init() {
        fetchEventos()
    }

    func fetchEventos() {
        guard let url = URL(string: "https://your-api-url.com/eventos") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
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
}
