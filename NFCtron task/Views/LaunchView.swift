import SwiftUI

struct LaunchView: View {
    @State var launch: [Launch] = []
    @State private var searchText = ""
    
//    private var searchedResults: [Launch] {
//        var searchedLaunches: [Launch] = []
//        if $launch.name.contains(searchText) {
//            searchedLaunches.append($launch)
//        }
//        return searchedLaunches
//    }
    
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
            
            
                //    List {
                //        ForEach(launch.favorites) { launch in
                //            RowView(launch: launch)
                //        }
                List {
                    if self.searchText.isEmpty {
                        ForEach(launch) { launch in
                            if launch.dateUnix > Date.now {
                            RowView(launch: launch)
                            } else {
                                RowView(launch: launch)
                            }
                    }
                    //               } else {
                    //                   ForEach(searchedResults) { launch in
                    //                       RowView(launch: launch)
                    //                   }
                    }
                }
            
                //upravit místo List ZStack a posuvný seznam
            .searchable(text: $searchText)
            
            .task {
                do {
                    self.launch = try await Data.getLaunchData()
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

// time remaining .onReceive
