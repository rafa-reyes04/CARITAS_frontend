import SwiftUI

struct DashboardView: View {
    @ObservedObject var eventosViewModel = EventosViewModel()

    var body: some View {
        VStack {
            // Título principal
            Text("Buenos dias!")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom)
            
            // Imagen
            Image(systemName: "photo")
                .resizable()
                .scaledToFit()
                .frame(height: 150)
                .cornerRadius(10)
                .padding(.bottom)
        }

        VStack(alignment: .leading) {
            Text("Mis Eventos")
                .font(.headline)
                .padding(.leading)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(eventosViewModel.eventos) { evento in
                        EventoSquareView(evento: evento)
                    }
                }
                .padding(.horizontal)
            }
            
            Text("Eventos Disponibles")
                .font(.headline)
                .padding(.leading)
                .padding(.top)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(eventosViewModel.eventos) { evento in
                        EventoSquareView(evento: evento)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    DashboardView()
}
