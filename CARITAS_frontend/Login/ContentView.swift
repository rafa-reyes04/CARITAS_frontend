import SwiftUI

struct ContentView: View {
    @State var username: String = ""
    @State var password: String = ""
    
    @State private var alerta = false
    @State private var alerta2 = false

    @State private var isLoggedIn = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Color de fondo que cubrirá toda la pantalla
                Color(red: 209/255, green: 224/255, blue: 215/255)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    
                    // Logo de Cáritas
                    Image("caritasLogo_login")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 100)
                        .padding(.all, 20)
                        .background(Color(red: 0/255, green: 156/255, blue: 166/255))
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                    
                    Spacer()
                    
                    // Campo de texto para el nombre de usuario
                    TextField("Nombre de Usuario", text: $username)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        .frame(width: 300)
                        .padding(.bottom, 20)
                    
                    // Campo de texto para la contraseña
                    SecureField("Contraseña", text: $password)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        .frame(width: 300)
                        .padding(.bottom, 30)
                    
                    // Botón de Ingresar
                    Button(action: {
                        if username.isEmpty || password.isEmpty {
                            alerta.toggle()
                        } else {
                            loginUser(username: username, password: password)
                        }
                    }) {
                        Text("Entrar")
                            .frame(width: 300, height: 50)
                            .background(Color(red: 0/255, green: 59/255, blue: 92/255))
                            .foregroundColor(.white)
                            .bold()
                            .cornerRadius(10)
                    }
                    
                    Spacer()
                    Spacer()
                }
                .padding()
                .alert("Tienes que ingresar todos los datos", isPresented: $alerta) {
                    Button("Ok") {}
                }
                .alert("Datos incorrectos", isPresented: $alerta2) {
                    Button("Ok") {}
                }
                .navigationDestination(isPresented: $isLoggedIn) {
                    MainView() // Navega a MainView cuando isLoggedIn sea true
                }
            }
        }
    }
    
    // Función para realizar la solicitud de login
    func loginUser(username: String, password: String) {
        // Reseteamos los datos del usuario
        UserDefaults.standard.removeObject(forKey: "usuarioLogeado")
        
        guard let url = URL(string: "http://127.0.0.1:3000/login") else { return }
        
        // Crear el cuerpo de la solicitud con el usuario y la contraseña
        let body: [String: String] = ["usuario": username, "contrasena": password]
        
        // Convertir el cuerpo a JSON
        let jsonData = try? JSONSerialization.data(withJSONObject: body)
        
        // Configurar la solicitud
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        // Realizar la solicitud
        URLSession.shared.dataTask(with: request) { data, response, error in
            // Verificar si hubo error
            guard let data = data, error == nil else {
                print("Error en la solicitud: \(String(describing: error))")
                return
            }
            
            // Procesar la respuesta
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    do {
                        // Decodificar la respuesta JSON
                        if let jsonResponse = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                           let userData = jsonResponse["user"] as? [String: Any] {
                            
                            // Crear instancia del usuario desde los datos de la respuesta
                            let usuario = Usuario(
                                id: userData["ID_USUARIO"] as? Int ?? 0,
                                nombre: userData["NOMBRE"] as? String ?? "",
                                aPaterno: userData["A_PATERNO"] as? String ?? "",
                                aMaterno: userData["A_MATERNO"] as? String ?? "",
                                peso: userData["PESO"] as? Float ?? 0.0,
                                altura: userData["ALTURA"] as? Float ?? 0.0,
                                presion: userData["PRESION"] as? String ?? "",
                                puntaje: Int(userData["PUNTAJE"] as? String ?? "0") ?? 0,
                                usuario: userData["USUARIO"] as? String ?? ""
                            )
                            
                            // Guardar la información del usuario en UserDefaults
                            if let encodedUser = try? JSONEncoder().encode(usuario) {
                                UserDefaults.standard.set(encodedUser, forKey: "usuarioLogeado")
                                
                                // Imprimir los valores para validar que se guardaron correctamente
                                print("Usuario guardado correctamente en UserDefaults.")
                                if let savedUserData = UserDefaults.standard.data(forKey: "usuarioLogeado"),
                                   let savedUser = try? JSONDecoder().decode(Usuario.self, from: savedUserData) {
                                    print("Datos del usuario guardados:")
                                    print("ID: \(savedUser.id)")
                                    print("Nombre: \(savedUser.nombre)")
                                    print("Apellido Paterno: \(savedUser.aPaterno)")
                                    print("Apellido Materno: \(savedUser.aMaterno)")
                                    print("Peso: \(savedUser.peso)")
                                    print("Altura: \(savedUser.altura)")
                                    print("Presión: \(savedUser.presion)")
                                    print("Puntaje: \(savedUser.puntaje)")
                                    print("Usuario: \(savedUser.usuario)")
                                }
                            }
                            
                            // Cambiar el estado para navegar a MainView
                            DispatchQueue.main.async {
                                isLoggedIn = true
                            }
                        }
                    } catch {
                        print("Error al procesar la respuesta JSON: \(error)")
                    }
                } else {
                    DispatchQueue.main.async {
                        alerta2.toggle() // Error de credenciales
                    }
                }
            }
        }.resume()
    }
}

#Preview {
    ContentView()
}
