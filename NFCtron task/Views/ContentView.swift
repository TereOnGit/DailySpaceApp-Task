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
        .onAppear() {
            UITabBar.appearance().barTintColor = .white
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
