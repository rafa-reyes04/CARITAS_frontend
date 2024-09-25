//
//  InfoPerfilView.swift
//  CARITAS_frontend
//
//  Created by Alumno on 23/08/24.
//

import SwiftUI

struct InfoPerfilView: View {
    @State var infoPerfil:String = "Placeholder"
    @State var imagenInfoPerfil:String = "figure"
    var body: some View {
        VStack{
            HStack(alignment: .center){
                Spacer()
                Image(systemName: imagenInfoPerfil)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                Text(infoPerfil)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                Spacer()
            
            }
            Divider()
            
        }
    }
}

#Preview {
    InfoPerfilView()
}
