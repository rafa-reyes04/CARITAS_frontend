import SwiftUI

struct PerfilView: View {
    @State var userID: String = "123456789"
    @State var nombre: String = "Nombre Del Usuario"
    @State var peso: Float = 0.0
    @State var altura: Float = 0.0
    @State var presion: Int = 0
    @State private var qrImage: UIImage? = nil
    
    var body: some View {
        VStack {
            // Sección superior con el nombre y la imagen de perfil
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
            
            // Espacio para el código QR
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
                        .onAppear(perform: loadQRCode)
                }
            }
            Spacer()
            Spacer()
            Spacer()
        }
    }
    
    func loadQRCode() {
        // Obtener la ruta de la imagen guardada
        if let savedImage = loadImageFromDisk(named: "\(userID)_qrcode.png") {
            // Si la imagen está guardada, la cargamos
            qrImage = savedImage
        } else {
            // Si no está guardada, la descargamos y guardamos
            downloadQRCode()
        }
    }
    
    func downloadQRCode() {
        // URL del código QR con el userID dinámico
        let qrCodeURL = "https://api.qrserver.com/v1/create-qr-code/?size=180x180&data=\(userID)"
        guard let url = URL(string: qrCodeURL) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.qrImage = image
                    saveImageToDisk(image: image, named: "\(userID)_qrcode.png")
                }
            }
        }.resume()
    }
    
    // Guardar imagen en disco
    func saveImageToDisk(image: UIImage, named: String) {
        guard let data = image.pngData() else { return }
        let fileManager = FileManager.default
        if let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = url.appendingPathComponent(named)
            try? data.write(to: fileURL)
        }
    }
    
    // Cargar imagen desde disco
    func loadImageFromDisk(named: String) -> UIImage? {
        let fileManager = FileManager.default
        if let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = url.appendingPathComponent(named)
            if let imageData = try? Data(contentsOf: fileURL) {
                return UIImage(data: imageData)
            }
        }
        return nil
    }
}
#Preview {
    PerfilView()
}
