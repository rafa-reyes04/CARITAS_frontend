import SwiftUI

struct DetalleEvento: View {
    let eventData: Evento
    let usuario: Usuario? // Relacionamos con el usuario
    @State private var registered: Bool = false
    @State private var imagenEvento: String = ""
    
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
                }
                .onAppear { // Espera un closure sin parámetros
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
        VStack() {
            HStack {
                DetailItem(title: "Fecha", value: eventData.FECHA)
                Spacer()
                DetailItem(title: "Hora", value: eventData.HORA)
                Spacer()
                DetailItem(title: "Cupo", value: eventData.CUPO)
            }
            HStack() {
                Text(registered ? "Registrado" : "")
                    .font(.custom("Avenir-Heavy", size: 30))
                    .foregroundColor(Color(hex: "#5AB159"))
                    .padding(.leading, 50)
                Spacer()
                DetailItem(title: "Puntos", value: eventData.PUNTOS)
            }.padding(.top, 20)
        }
        .onAppear {
            // Set the image based on the event type
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
        }.padding(.leading, 40)
        .padding(.trailing, 40)
    }
    
    private var actionButton: some View {
        Button(action: {
            // Acción del botón
            
            registered.toggle()
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
