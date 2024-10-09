//
//  RecompensasViewModel.swift
//  CARITAS_frontend
//
//  Created by MacBook Air on 09/10/24.
//


import Foundation

class RecompensasViewModel: ObservableObject {
    @Published var recompensas: [Recompensa] = []

    // Función que hace un POST para obtener las recompensas del usuario
    func fetchRecompensas(for usuarioId: Int) async {
        guard let url = URL(string: "https://realmadswift.tc2007b.tec.mx:10206/recompensas") else { return }

        // Crear el cuerpo de la petición con el id_usuario
        let body: [String: Any] = ["id_usuario": usuarioId]
        
        // Convertir el cuerpo en JSON data
        guard let jsonData = try? JSONSerialization.data(withJSONObject: body) else {
            print("Error al crear el cuerpo de la petición")
            return
        }

        // Crear la solicitud de tipo POST
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        do {
            // Hacer la solicitud POST
            let (data, response) = try await URLSession.shared.data(for: request)

            // Verificar el código de respuesta HTTP
            if let httpResponse = response as? HTTPURLResponse {
                print("Código de estado HTTP: \(httpResponse.statusCode)")
            }

            // Imprimir el contenido de la respuesta para ver si es válida
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Datos de la respuesta: \(jsonString)")
            }

            // Decodificar los datos JSON si todo está correcto
            let decodedData = try JSONDecoder().decode([String: [Recompensa]].self, from: data)
            DispatchQueue.main.async {
                self.recompensas = decodedData["Recompensas"] ?? []
            }
        } catch {
            print("Error al obtener las recompensas: \(error)")
        }
    }
}


