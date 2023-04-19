import SwiftUI

struct Countdown: View {
    let referenceDate: Date
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    private var timeRemaining: String {
        let dateComponentFormatter = DateComponentsFormatter()
        dateComponentFormatter.allowedUnits = [.day, .hour, .minute, .second]
        dateComponentFormatter.unitsStyle = .abbreviated
        return dateComponentFormatter.string(from: Date.now, to: referenceDate) ?? "..."
    }
    
    @State private var text: String = ""
    
    var body: some View {
        Text("Launch in \(text)")
            .onAppear { self.text = timeRemaining }
            .onReceive(timer) { _ in
                self.text = timeRemaining
            }
    }
}

struct countdown_Previews: PreviewProvider {
    static var previews: some View {
        Countdown(referenceDate: Date.now.addingTimeInterval(14689))
    }
}
