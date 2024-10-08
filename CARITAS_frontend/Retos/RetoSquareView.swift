import SwiftUI

struct RetoSquareView: View {
    let reto: Reto

    var body: some View {
        VStack {
            Image("RetoImagen")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 170.0, height: 150)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(red: 0/255, green: 156/255, blue: 166/255), lineWidth: 2)
                )

            Text(reto.NOMBRE)
                .font(.caption)
                .multilineTextAlignment(.center)
                .padding(.top, 5)
        }
    }
}

#Preview {
    RetoSquareView(reto: Reto(
        id: 1,
        DESCRIPCION: "Correr para empezar a mejorar tu salud.",
        NOMBRE: "Correr 2 km",
        PUNTAJE: "20"
    ))
}
