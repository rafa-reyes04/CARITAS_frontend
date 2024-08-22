//
//  FotoPerfilView.swift
//  CARITAS_frontend
//
//  Created by MacBook Air on 21/08/24.
//

import SwiftUI

struct SuperiorPerfilView: View {
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0.0, to: 0.5)
                .frame(width: 600)
                .foregroundColor(Color(red: 0/255, green: 156/255, blue: 166/255))
        }
    }
}

#Preview {
    SuperiorPerfilView()
}
