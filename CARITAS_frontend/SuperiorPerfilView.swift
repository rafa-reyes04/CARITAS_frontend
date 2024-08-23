import SwiftUI

struct SuperiorPerfilView: View {
    @State var nombrePerfil:String = "Placeholder"
    var body: some View {
        ZStack {
            
            Circle()
                .fill(Color(red: 0/255, green: 156/255, blue: 166/255))
                .frame(width: 1000, height: 1000)
                .offset(x: 0, y: -700)
                .ignoresSafeArea()
            
            
                Text(nombrePerfil)
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
                    .offset(x: 0, y: -300)

                ZStack{
                    Circle()
                        .fill(Color(.black))
                        .frame(width: 150, height: 150)
                        .offset(x: 0, y: -300)
                    
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(width: 140, height: 140)
                        .foregroundColor(.white)
                        .offset(x: 0, y: -300)
                }
            
            .padding(.top, 200)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .background(Color(.white)
            .edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    SuperiorPerfilView()
}
