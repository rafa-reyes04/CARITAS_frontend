import SwiftUI

struct TiendaView: View {
    @StateObject private var viewModel = RecompensasViewModel()
    @State private var puntosDisponibles: Int = 0
    @State private var usuarioId: Int = 0

    var body: some View {
        VStack {
            // Header con título y puntos del usuario
            HStack {
                Text("Tienda")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding([.leading, .bottom, .trailing])

                Spacer()
                HStack {
                    Image(systemName: "star.fill")
                        .font(.title2)
                        .foregroundColor(.yellow)

                    Text("\(puntosDisponibles)")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                .padding([.leading, .bottom, .trailing])
            }
            .padding([.horizontal, .top], 16)
            .background(Color(red: 0/255, green: 156/255, blue: 166/255))

            // Scroll de recompensas
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(viewModel.recompensas, id: \.nombre) { recompensa in
                        RewardCardView(
                            title: recompensa.nombre,
                            subtitle: "\(recompensa.costo) puntos",
                            stock: "\(recompensa.restantes) disponibles",
                            comprado: recompensa.comprado,
                            idRecompensa: recompensa.id,
                            idUsuario: usuarioId,
                            recompensas: $viewModel.recompensas,
                            onCompraExitosa: { actualizarPuntosUsuario() }
                        )
                    }
                }
                .padding(.horizontal, 16)
            }
            .padding(.top)
        }
        .onAppear {
            cargarUsuarioDesdeUserDefaults()
            actualizarPuntosUsuario()
            
            Task {
                await viewModel.fetchRecompensas(for: usuarioId)
            }
        }
    }
    
    // Función para obtener los puntos del usuario desde la API
    private func actualizarPuntosUsuario() {
        guard let url = URL(string: "https://realmadswift.tc2007b.tec.mx:10206/puntos-user") else { return }

        // Crear el cuerpo del request con el ID del usuario
        let body: [String: Any] = ["id_usuario": usuarioId]
        guard let jsonData = try? JSONSerialization.data(withJSONObject: body) else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        // Realizar la solicitud a la API
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error al actualizar puntos: \(error.localizedDescription)")
                return
            }

            if let data = data, let httpResponse = response as? HTTPURLResponse {
                print("Código de estado HTTP: \(httpResponse.statusCode)")
                
                // Verifica que la respuesta HTTP sea 200 (éxito)
                if httpResponse.statusCode == 200 {
                    // Imprime los datos de la respuesta como cadena (para depuración)
                    if let responseData = String(data: data, encoding: .utf8) {
                        print("Datos de la respuesta: \(responseData)")
                    }
                    
                    do {
                        // Intenta convertir los datos de la respuesta a JSON
                        if let jsonResponse = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                            print("JSON Response: \(jsonResponse)") // Para verificar la estructura del JSON
                            
                            // Extraer el valor de "puntos" como cadena y convertirlo a Int
                            if let puntosString = jsonResponse["puntos"] as? String,
                               let puntos = Int(puntosString) {
                                DispatchQueue.main.async {
                                    print("Puntos obtenidos: \(puntos)")
                                    puntosDisponibles = puntos
                                                                    }
                            } else {
                                print("El campo 'puntos' no se pudo convertir a Int")
                            }
                        } else {
                            print("Error: La respuesta no es un JSON válido")
                        }
                    } catch {
                        print("Error al convertir los datos a JSON: \(error.localizedDescription)")
                    }
                } else {
                    print("Error al actualizar puntos: Código de estado \(httpResponse.statusCode)")
                }
            }
        }
        
        // Iniciar la tarea de red
        task.resume()
    }

    // Función para cargar el usuario desde UserDefaults
    func cargarUsuarioDesdeUserDefaults() {
        if let savedUserData = UserDefaults.standard.data(forKey: "usuarioLogeado"),
           let savedUser = try? JSONDecoder().decode(Usuario.self, from: savedUserData) {
            self.usuarioId = savedUser.id
            print("Usuario cargado: \(savedUser.nombre) con ID: \(savedUser.id)")
        } else {
            print("No se encontró un usuario guardado.")
        }
    }
}


#Preview {
    TiendaView()
}
