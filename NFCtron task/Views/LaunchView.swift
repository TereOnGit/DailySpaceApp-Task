import SwiftUI

struct LaunchView: View {
    @State var launches: [Launch] = []
    @EnvironmentObject var favorites: FavoritesLaunches
    @State private var searchText = ""
    
    private var searchedResults: [Launch] {
        if searchText.isEmpty {
            return launches
        } else {
            return launches.filter { launch in
                launch.name.contains(searchText)
            }
        }
    }
    
    var body: some View {
        VStack {
 
            HStack {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 20, weight: .bold))
                    .padding(.leading)
                TextField("Type in mission name or payload name...", text: $searchText)
                    .font(.system(size: 15, weight: .bold))
                    .frame(width: 300, height: 45, alignment: .center)
            }
            .foregroundColor(.gray)
            .background(Color.primary.opacity(0.05))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding()
            
            Divider()
            
 //           ScrollView {
                List {
                    //                ForEach(favorites) { launch in
                    //                    RowView(launch: launch)
                }
                .frame(maxWidth: .infinity, maxHeight: 200)
                Divider()
                List {
                    ForEach(searchedResults) { launch in
                        if launch.dateUnix > Date.now {
                            RowView(launch: launch)
                        } else {
                            RowView(launch: launch)
                        }
                    }
 //               }
            }
            
                //upravit místo List ZStack a posuvný seznam
            .searchable(text: $searchText)
            
            .task {
                do {
                    self.launches = try await Data.getLaunchData()
                } catch {
                    print("Chyba: \(error)")
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

