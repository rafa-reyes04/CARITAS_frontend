//
//  TiendaView.swift
//  CARITAS_frontend
//
//  Created by Alumno on 21/08/24.
//

import SwiftUI

struct TiendaView: View {
    var puntosDisponibles: Int = 1200
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Tienda")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    Spacer()
                    HStack {
                        Image(systemName: "star.fill")
                            .font(.title2)
                            .foregroundColor(.yellow)
                        
                        Text("\(puntosDisponibles)")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                    }
                }
                .padding([.horizontal, .top], 16)
                
                ScrollView {
                    LazyVStack(spacing: 16) {
                        RewardCard(title: "Dia Libre", subtitle: "50 disponibles")
                        RewardCard(title: "100 puntos", subtitle: "30 disponibles")
                        RewardCard(title: "Camiseta Exclusiva", subtitle: "75 puntos", stock: "100 disponibles")
                        RewardCard(title: "Membresía Anual", subtitle: "150 puntos", stock: "30 disponibles")
                        RewardCard(title: "Acceso VIP", subtitle: "200 puntos", stock: "10 disponibles")
                        RewardCard(title: "Descuento Especial", subtitle: "125 puntos", stock: "20 disponibles")
                        RewardCard(title: "Producto Gratis", subtitle: "50 puntos", stock: "15 disponibles")
                        RewardCard(title: "Entrada Exclusiva", subtitle: "175 puntos", stock: "5 disponibles")
                        RewardCard(title: "Experiencia Única", subtitle: "300 puntos", stock: "2 disponibles")
                        RewardCard(title: "Regalo Sorpresa", subtitle: "60 puntos", stock: "50 disponibles")
                    }
                    .padding(.horizontal, 16)
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct RewardCard: View {
    var title: String
    var subtitle: String
    var stock: String? = nil
    
    var body: some View {
        VStack {
            Spacer()
            
            Text(title)
                .font(.title2)
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
        .padding()
        .frame(width: 300, height: 150) 
        .background(Color(UIColor.systemGray6))
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
    }
}

#Preview {
    TiendaView()
}
