import SwiftUI

struct MainView: View {
    @State private var selectedTab: Int = 0
    
    var body: some View {
        VStack {

            Spacer(minLength: 20)
            
            // La vista seleccionada se renderiza aquí.
            switch selectedTab {
            case 0:
                DashboardView()
            case 1:
                TiendaView()
            case 2:
                PerfilView()
            default:
                DashboardView()
            }
            
            Spacer(minLength: 40)
            
            HStack {
                Spacer()
                Button(action: {
                    selectedTab = 0
                }) {
                    VStack {
                        Image(systemName: "house")
                            .resizable()
                            .frame(width: 32, height: 28)
                            .foregroundColor(selectedTab == 0 ? .blue : .gray)
                    }
                }
                Spacer()
                Button(action: {
                    selectedTab = 1
                }) {
                    VStack {
                        Image(systemName: "cart")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .foregroundColor(selectedTab == 1 ? .blue : .gray)
                    }
                }
                Spacer()
                Button(action: {
                    selectedTab = 2
                }) {
                    VStack {
                        Image(systemName: "person.circle")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .foregroundColor(selectedTab == 2 ? .blue : .gray)
                    }
                }
                Spacer()
                    
            }
            .padding(.bottom, 25)
            .padding(.top, 20) // Ajusta el padding inferior para más espacio.
            .background(Color.white.shadow(radius: 10))
            .navigationBarBackButtonHidden(true)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    MainView()
}
