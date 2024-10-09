import SwiftUI

struct RewardCardView: View {
    var title: String
    var subtitle: String
    var stock: String? = nil
    var comprado: Bool // Agregar este valor para cambiar el color del botón

    var body: some View {
        HStack {
            
            VStack(alignment: .leading) {
                Spacer()
                
                Text(title)
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundColor(.black)
                
                if let stock = stock {
                    Text(stock)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                Text(subtitle)
                    .font(.headline)
                    .foregroundColor(.gray)
                
                Spacer()
            }
            
            Spacer()
            
            Button(action: {
                // Acción del botón de compra
            }) {
                Image(systemName: "dollarsign")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
            }
            .frame(width: 85.0, height: 130.0)
            .background(comprado ? Color.gray : Color.blue) // Botón gris si ya está comprado, azul si no
            .clipShape(Rectangle())
            .cornerRadius(10)
        }
        .padding()
        .frame(width: 350, height: 150)
        .background(Color(UIColor.systemGray6))
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
    }
}

#Preview {
    RewardCardView(title: "Acceso VIP", subtitle: "200 puntos", stock: "10 disponibles", comprado: false)
}
