import SwiftUI

struct EventoSquareView: View {
    let evento: Evento
    @State private var imagenEventoSquare: String = ""

    var body: some View {
        VStack {
            Image(imagenEventoSquare)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 170.0, height: 150)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(red: 0/255, green: 156/255, blue: 166/255), lineWidth: 2)
                )

            Text(evento.TITULO)
                .font(.caption)
                .multilineTextAlignment(.center)
                .padding(.top, 5)
        }
        .onAppear {
            // Set the image based on the event type
            if evento.TIPO_EVENTO == "Nutrición" {
                imagenEventoSquare = "imagenNutricion"
            } else if evento.TIPO_EVENTO == "Conferencia" {
                imagenEventoSquare = "imagenConferencia"
            } else if evento.TIPO_EVENTO == "Revisión" {
                imagenEventoSquare = "imagenRevision"
            } else if evento.TIPO_EVENTO == "Ejercicio" {
                imagenEventoSquare = "imagenEjercicio"
            }
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
