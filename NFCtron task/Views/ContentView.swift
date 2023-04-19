import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            DailyView()
                .tabItem {
                    Image(systemName: "photo.fill")
                    Text("Daily")
                }
                .tint(.gray)
            
            LaunchView()
                .tabItem {
                    Image(systemName: "note")
                    Text("Launches")
                        
                }
                .tint(.gray)
        }
        .accentColor(.darkGray)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Color {
    static var darkGray = Color(red: 0.22, green: 0.22, blue: 0.22)
}
