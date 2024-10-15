import SwiftUI

struct MainView: View {
    @State private var selectedTab: Int = 0
    @StateObject var user = UserViewModel()
    
    var body: some View {
        VStack {
            
            
            
            // La vista seleccionada se renderiza aquí.
            switch selectedTab {
            case 0:
                DashboardView(usuario: user)
            case 1:
                RetosView()
            case 2:
                TiendaView()
            case 3:
                Spacer()
                PerfilView()
            default:
                DashboardView(usuario: user)
            }
            
            HStack {
                Spacer()
                Button(action: {
                    selectedTab = 0
                }) {
                    VStack {
                        Image(systemName: "house")
                            .resizable()
                            .frame(width: 32, height: 28)
                            .foregroundColor(selectedTab == 0 ? Color(red: 0/255, green: 156/255, blue: 166/255) : .gray)
                    }
                }
                Spacer()
                Button(action: {
                    selectedTab = 1
                }) {
                    VStack {
                        Image(systemName: "figure.run")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .foregroundColor(selectedTab == 1 ? Color(red: 0/255, green: 156/255, blue: 166/255) : .gray)
                    }
                }
                Spacer()
                Button(action: {
                    selectedTab = 2
                }) {
                    VStack {
                        Image(systemName: "cart")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .foregroundColor(selectedTab == 2 ? Color(red: 0/255, green: 156/255, blue: 166/255) : .gray)
                    }
                }
                Spacer()
                Button(action: {
                    selectedTab = 3
                }) {
                    VStack {
                        Image(systemName: "person.circle")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .foregroundColor(selectedTab == 3 ? Color(red: 0/255, green: 156/255, blue: 166/255) : .gray)
                    }
                }
                Spacer()
                    
            }
            .padding(.bottom, 25)
            .padding(.top, 20) // Ajusta el padding inferior para más espacio.
            .background(Color.white.shadow(radius: 10))
            .navigationBarBackButtonHidden(true)
        }
        .onAppear{
            // Cargamos los datos del usuario que inició sesión
            user.loadUser()
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    MainView()
}
