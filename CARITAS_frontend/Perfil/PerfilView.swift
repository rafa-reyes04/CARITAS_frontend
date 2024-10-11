import SwiftUI

struct PerfilView: View {
    @State var userID: String = ""
    @State var nombre: String = "Nombre Del Usuario"
    @State var peso: Double = 0.0
    @State var altura: Double = 0.0
    @State var presion: String = ""
    @State private var qrImage: UIImage? = nil
    @State private var isLoading: Bool = true // Controla si la vista está lista para mostrarse

    var body: some View {
        VStack {
            if isLoading {
                // Mostrar una vista de carga mientras se obtienen los datos del usuario
                ProgressView("Cargando datos del usuario...")
                    .font(.headline)
            } else {
                // Mostrar la vista del perfil solo cuando los datos hayan sido cargados
                SuperiorPerfilView(nombrePerfil: nombre)
                    .padding(.top, -160)
                    .padding(.bottom, 60)
                
                // Información del perfil
                VStack(alignment: .center, spacing: 0) {
                    InfoPerfilView(infoPerfil: "Usuario: \(nombre)", imagenInfoPerfil: "person.circle")
                    Spacer()
                    InfoPerfilView(infoPerfil: "Peso: \(String(format: "%.2f", peso)) kg", imagenInfoPerfil: "figure")
                    Spacer()
                    InfoPerfilView(infoPerfil: "Altura: \(String(format: "%.2f", altura)) m", imagenInfoPerfil: "figure.stand")
                    Spacer()
                    InfoPerfilView(infoPerfil: "Presión: \(presion) mmHg", imagenInfoPerfil: "waveform.path.ecg.rectangle")
                    Spacer()
                }

                Spacer()
                VStack {
                    Text("Código QR")
                        .font(.headline)
                    
                    if let qrImage = qrImage {
                        // Mostrar la imagen guardada o descargada
                        Image(uiImage: qrImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 180, height: 180)
                    } else {
                        // Mostrar indicador de carga mientras se descarga o carga la imagen
                        ProgressView()
                            .frame(width: 180, height: 180)
                    }
                }
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
            }
        }
        .onAppear {
            // Cargar los datos al aparecer la vista
            loadUserData()
        }
    }
    
    // Función para cargar los datos del usuario desde UserDefaults
    func loadUserData() {
        print("Intentando cargar los datos de usuario desde UserDefaults")
        
        if let savedUserData = UserDefaults.standard.data(forKey: "usuarioLogeado"),
           let savedUser = try? JSONDecoder().decode(Usuario.self, from: savedUserData) {
            
            print("Datos de usuario encontrados en UserDefaults: \(savedUser)")
            
            // Actualizamos las variables de estado en el hilo principal
            DispatchQueue.main.async {
                self.userID = String(savedUser.id)
                self.nombre = "\(savedUser.nombre) \(savedUser.aPaterno) \(savedUser.aMaterno)"
                self.peso = savedUser.peso
                self.altura = savedUser.altura
                self.presion = savedUser.presion

                print("Datos cargados en la vista: userID: \(self.userID), nombre: \(self.nombre), peso: \(self.peso), altura: \(self.altura), presion: \(self.presion)")
                
                // Una vez que los datos del usuario se han cargado, cargamos el código QR
                loadQRCode()
            }
        } else {
            print("No se encontraron datos de usuario en UserDefaults")
        }
    }
    
    func loadQRCode() {
        print("Intentando cargar el código QR para el usuario con ID: \(userID)")
        
        if let savedImage = loadImageFromDisk(named: "\(userID)_qrcode.png") {
            print("Código QR encontrado en disco para el usuario \(userID)")
            DispatchQueue.main.async {
                self.qrImage = savedImage
                // Al final de todo, se indica que los datos están listos
                self.isLoading = false
            }
        } else {
            print("No se encontró el código QR en disco, intentando descargarlo.")
            downloadQRCode()
        }
    }
    
    func downloadQRCode() {
        guard !userID.isEmpty else {
            print("El userID está vacío, no se puede descargar el código QR.")
            return
        }
        
        // URL del código QR con el userID dinámico
        let qrCodeURL = "https://api.qrserver.com/v1/create-qr-code/?size=180x180&data=\(userID)"
        guard let url = URL(string: qrCodeURL) else {
            print("URL del código QR no válida.")
            return
        }
        
        print("Descargando código QR desde: \(qrCodeURL)")
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error al descargar el código QR: \(error)")
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                print("No se pudo obtener la imagen del código QR")
                return
            }
            
            print("Código QR descargado exitosamente.")
            
            DispatchQueue.main.async {
                self.qrImage = image
                saveImageToDisk(image: image, named: "\(userID)_qrcode.png")
                print("Código QR guardado en disco para el usuario \(userID)")
                // Indicar que todo está listo para mostrar la vista
                self.isLoading = false
            }
        }.resume()
    }
    
    // Guardar imagen en disco
    func saveImageToDisk(image: UIImage, named: String) {
        guard let data = image.pngData() else { return }
        let fileManager = FileManager.default
        if let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = url.appendingPathComponent(named)
            do {
                try data.write(to: fileURL)
                print("Imagen guardada en: \(fileURL)")
            } catch {
                print("Error al guardar la imagen: \(error)")
            }
        }
    }
    
    // Cargar imagen desde disco
    func loadImageFromDisk(named: String) -> UIImage? {
        let fileManager = FileManager.default
        if let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = url.appendingPathComponent(named)
            if let imageData = try? Data(contentsOf: fileURL) {
                print("Imagen cargada desde: \(fileURL)")
                return UIImage(data: imageData)
            } else {
                print("No se encontró la imagen en: \(fileURL)")
            }
        }
        return nil
    }
}


#Preview {
    PerfilView()
}
