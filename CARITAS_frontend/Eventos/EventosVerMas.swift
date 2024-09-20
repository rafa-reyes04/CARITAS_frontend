import SwiftUI

struct DetalleEvento: View {
    let eventData: EventData
    
    var body: some View {
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
        }
    }
    
    private var eventHeader: some View {
        Text(eventData.title)
            .padding(.leading, 30)
            .padding(.top, 20)
            .font(.custom("Lato-Bold", size: 30))
            .foregroundColor(Color(hex: "#3D3F40"))
    }
    
    private var eventImage: some View {
        HStack(alignment: .center) {
            AsyncImage(url: URL(string: eventData.imageUrl)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                case .failure:
                    Image(systemName: "photo")
                        .foregroundColor(.gray)
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: 320, height: 150)
            .clipShape(RoundedRectangle(cornerRadius: 30))
        }.padding(.leading, 40)
        .padding(.trailing, 40)
    }
    
    private var eventDetails: some View {
        VStack() {
            HStack {
                DetailItem(title: "Fecha", value: eventData.fecha)
                Spacer()
                DetailItem(title: "Hora", value: eventData.hora)
                Spacer()
                DetailItem(title: "Cupo", value: eventData.cupo)
            }
            HStack() {
                Text(eventData.isRegistered ? "Registrado" : "")
                    .font(.custom("Avenir-Heavy", size: 30))
                    .foregroundColor(Color(hex: "#5AB159"))
                    .padding(.leading, 50)
                Spacer()
                DetailItem(title: "Puntos", value: eventData.puntos)
            }.padding(.top, 20)
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
            
            Text(eventData.descripcion)
                .font(.custom("Lato-Regular", size: 16))
                .foregroundColor(Color(hex: "#3D3F40"))
        }.padding(.leading, 40)
        .padding(.trailing, 40)
    }
    
    private var actionButton: some View {
        Button(action: {
            // Acción del botón
        }) {
            Text(eventData.isRegistered ? "Cancelar Registro" : "Registrarse")
                .font(.custom("SourceSansPro-Bold", size: 30))
                .foregroundColor(.white)
                .frame(maxWidth: 300)
                .padding()
                .background(eventData.isRegistered ? Color(hex: "#FF7375") : Color(hex: "#00CF46"))
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

extension EventData {
    static let ejemplo = EventData(
        title: "Evento Ejemplo",
        imageUrl: "https://caritasdeleon.org/wp-content/uploads/2023/06/Caritas-Diocesna-Leon-grupo-900x280.jpg",
        fecha: "15/10/2024",
        hora: "14:00",
        cupo: "50/100",
        puntos: "500",
        descripcion: "Este es un evento de ejemplo con una descripción larga para mostrar cómo se vería en la interfaz 33333333333333333333333333333333333333333333333333333333333333333333333.",
        isRegistered: true
    )
}

#Preview {
    DetalleEvento(eventData: .ejemplo)
}
