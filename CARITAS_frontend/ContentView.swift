import SwiftUI

struct ContentView: View {
    @State var username: String = ""
    @State var password: String = ""
    
    var body: some View {
        ZStack {
            // Color de fondo que cubrirá toda la pantalla
            Color(red: 209/255, green: 224/255, blue: 215/255)
                .edgesIgnoringSafeArea(.all) // Asegura que el color cubra todo el fondo
            
            VStack {
                Spacer()
                
                // Logo de Cáritas
                Image("caritasLogo_login")
                    .resizable()
                    .scaledToFit() // Ajusta el tamaño de la imagen para que mantenga su proporción
                    .frame(width: 250, height: 100) // Ajusta el tamaño según sea necesario
                    .padding(.all, 20) // Espacio entre el logo y los campos de texto
                    .background(Color(red: 0/255, green: 156/255, blue: 166/255))
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                
                Spacer()
                
                // Campo de texto para el nombre de usuario
                TextField("Nombre de Usuario", text: $username)
                    .padding()
                    .background(Color.gray.opacity(0.2)) // Fondo gris similar al de la imagen
                    .cornerRadius(10)
                    .frame(width: 300) // Ajusta el ancho para que sea más grande
                    .padding(.bottom, 20) // Espacio entre los campos
                
                // Campo de texto para la contraseña
                SecureField("Contraseña", text: $password)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .frame(width: 300)
                    .padding(.bottom, 30) // Espacio entre la contraseña y el botón
                
                // Botón de Ingresar
                Button(action: {
                    // Acción de inicio de sesión
                }) {
                    Text("Entrar")
                        .frame(width: 200, height: 50) // Ajusta el tamaño del botón
                        .background(Color.orange)
                        .foregroundColor(.black)
                        .bold()
                        .cornerRadius(10)
                }
                
                Spacer()
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
