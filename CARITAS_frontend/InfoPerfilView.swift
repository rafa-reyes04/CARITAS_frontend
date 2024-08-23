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
            Divider()
            HStack{
                Image(systemName: imagenInfoPerfil)
                Text(infoPerfil)
                Spacer()
            
            } .padding(.horizontal)
            Divider()
        }
    }
}

#Preview {
    InfoPerfilView()
}
