//
//  TiendaView.swift
//  CARITAS_frontend
//
//  Created by Alumno on 21/08/24.
//

import SwiftUI

struct TiendaView: View {
    @StateObject private var viewModel = RecompensasViewModel()
    var puntosDisponibles: Int = 1200
    var usuarioId: Int = 1 // Reemplaza con el ID del usuario real

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Tienda")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding([.leading, .bottom, .trailing])

                    Spacer()
                    HStack {
                        Image(systemName: "star.fill")
                            .font(.title2)
                            .foregroundColor(.yellow)

                        Text("\(puntosDisponibles)")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    .padding([.leading, .bottom, .trailing])
                }
                .padding([.horizontal, .top], 16)
                .background(Color(red: 0/255, green: 156/255, blue: 166/255))

                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(viewModel.recompensas, id: \.nombre) { recompensa in
                            RewardCardView(
                                title: recompensa.nombre,
                                subtitle: "\(recompensa.costo) puntos",
                                stock: "\(recompensa.restantes) disponibles",
                                comprado: recompensa.comprado
                            )
                        }
                    }
                    .padding(.horizontal, 16)
                }
                .padding(.top)
            }
            .navigationBarHidden(true)
            .onAppear {
                Task {
                    await viewModel.fetchRecompensas(for: usuarioId)
                }
            }
        }
    }
}


#Preview {
    TiendaView()
}
