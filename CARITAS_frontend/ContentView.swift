import SwiftUI

struct ContentView: View {
    @State var username: String = ""
    @State var password: String = ""
    
    @State private var alerta = false
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
                            isLoggedIn = true
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
                    
                        .alert("Tienes que ingresar todos los datos", isPresented: $alerta) {
                            Button("Ok") {}
                        }
                }
                .padding()
                .navigationDestination(isPresented: $isLoggedIn) {
                    MainView() // Navega a MainView cuando isLoggedIn sea true
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
