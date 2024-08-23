//
//  PerfilView.swift
//  CARITAS_frontend
//
//  Created by Alumno on 21/08/24.
//

import SwiftUI

struct PerfilView: View {
    @State var nombre:String = ""
    @State var apellido:String = ""
    
    @State var peso:Float = 0.0
    @State var presion:String = ""
    @State var tipo_sangre:String = ""
    @State var altura:Float = 0.0




    var body: some View {
        VStack{
            SuperiorPerfilView(nombrePerfil: "Juan Perez")
                .padding(.top, 100)
            
            InfoPerfilView(infoPerfil: "Peso", imagenInfoPerfil: "figure")
            InfoPerfilView(infoPerfil: "Altura", imagenInfoPerfil: "figure.stand")
            InfoPerfilView(infoPerfil: "Tipo de Sangre", imagenInfoPerfil: "ivfluid.bag")
            InfoPerfilView(infoPerfil: "Presion", imagenInfoPerfil: "waveform.path.ecg.rectangle")
            
            Spacer()
        }
    }
    
}
#Preview {
    PerfilView()
}
