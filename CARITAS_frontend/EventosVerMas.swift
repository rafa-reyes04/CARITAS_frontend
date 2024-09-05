import SwiftUI

////////////////////////////////////////////////////
//           Código Generado por Copilot          //
//                 Pendiente Revisar              //
////////////////////////////////////////////////////

// Extensión para inicializar colores a partir de valores hexadecimales
extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex) // Crea un escáner para analizar la cadena hexadecimal
        scanner.currentIndex = scanner.string.index(after: scanner.string.startIndex) // Ajusta el índice para omitir el primer carácter (#)
        
        var rgbValue: UInt64 = 0 // Declara una variable para almacenar el valor RGB
        scanner.scanHexInt64(&rgbValue) // Analiza la cadena hexadecimal y almacena el valor en rgbValue
        
        // Extrae el componente rojo del valor RGB
        let red = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        // Extrae el componente verde del valor RGB
        let green = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        // Extrae el componente azul del valor RGB
        let blue = Double(rgbValue & 0x0000FF) / 255.0
        
        // Inicializa el color con los componentes rojo, verde y azul
        self.init(red: red, green: green, blue: blue)
    }
}

struct ContentView: View {
    @State private var fecha: String = "" // Variable de estado para almacenar la fecha
    @State private var hora: String = "" // Variable de estado para almacenar la hora
    @State private var cupo: String = "" // Variable de estado para almacenar el cupo
    @State private var puntos: String = "" // Variable de estado para almacenar los puntos
    @State private var descripcion: String = "" // Variable de estado para almacenar la descripción
    @State private var isRegistered: Bool = false // Variable de estado para controlar si está registrado

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                backButton // Botón de regreso
                    .padding(.top, 20)
                
                Spacer().frame(height: 77) // Espacio para posicionar el título
                
                Text("Título")
                    .font(.custom("Lato", size: 30)) // Establece la fuente y el tamaño del texto
                    .foregroundColor(Color(hex: "#3D3F40")) // Establece el color del texto
                    .frame(width: 301, height: 74, alignment: .leading) // Establece el tamaño y la alineación del texto
                    .padding(.leading, 34)
                
                Spacer().frame(height: 20) // Espacio para posicionar la imagen
                
                AsyncImage(url: URL(string: "https://example.com/image.jpg")) { image in
                    image
                        .resizable()
                        .frame(width: 300, height: 133) // Establece el tamaño de la imagen
                        .cornerRadius(33.33) // Establece el radio de las esquinas
                        .position(x: 38 + 150, y: 17 + 66.5) // Ajuste de posición
                } placeholder: {
                    ProgressView() // Muestra un indicador de progreso mientras se carga la imagen
                }
                .frame(width: 300, height: 133)
                
                Spacer().frame(height: 20) // Espacio para posicionar los textos
                
                HStack {
                    Text("Fecha")
                        .font(.custom("Lato", size: 16.67))
                        .foregroundColor(Color(hex: "#3D3F40"))
                        .frame(width: 48, height: 20, alignment: .center)
                        .position(x: 49 + 24, y: 338 + 10) // Ajuste de posición
                    
                    Spacer().frame(width: 82) // Espacio entre los textos
                    
                    Text("Hora")
                        .font(.custom("Lato", size: 16.67))
                        .foregroundColor(Color(hex: "#3D3F40"))
                        .frame(width: 37, height: 20, alignment: .center)
                        .position(x: 169 + 18.5, y: 338 + 10) // Ajuste de posición
                    
                    Spacer().frame(width: 77) // Espacio entre los textos
                    
                    Text("Cupo")
                        .font(.custom("Lato", size: 16.67))
                        .foregroundColor(Color(hex: "#3D3F40"))
                        .frame(width: 39, height: 20, alignment: .center)
                        .position(x: 283 + 19.5, y: 338 + 10) // Ajuste de posición
                }
                
                Spacer().frame(height: 20) // Espacio para posicionar los datos de la API
                
                HStack {
                    Text(fecha)
                        .font(.custom("Lato", size: 12))
                        .foregroundColor(Color(hex: "#3D3F40"))
                        .frame(width: 48, height: 20, alignment: .center)
                        .position(x: 35 + 24, y: 365 + 10) // Ajuste de posición
                    
                    Spacer().frame(width: 82) // Espacio entre los textos
                    
                    Text(hora)
                        .font(.custom("Lato", size: 12))
                        .foregroundColor(Color(hex: "#3D3F40"))
                        .frame(width: 37, height: 20, alignment: .center)
                        .position(x: 151 + 18.5, y: 365 + 10) // Ajuste de posición
                    
                    Spacer().frame(width: 77) // Espacio entre los textos
                    
                    Text(cupo)
                        .font(.custom("Lato", size: 12))
                        .foregroundColor(Color(hex: "#3D3F40"))
                        .frame(width: 39, height: 20, alignment: .center)
                        .position(x: 273 + 19.5, y: 365 + 10) // Ajuste de posición
                }
                
                Spacer().frame(height: 20) // Espacio para posicionar el texto "Registrado"
                
                if isRegistered {
                    Text("Registrado")
                        .font(.custom("Oswald", size: 23.33))
                        .foregroundColor(Color(hex: "#5AB159"))
                        .position(x: 119 + 19.5, y: 401 + 10) // Ajuste de posición
                }
                
                Spacer().frame(height: 20) // Espacio para posicionar el texto "Puntos"
                
                Text("Puntos")
                    .font(.custom("Lato", size: 13.33))
                    .foregroundColor(Color(hex: "#003B5C"))
                    .position(x: 293 + 19.5, y: 415 + 10) // Ajuste de posición
                
                Text(puntos)
                    .font(.custom("Lato", size: 16.67))
                    .foregroundColor(Color(hex: "#003B5C"))
                    .frame(width: 50, height: 20, alignment: .trailing)
                    .position(x: 301 + 25, y: 436 + 10) // Ajuste de posición
                
                Spacer().frame(height: 20) // Espacio para posicionar el subtítulo "Descripción"
                
                Text("Descripción")
                    .font(.custom("Lato", size: 23.33))
                    .foregroundColor(Color(hex: "#3D3F40"))
                    .position(x: 35 + 19.5, y: 45 + 10) // Ajuste de posición
                
                Text(descripcion)
                    .font(.custom("Lato", size: 11.5))
                    .foregroundColor(Color(hex: "#3D3F40"))
                    .frame(width: 298, height: 167, alignment: .leading)
                    .padding(.leading, 35)
                    .padding(.top, 10)
                
                Spacer().frame(height: 20) // Espacio para posicionar los botones
                
                if isRegistered {
                    Button(action: {
                        // Acción para interactuar con la API cuando isRegistered es verdadero
                    }) {
                        Text("Botón 1")
                            .font(.custom("Source Sans Pro", size: 27))
                            .foregroundColor(.black)
                            .frame(width: 300, height: 52)
                            .background(Color(hex: "#FF7375"))
                            .cornerRadius(33.33)
                            .position(x: 38 + 150, y: 67 + 26)
                    }
                } else {
                    Button(action: {
                        // Acción para interactuar con la API cuando isRegistered es falso
                    }) {
                        Text("Botón 2")
                            .font(.custom("Source Sans Pro", size: 27))
                            .foregroundColor(.black)
                            .frame(width: 300, height: 52)
                            .background(Color(hex: "#00CF46"))
                            .cornerRadius(33.33)
                            .position(x: 38 + 150, y: 67 + 26)
                    }
                }
                
                Spacer() // Espacio adicional si es necesario
            }
            .background(Color(hex: "#D1E0D7").ignoresSafeArea())
            .navigationBarHidden(true)
            .onAppear {
                fetchData() // Llama a la función para obtener datos de la API cuando la vista aparece
            }
        }
    }
    
    var backButton: some View {
        Button(action: {
            // Acción para regresar a la vista anterior
            // Aquí puedes agregar la lógica para navegar hacia atrás
        }) {
            Text("Back")
                .foregroundColor(.white) // Color del texto del botón
                .padding() // Espaciado interno del botón
                .background(Color(hex: "#2000AD")) // Color de fondo del botón
                .cornerRadius(8) // Bordes redondeados del botón
        }
        .padding(.leading, 34) // Espaciado a la izquierda del botón
    }
    
    func fetchData() {
        // Reemplaza con la URL de tu API
        guard let url = URL(string: "https://example.com/api/data") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            
            do {
                let result = try JSONDecoder().decode(APIResponse.self, from: data)
                DispatchQueue.main.async {
                    self.fecha = result.fecha
                    self.hora = result.hora
                    self.cupo = result.cupo
                    self.puntos = result.puntos // Actualiza el estado con el valor de la API
                    self.descripcion = result.descripcion // Actualiza el estado con el valor de la API
                    self.isRegistered = result.isRegistered // Actualiza el estado según el valor de la API
                }
            } catch {
                print("Error al decodificar los datos: \(error)")
            }
        }.resume()
    }
}

struct APIResponse: Codable {
    let fecha: String
    let hora: String
    let cupo: String
    let puntos: String // Agrega esta propiedad para el valor de puntos
    let descripcion: String // Agrega esta propiedad para la descripción
    let isRegistered: Bool // Agrega esta propiedad para el condicional
}
