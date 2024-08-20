import SwiftUI

struct NavBarView: View {
    var body: some View {
        NavigationView {
            VStack {
                // Your main content here
                
                Spacer()
                
                HStack {
                    Spacer()
                    NavigationLink(destination: ContentView()) {
                        Image(systemName: "house")
                            
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40)
                            .tint(Color(red: 0/255, green: 59/255, blue: 92/255))
                            
                    }
                    Spacer()
                    NavigationLink(destination: ContentView()) {
                        Image(systemName: "storefront")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40)
                            .tint(Color(red: 0/255, green: 59/255, blue: 92/255))
                            
                    }
                    Spacer()
                    NavigationLink(destination: ContentView()) {
                        Image(systemName: "person.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40)
                            .tint(Color(red: 0/255, green: 59/255, blue: 92/255))
                    }
                    Spacer()
                }
            }
            .navigationBarBackButtonHidden(true) // Hide back button in this view
        }
    }
}

#Preview {
    NavBarView()
}

