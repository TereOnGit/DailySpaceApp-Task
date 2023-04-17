import SwiftUI

struct LaunchView: View {
    @State var launch: [Launch] = []
    @State private var searchText = ""
    
    var body: some View {
        VStack {
            
            HStack {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 25, weight: .bold))
                TextField("Type in mission name or payload name...", text: $searchText)
            }
            .foregroundColor(.gray)
            .background(Color.primary.opacity(0.05))
            .frame(width: 300, height: 50, alignment: .center)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .padding()
            
            ScrollView {
                //    List {
                //        ForEach(launch.favorites) { launch in
                //            RowView(launch: launch)
                //        }
                ZStack {
                    ForEach(launch) { launch in
                        RowView(launch: launch)
                        
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Type in mission name or payload name...")
            .task {
                do {
                    self.launch = try await Data.getLaunchData()
                } catch {
                    print("Error while fetching launch data")
                }
            }
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}

// time remaining .onReceive
