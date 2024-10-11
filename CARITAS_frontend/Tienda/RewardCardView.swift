import SwiftUI

struct RewardCardView: View {
    var title: String
    var subtitle: String
    var stock: String? = nil
    var comprado: Bool
    var idRecompensa: Int
    var idUsuario: Int
    @Binding var recompensas: [Recompensa] // Binding para actualizar las recompensas
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var onCompraExitosa: () -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Spacer()
                
                Text(title)
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundColor(.black)
                
                if let stock = stock {
                    Text(stock)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                Text(subtitle)
                    .font(.headline)
                    .foregroundColor(.gray)
                
                Spacer()
            }
            
            Spacer()
            
            Button(action: {
                comprarRecompensa()
            }) {
                Image(systemName: "dollarsign")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
            }
            .frame(width: 85.0, height: 130.0)
            .background(comprado ? Color.gray : Color.blue)
            .clipShape(Rectangle())
            .cornerRadius(10)
            .disabled(comprado) // Desactivar el botón si ya está comprado
        }
        .padding()
        .frame(width: 350, height: 150)
        .background(Color(UIColor.systemGray6))
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Resultado de la compra"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    // Función para realizar la compra
    private func comprarRecompensa() {
        guard let url = URL(string: "https://realmadswift.tc2007b.tec.mx:10206/comprar") else { return }

        let body: [String: Any] = ["id_usuario": idUsuario, "id_recompensa": idRecompensa]
        guard let jsonData = try? JSONSerialization.data(withJSONObject: body) else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    alertMessage = "Error: \(error.localizedDescription)"
                    showAlert = true
                }
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                DispatchQueue.main.async {
                    switch httpResponse.statusCode {
                    case 200:
                        alertMessage = "Compra realizada con éxito"
                        // Actualizar la recompensa como comprada
                        if let index = recompensas.firstIndex(where: { $0.id == idRecompensa }) {
                            recompensas[index].comprado = true
                            recompensas[index].restantes -= 1 // Actualiza las recompensas restantes
                            
                            onCompraExitosa()

                        }
                    case 400:
                        if let data = data, let responseString = String(data: data, encoding: .utf8) {
                            if responseString.contains("No tienes suficientes monedas") {
                                alertMessage = "No tienes suficientes monedas"
                            } else if responseString.contains("No quedan recompensas disponibles") {
                                alertMessage = "No quedan recompensas disponibles"
                            } else if responseString.contains("Ya has comprado esta recompensa") {
                                alertMessage = "Ya has comprado esta recompensa"
                            } else {
                                alertMessage = "Error desconocido"
                            }
                        }
                    default:
                        alertMessage = "Error en la compra"
                    }
                    showAlert = true
                }
            }
        }
        task.resume()
    }
}


#Preview {
    // Crear un array de recompensas simuladas con @State
    @State var recompensas = [
        Recompensa(id: 1, nombre: "Acceso VIP", descripcion: "Lo que sea", costo: "200", restantes: 10, comprado: false)
    ]
    
    RewardCardView(
        title: "Acceso VIP",
        subtitle: "200 puntos",
        stock: "10",
        comprado: false,
        idRecompensa: 3,
        idUsuario: 1,
        recompensas: $recompensas,
        onCompraExitosa: {
            // Aquí puedes poner un código de prueba si lo necesitas
            print("Compra exitosa (solo preview)")
        }
    )
}

