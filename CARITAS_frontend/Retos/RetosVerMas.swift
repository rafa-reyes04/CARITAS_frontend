import SwiftUI

struct DetalleReto: View {
    let retoData: Reto
    @ObservedObject var usuario: UserViewModel // Relacionamos con el usuario
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
                    retoHeader
                    retoImage
                    HStack{
                        descriptionSection
                        retoDetails
                    }
                    Spacer()
                    actionButton
                    Spacer()
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
                // Llamar al endpoint para verificar si está registrado
                verificarRegistroReto(idUsuario: usuario.id, idReto: retoData.id)
                
            }
        }
    }
    
    private var retoHeader: some View {
        ZStack{
            
            Rectangle()
                .fill(Color(red: 0/255, green: 156/255, blue: 166/255))
                .frame(height: 200)
                .cornerRadius(30)
            
            Text(retoData.NOMBRE)
                .multilineTextAlignment(.center)
                .padding(.top, 80)
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(Color(hex: "#FFFFFF"))
            
        } .edgesIgnoringSafeArea(.top)
            .padding(.bottom, -80)
            
        
    }
    
    private var retoImage: some View {
        HStack(alignment: .center) {
            Image("Reto-Icono")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 370, height: 230)
                .clipShape(RoundedRectangle(cornerRadius: 30))
        }.padding(.leading, 40)
        .padding(.trailing, 40)
    }
    
    private var retoDetails: some View {
        VStack {
            HStack {
                DetailItemReto(title: "Puntos", value: retoData.PUNTAJE)
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
            
            Text(retoData.DESCRIPCION)
                .font(.custom("Lato-Regular", size: 18))
                .foregroundColor(Color(hex: "#3D3F40"))
            
        }
        .padding(.leading, 50)

    }
    
    private var actionButton: some View {
        VStack {
            if registered {
                // Botón para eliminar el registro si el usuario ya está registrado
                Button(action: {
                    eliminarRegistroReto(idUsuario: usuario.id, idReto: retoData.id)
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
                    registrarReto(idUsuario: usuario.id, idReto: retoData.id)
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
    private func verificarRegistroReto(idUsuario: Int, idReto: Int) {
        guard let url = URL(string: "https://realmadswift.tc2007b.tec.mx:10206/verificar_reto") else {
            print("URL inválida")
            return
        }

        // Crear el cuerpo de la solicitud
        let body: [String: Any] = [
            "id_usuario": idUsuario,
            "id_reto": idReto
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
    private func eliminarRegistroReto(idUsuario: Int, idReto: Int) {
        guard let url = URL(string: "https://realmadswift.tc2007b.tec.mx:10206/cancelar_reto") else {
            print("URL inválida")
            return
        }

        // Crear el cuerpo de la solicitud
        let body: [String: Any] = [
            "id_usuario": idUsuario,
            "id_reto": idReto
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
                        self.alertMessage = "Te has dado de baja del reto."
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
    private func registrarReto(idUsuario: Int, idReto: Int) {
        guard let url = URL(string: "https://realmadswift.tc2007b.tec.mx:10206/registrar_reto") else {
            print("URL inválida")
            return
        }

        // Crear el cuerpo de la solicitud
        let body: [String: Any] = [
            "id_usuario": idUsuario,
            "id_reto": idReto
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
                        self.alertMessage = "Te has registrado exitosamente en el reto."
                        self.showingAlert = true
                    }
                } else if httpResponse.statusCode == 400 {
                    // No hay cupo disponible
                    DispatchQueue.main.async {
                        self.alertMessage = "No hay cupo disponible para este reto."
                        self.showingAlert = true
                    }
                } else {
                    // Otro error
                    DispatchQueue.main.async {
                        self.alertMessage = "Ocurrió un error al registrarte en el reto."
                        self.showingAlert = true
                    }
                }
            }
        }.resume()
    }
}

struct DetailItemReto: View {
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
    DetalleReto(retoData: Reto(
        id: 1,
        DESCRIPCION: "Correr para mejorar la salud",
        NOMBRE: "Correr 2 km",
        PUNTAJE: "10"
    ), usuario: UserViewModel())
}
