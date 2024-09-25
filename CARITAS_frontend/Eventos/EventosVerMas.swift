import SwiftUI

struct DetalleEvento: View {
    let eventData: Evento
    let usuario: Usuario? // Relacionamos con el usuario
    @State private var registered: Bool = false
    @State private var imagenEvento: String = ""
    @State private var showingAlert: Bool = false
    @State private var alertMessage: String = ""
    
    var body: some View {
        if let usuario = usuario {
            NavigationView {
                ZStack {
                    Color(hex: "#D1E0D7").ignoresSafeArea()
                    
                    VStack(alignment: .leading, spacing: 20) {
                        eventHeader
                        eventImage
                        eventDetails
                        descriptionSection
                        actionButton
                    }
                    .padding()
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("Registro"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                    }
                }
                .onAppear {
                    verificarRegistro(idUsuario: usuario.id, tituloEvento: eventData.TITULO) { isRegistered in
                        DispatchQueue.main.async {
                            registered = isRegistered
                        }
                    }
                }
            }
        }
    }
    
    private var eventHeader: some View {
        Text(eventData.TITULO)
            .padding(.leading, 30)
            .padding(.top, 20)
            .font(.custom("Lato-Bold", size: 30))
            .foregroundColor(Color(hex: "#3D3F40"))
    }
    
    private var eventImage: some View {
        HStack(alignment: .center) {
            Image(imagenEvento)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 320, height: 150)
                .clipShape(RoundedRectangle(cornerRadius: 30))
        }.padding(.leading, 40)
        .padding(.trailing, 40)
    }
    
    private var eventDetails: some View {
        VStack {
            HStack {
                DetailItem(title: "Fecha", value: eventData.FECHA)
                Spacer()
                DetailItem(title: "Hora", value: eventData.HORA)
                Spacer()
                DetailItem(title: "Cupo", value: eventData.CUPO)
            }
            HStack {
                Text(registered ? "Registrado" : "")
                    .font(.custom("Avenir-Heavy", size: 30))
                    .foregroundColor(Color(hex: "#5AB159"))
                    .padding(.leading, 50)
                Spacer()
                DetailItem(title: "Puntos", value: eventData.PUNTOS)
            }.padding(.top, 20)
        }
        .onAppear {
            if eventData.TIPO_EVENTO == "Nutrición" {
                imagenEvento = "imagenNutricion"
            } else if eventData.TIPO_EVENTO == "Conferencia" {
                imagenEvento = "imagenConferencia"
            } else if eventData.TIPO_EVENTO == "Revisión" {
                imagenEvento = "imagenRevision"
            } else if eventData.TIPO_EVENTO == "Ejercicio" {
                imagenEvento = "imagenEjercicio"
            }
        }
        .padding(.leading, 40)
        .padding(.trailing, 40)
    }
    
    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Descripción")
                .font(.custom("Lato-Bold", size: 25))
                .foregroundColor(Color(hex: "#3D3F40"))
                .bold()
            
            Text(eventData.DESCRIPCION)
                .font(.custom("Lato-Regular", size: 16))
                .foregroundColor(Color(hex: "#3D3F40"))
        }
        .padding(.leading, 40)
        .padding(.trailing, 40)
    }
    
    private var actionButton: some View {
        Button(action: {
            if !registered {
                // Llamada para registrarse al evento
                registrarEvento(idUsuario: usuario!.id, idEvento: eventData.id)
            } else {
                // Aquí puedes manejar la cancelación del registro si lo deseas
            }
        }) {
            Text(registered ? "Cancelar Registro" : "Registrarse")
                .font(.custom("SourceSansPro-Bold", size: 30))
                .foregroundColor(.white)
                .frame(maxWidth: 300)
                .padding()
                .background(registered ? Color(hex: "#FF7375") : Color(hex: "#00CF46"))
                .cornerRadius(25)
        }
        .padding(.leading, 40)
        .padding(.trailing, 40)
    }
    
    // Función para registrar al usuario en el evento
    private func registrarEvento(idUsuario: Int, idEvento: Int) {
        guard let url = URL(string: "http://127.0.0.1:3000/registrar_evento") else {
            print("URL inválida")
            return
        }

        // Crear el cuerpo de la solicitud
        let body: [String: Any] = [
            "id_usuario": idUsuario,
            "id_evento": idEvento
        ]
        
        // Convertir el body a JSON
        let jsonData = try? JSONSerialization.data(withJSONObject: body)
        
        // Configurar la solicitud
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        // Hacer la solicitud
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error al registrar: \(error)")
                return
            }
            
            // Verificar el código de respuesta
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 201 {
                    // Registro exitoso
                    DispatchQueue.main.async {
                        self.registered = true
                        self.alertMessage = "Te has registrado exitosamente en el evento."
                        self.showingAlert = true
                    }
                } else if httpResponse.statusCode == 400 {
                    // No hay cupo disponible
                    DispatchQueue.main.async {
                        self.alertMessage = "No hay cupo disponible para este evento."
                        self.showingAlert = true
                    }
                } else {
                    // Otro error
                    DispatchQueue.main.async {
                        self.alertMessage = "Ocurrió un error al registrarte en el evento."
                        self.showingAlert = true
                    }
                }
            }
        }.resume()
    }
}

struct DetailItem: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.custom("Lato-Bold", size: 20))
                .foregroundColor(Color(hex: "#3D3F40"))
            Text(value)
                .font(.custom("Lato-Regular", size: 16))
                .foregroundColor(Color(hex: "#3D3F40"))
        }
    }
}

#Preview {
    DetalleEvento(eventData: Evento(
        id: 1,
        CUPO: "50",
        DESCRIPCION: "Aprender sobre nutrición saludable.",
        FECHA: "2024-10-05",
        HORA: "10:00:00",
        PUNTOS: "10",
        TIPO_EVENTO: "Ejercicio",
        TITULO: "Taller de Nutrición"
    ), usuario: Usuario(
        id: 100,
        nombre: "Lucy",
        aPaterno: "Fer",
        aMaterno: "Asmodeus",
        peso: 616.616,
        altura: 616.616,
        presion: "616/616",
        puntaje: 616,
        usuario: "616"
    ))
}
