import SwiftUI

struct DashboardView: View {
    @ObservedObject var eventosViewModel = EventosViewModel()
    let usuario: Usuario?

    var body: some View {
        if let usuario = usuario {
            VStack {
                Text("¡Buenos días, \(usuario.nombre)!")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom)
                
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
                    .cornerRadius(10)
                    .padding(.bottom)
                    .onAppear {
                        eventosViewModel.fetchEventosRegistrados(for: usuario.id)
                    }

                VStack(alignment: .leading) {
                    Text("Mis Eventos")
                        .font(.headline)
                        .padding(.leading, 40)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(eventosViewModel.eventosRegistrados) { item in
                                NavigationLink(destination: DetalleEvento(eventData: item, usuario: usuario)) {
                                    EventoSquareView(evento: item)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    Text("Eventos Disponibles")
                        .font(.headline)
                        .padding(.leading, 40)
                        .padding(.top)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(eventosViewModel.eventos) { item in
                                NavigationLink(destination: DetalleEvento(eventData: item, usuario: usuario)) {
                                    EventoSquareView(evento: item)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        } else {
            Text("Usuario no disponible")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom)
        }
    }
}

#Preview {
    DashboardView(usuario: Usuario(
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
