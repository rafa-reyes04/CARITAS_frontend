import SwiftUI

struct DashboardView: View {
    @StateObject var eventosViewModel = EventosViewModel()
    @StateObject var usuario = UserViewModel()

    var body: some View {
        ZStack {
            // Fondo celeste que cubre toda la pantalla
            Color(red: 255/255, green: 255/255, blue: 255/255)
                .edgesIgnoringSafeArea(.all)

            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color(red: 0/255, green: 156/255, blue: 166/255))
                        .frame(height: 220)
                        .cornerRadius(10)

                    Image("caritasLogo_login")
                        .resizable(resizingMode: .stretch)
                        .aspectRatio(contentMode: .fit)
                        .padding(.top, 60)
                        .padding(.bottom, 30)
                        .frame(width: 200)
                        .task {
                            // Llama a la nueva función combinada de manera asíncrona
                            await eventosViewModel.fetchAllEventos(for: usuario.id)
                        }
                }
                .edgesIgnoringSafeArea(.top)
                .padding(.bottom, -30)

                VStack(alignment: .leading) {
                    Text("Mis Eventos")
                        .font(.title)
                        .bold()
                        .padding(.leading, 20)
                        .padding(.bottom, 1)

                    // Mostrar los eventos registrados
                    if eventosViewModel.eventosRegistrados.isEmpty {
                        Text("No hay eventos registrados por el momento.")
                            .foregroundColor(.gray)
                            .font(.system(size: 18))
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
                        .font(.title)
                        .bold()
                        .padding(.leading, 20)
                        .padding(.top)
                        .padding(.bottom, 1)

                    // Mostrar todos los eventos disponibles
                    if eventosViewModel.eventos.isEmpty {
                        Text("No hay eventos disponibles por el momento.")
                            .foregroundColor(.gray)
                            .font(.system(size: 18))
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
                Spacer()
            }
        }
    }
}

#Preview {
    DashboardView(usuario: UserViewModel())
}
