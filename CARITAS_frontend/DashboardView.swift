import SwiftUI

struct DashboardView: View {
    var body: some View {
        VStack{
             // Título principal
            Text("Buenos dias Usuario!")
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
                    ForEach(0..<5) { index in
                        VStack {
                            Rectangle()
                                .fill(Color(red: 0/255, green: 156/255, blue: 166/255))
                                .frame(width: 130, height: 120)
                                .cornerRadius(10)
                            Text(misEventos(for: index))
                                .font(.caption)
                        }
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
                    ForEach(0..<5) { index in
                        VStack {
                            Rectangle()
                                .fill(Color(red: 0/255, green: 156/255, blue: 166/255))
                                .frame(width: 130, height: 120)
                                .cornerRadius(10)
                            Text(EventosDisponibles(for: index))
                                .font(.caption)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
    
    // Funciones para generar nombres de eventos
    func misEventos(for index: Int) -> String {
        switch index {
        default: return "Evento \(index + 1)"
        }
    }
    
    func EventosDisponibles(for index: Int) -> String {
        switch index {
        default: return "Evento \(index + 1)"
        }
    }
}

#Preview {
    DashboardView()
}
