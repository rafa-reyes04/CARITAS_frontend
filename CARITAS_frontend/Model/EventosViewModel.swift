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
                        print("Decoded Data: \(decodedData)")  // Check the decoded data
                        self.eventos = decodedData["Eventos"] ?? []
                    }
                } catch {
                    print("Error decoding JSON: \(error)") // Check if there's a decoding error
                }
            }
        }.resume()
    }
}
