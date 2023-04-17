import SwiftUI

struct DailyImage: View {
    @State var daily: Daily
    
    private func getToday() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d. M. yyyy"
        return dateFormatter.string(from: Date.now)
    }
    
    var body: some View {
        ZStack {
            AsyncImage(url: URL(string: daily.hdurl), transaction: Transaction(animation: .spring())) { phase in
                switch phase {
                case .empty:
                    AsyncImage(url: URL(string: daily.url))
             
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
             
                case .failure(_):
                    Image(systemName: "exclamationmark.icloud")
                        .resizable()
                        .scaledToFit()
             
                @unknown default:
                    Image(systemName: "exclamationmark.icloud")
                }
            }
            .frame(width: 300, height: 500)
            .cornerRadius(20)
            
            VStack(alignment: .leading) {
                Text(daily.title)
                Spacer()
                VStack(alignment: .leading) {
                    Text(getToday())
                    Text("Today")
                        .font(.system(size: 33, weight: .light))
                }
            }
            .padding(.trailing, 50)
            .padding()
            .foregroundColor(.white)
            .frame(width: 300, height: 500)
        }
    }
}

struct DailyImage_Previews: PreviewProvider {
    static var previews: some View {
        DailyImage(daily: .dailyTest)
    }
}


