import SwiftUI

struct DailyView: View {
    @State var daily: Daily?
    
    var body: some View {
        ZStack {
            Color.lightGray.edgesIgnoringSafeArea([.top])
            ScrollView {
                VStack {
                    if let daily = daily {
                        DailyImage(daily: daily)
                            .padding(.top)
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Explanation")
                                .font(.system(size: 33, weight: .light))
                            Text(daily.explanation)
                        }
                        .frame(width: 300)
                        .frame(maxHeight: .infinity)
                        .padding()
                    }
                }
                .task {
                    do {
                        self.daily = try await Data.getDailyData()
                    } catch {
                        print("Error while fetching daily data")
                    }
                }
            }
        }
    }
}

struct DailyView_Previews: PreviewProvider {
    static var previews: some View {
        DailyView(daily: .dailyTest)
    }
}
