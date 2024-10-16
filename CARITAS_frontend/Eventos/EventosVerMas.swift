import SwiftUI

struct DetalleEvento: View {
    let eventData: Evento
    @ObservedObject var usuario: UserViewModel
    @State private var registered: Bool = false
    @State private var imagenEvento: String = ""
    @State private var showingAlert: Bool = false
    @State private var alertMessage: String = ""
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(hex: "#FFFFF").ignoresSafeArea()
                
                VStack(alignment: .leading, spacing: 20) {
                    eventHeader
                    eventImage
                    eventDetails
                    descriptionSection
                    Spacer()
                    actionButton
                    Spacer()
                }
                .padding(.leading, 20)
                .padding(.trailing, 20)
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Registro"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                    Text("Atrás")
                        .foregroundColor(.white)
                        .fontWeight(.bold)                }
            })
            .onAppear {
                verificarRegistro(idUsuario: usuario.id, idEvento: eventData.id)
            }
        }
    }
    
    private var eventHeader: some View {
        ZStack{ 
            
            Rectangle()
                .fill(Color(red: 0/255, green: 156/255, blue: 166/255))
                .frame(height: 200)
                .cornerRadius(30)
            
            Text(eventData.TITULO)
                .multilineTextAlignment(.center)
                .padding(.top, 80)
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(Color(hex: "#FFFFFF"))
            
        } .edgesIgnoringSafeArea(.top)
            .padding(.bottom, -80)
            
        
    }
    
    private var eventImage: some View {
        HStack(alignment: .center) {
            Image(imagenEvento)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 370, height: 230)
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
                Spacer()
                DetailItem(title: "Puntos", value: eventData.PUNTOS)
            }
        }
        .onAppear {
            if eventData.TIPO_EVENTO == "Nutrición" {
                imagenEvento = "Nutricion-Detalle"
            } else if eventData.TIPO_EVENTO == "Conferencia" {
                imagenEvento = "Conferencia-Detalle"
            } else if eventData.TIPO_EVENTO == "Revisión" {
                imagenEvento = "Revision-Detalle"
            } else if eventData.TIPO_EVENTO == "Ejercicio" {
                imagenEvento = "Ejercicio-Detalle"
            }
        }
        .padding(.leading, 40)
        .padding(.trailing, 40)
        .padding(.bottom, 20)
        .padding(.top, 10)
    }
    
    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Descripción")
                .font(.system(size: 24))
                .foregroundColor(Color(hex: "#3D3F40"))
                .fontWeight(.semibold)
            
            Text(eventData.DESCRIPCION)
                .font(.custom("Lato-Regular", size: 18))
                .foregroundColor(Color(hex: "#3D3F40"))
            
        }
        .padding(.leading, 50)
        .padding(.trailing, 50)
    }
    
    private var actionButton: some View {
        VStack {
            if registered {
                // Botón para eliminar el registro si el usuario ya está registrado
                Button(action: {
                    eliminarRegistro(idUsuario: usuario.id, idEvento: eventData.id)
                }) {
                    Text("Cancelar Registro")
                        .font(.custom("SourceSansPro-Bold", size: 30))
                        .foregroundColor(.white)
                        .frame(maxWidth: 380)
                        .padding()
                        .background(Color(hex: "#FF7375")) // Botón rojo para eliminar
                        .cornerRadius(25)
                }
            } else {
                // Botón para registrarse si el usuario no está registrado
                Button(action: {
                    registrarEvento(idUsuario: usuario.id, idEvento: eventData.id)
                }) {
                    Text("Registrarse")
                        .font(.custom("SourceSansPro-Bold", size: 30))
                        .foregroundColor(.white)
                        .frame(maxWidth: 380)
                        .padding()
                        .background(Color(hex: "#008F46")) // Botón verde para registrarse
                        .cornerRadius(25)
                }
            }
        }
        .padding(.leading, 40)
        .padding(.trailing, 40)
    }
    
    // Función para verificar si el usuario está registrado
    private func verificarRegistro(idUsuario: Int, idEvento: Int) {
        guard let url = URL(string: "https://realmadswift.tc2007b.tec.mx:10206/verificar_registro") else {
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
                print("Error al verificar registro: \(error)")
                return
            }
            
            // Procesar la respuesta
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode([String: Bool].self, from: data)
                    DispatchQueue.main.async {
                        // Actualizar el estado de 'registered' con el valor retornado por el servidor
                        if let isRegistered = decodedResponse["exists"] {
                            self.registered = isRegistered
                        }
                    }
                } catch {
                    print("Error al decodificar JSON: \(error)")
                }
            }
        }.resume()
    }
    
    //Funcion eliminar registro
    private func eliminarRegistro(idUsuario: Int, idEvento: Int) {
        guard let url = URL(string: "https://realmadswift.tc2007b.tec.mx:10206/cancelar_registro") else {
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
        request.httpMethod = "DELETE"  // Usamos POST porque así está implementado en el servidor
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        // Hacer la solicitud
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error al eliminar registro: \(error)")
                return
            }
            
            // Verificar el código de respuesta
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    // Eliminación exitosa
                    DispatchQueue.main.async {
                        self.registered = false
                        self.alertMessage = "Te has dado de baja del evento."
                        self.showingAlert = true
                    }
                } else {
                    // Manejo de errores
                    DispatchQueue.main.async {
                        self.alertMessage = "Ocurrió un error al eliminar el registro."
                        self.showingAlert = true
                    }
                }
            }
        }.resume()
    }
    
    // Función para registrar al usuario en el evento
    private func registrarEvento(idUsuario: Int, idEvento: Int) {
        guard let url = URL(string: "https://realmadswift.tc2007b.tec.mx:10206/registrar_evento") else {
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
                .fontWeight(.semibold)
                .foregroundColor(Color(hex: "#3D3F40"))
                .font(.system(size: 22))
                .padding(.bottom, 3)
            
            Text(value)
                .font(.custom("Lato-Regular", size: 18))
                .foregroundColor(Color(hex: "#3D3F40"))
        }.padding(.leading, 5)
        .padding(.trailing, 5)
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
        TIPO_EVENTO: "Revisión",
        TITULO: "Taller de Nutrición"
    ), usuario: UserViewModel())
}
