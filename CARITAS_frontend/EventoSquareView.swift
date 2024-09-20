import SwiftUI

struct EventoSquareView: View {
    let evento: Evento

    var body: some View {
        VStack {
            Rectangle()
                .fill(Color(red: 0/255, green: 156/255, blue: 166/255))
                .frame(width: 130, height: 120)
                .cornerRadius(10)
            
            Text(evento.TITULO)
                .font(.caption)
                .multilineTextAlignment(.center)
                .padding(.top, 5)
        }
    }
}

#Preview {
    EventoSquareView(evento: Evento(
        id: 1,
        CUPO: "50",
        DESCRIPCION: "Aprender sobre nutrición saludable.",
        FECHA: "2024-10-05",
        HORA: "10:00:00",
        PUNTOS: "10",
        TIPO_EVENTO: "Nutrición",
        TITULO: "Taller de Nutrición"
    ))
}
