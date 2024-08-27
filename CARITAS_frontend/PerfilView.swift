//
//  PerfilView.swift
//  CARITAS_frontend
//
//  Created by Alumno on 21/08/24.
//

import SwiftUI

struct PerfilView: View {
    @State var nombre: String = "Nombre Del Usuario"
    @State var peso: Float = 0.0
    @State var altura: Float = 0.0
    @State var presion: Int = 0
    
    var body: some View {
        VStack {
            // Sección superior con el nombre y la imagen de perfil
            SuperiorPerfilView(nombrePerfil: nombre)
                .padding(.top, -160)
                .padding(.bottom, 60)
            
            
            
            
            // Información del perfil
            VStack(alignment: .center, spacing: 0) {
                
                InfoPerfilView(infoPerfil: "Usuario: \(nombre)", imagenInfoPerfil: "person.circle")
                Spacer()
                InfoPerfilView(infoPerfil: "Peso: \(String(format: "%.2f", peso)) kg", imagenInfoPerfil: "figure")
                Spacer()
                InfoPerfilView(infoPerfil: "Altura: \(String(format: "%.2f", altura)) m", imagenInfoPerfil: "figure.stand")
                Spacer()
                InfoPerfilView(infoPerfil: "Presión: \(presion) mmHg", imagenInfoPerfil: "waveform.path.ecg.rectangle")
                Spacer()
            }

            
            // Espacio para el código QR
            Spacer()
            VStack() {
                Text("Código QR")
                    .font(.headline)
                
                Image(systemName: "qrcode")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 180, height: 180)
            }
            Spacer()
            Spacer()
            Spacer()
            
            
        }
    }
}
#Preview {
    PerfilView()
}
