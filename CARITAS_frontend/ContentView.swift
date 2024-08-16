//
//  ContentView.swift
//  CARITAS_frontend
//
//  Created by Alumno on 16/08/24.
//

import SwiftUI

struct ContentView: View {
    @State var username:String = ""
    @State var password:String = ""
    
    var body: some View {
        VStack {
            Spacer()
            HStack{
                Spacer()
                TextField("Usuario", text: $username)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 200)
                Spacer()
            }
            
            HStack{
                Spacer()
                TextField("Contraseña", text: $username)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 200)
                Spacer()
            } .padding()
            
            
            Button("Ingresar"){
                
                
            }
            .buttonStyle(.borderedProminent)
            .tint(.red)
            .frame(width: 200, height: 60)
            .font(.title3)
            .padding(.all, 20)

            
            
            Spacer()
        }
        .padding()
        .background(.blue)
    }
}

#Preview {
    ContentView()
}
