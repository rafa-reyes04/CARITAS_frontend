import SwiftUI

struct DashboardView: View {
    @StateObject var eventosViewModel = EventosViewModel()
    @StateObject var usuario = UserViewModel()

    var body: some View {
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
                .task {
                    // Llama a la nueva función combinada de manera asíncrona
                    await eventosViewModel.fetchAllEventos(for: usuario.id)
                }

            VStack(alignment: .leading) {
                Text("Mis Eventos")
                    .font(.headline)
                    .padding(.leading, 40)

                // Mostrar los eventos registrados
                if eventosViewModel.eventosRegistrados.isEmpty {
                    Text("No hay eventos registrados por el momento.")
                        .foregroundColor(.gray)
                        .padding(.leading, 20)
                } else {
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
                }

                Text("Eventos Disponibles")
                    .font(.headline)
                    .padding(.leading, 40)
                    .padding(.top)

                // Mostrar todos los eventos disponibles
                if eventosViewModel.eventos.isEmpty {
                    Text("No hay eventos disponibles por el momento.")
                        .foregroundColor(.gray)
                        .padding(.leading, 20)
                } else {
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
        }
    }
}

#Preview {
    DashboardView(usuario: UserViewModel())
}

