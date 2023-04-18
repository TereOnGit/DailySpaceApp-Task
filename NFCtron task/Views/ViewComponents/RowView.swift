import SwiftUI

struct RowView: View {
    @State var launch: Launch
    @Environment(\.openURL) var openURL
    @State private var showingWikiAlert = false
    @State private var showingStreamAlert = false
    
    var body: some View {
        HStack {
            HStack(spacing: 40) {
                VStack(alignment: .leading) {
                    HStack {
                        Image("Starlink")
                            .resizable()
                            .frame(maxWidth: 45, maxHeight: 45)
                            .clipShape(Circle())
                        VStack(alignment: .leading) {
                            Text(launch.name)
                                .fontWeight(.bold)
                                .scaledToFit()
                                .minimumScaleFactor(0.8)
                            Text("countdown")
                                .font(.system(size: 10))
                        }
                    }
                    HStack {
                        Button {
                            if let webcast = launch.webcast {
                                openURL(URL(string: webcast)!)
                            } else {
                                showingStreamAlert = true
                            }
                        } label: {
                            HStack(spacing: 10) {
                                Image(systemName: "play.fill")
                                Text("Livestream")
                                    .fontWeight(.bold)
                            }
                            .scaledToFill()
                            .minimumScaleFactor(0.5)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .tint(.white)
                        }
                        .background(Color.lightRed)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        
                        Button {
                            if let wikipedia = launch.wikipedia {
                                openURL(URL(string: wikipedia)!)
                            } else {
                                showingWikiAlert = true
                            }
                        } label: {
                            HStack {
                                Image(systemName: "link")
                                    .rotationEffect(.init(degrees: 45))
                                Text("Wiki")
                                .fontWeight(.bold)
                            }
                            .scaledToFit()
                            .tint(.black)
                            .minimumScaleFactor(0.3)
                        }
                    }
                    .scaledToFit()
                    .scaledToFit()
                    .minimumScaleFactor(0.8)
                }
            
//            FavoritePin {
//            isSet: [launch.index].isFavorite
            Button {
                // to be added
            } label: {
                Image(systemName: "paperclip")
                    .font(.system(size: 30))
                    .tint(.white)
                    .rotationEffect(.init(degrees: -45))
                    .frame(width: 70, height: 70)
                    .background(Color(.darkYellow))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
//            }
        }
            .padding()
        }
        
        .alert("There is no livestream for this launch, yet. Sorry!", isPresented: $showingStreamAlert) {
            Button("OK", role: .cancel) { }
        }
        .alert("No wiki for this launch, sorry!", isPresented: $showingWikiAlert) {
            Button("OK", role: .cancel) { }
        }
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(launch: .launchTest)
    }
}

extension CGColor {
    static let darkYellow = CGColor(red: 0.997, green: 0.797, blue: 0.222, alpha: 1)
}

extension Color {
    static let lightRed = Color(red: 1.000, green: 0.334, blue: 0.361)
}

extension Color {
    static let lightGray = Color(red: 0.95, green: 0.95, blue: 0.95)
}

extension CGColor {
    static let lightGray = CGColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
}

