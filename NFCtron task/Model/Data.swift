import Foundation

struct Launch: Decodable, Identifiable, Hashable {
    
    var name: String
    var dateUnix: Date
    var id: String
    var payloads: [String]
    var upcoming: Bool
    var links: Links
    
    struct Links: Decodable, Hashable {
        var webcast: URL?
        var wikipedia: URL?
    }
    
}

struct Daily: Decodable {
    var explanation: String
    var title: String
    var url: String
    var hdurl: String
}

class FavoritesLaunches: ObservableObject {
    @Published var favorites: Set<Launch> = []
    
    init() { }
}

class Data {
    
    static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .secondsSince1970
        return decoder
    }()
    
    static var urlSession: URLSession = .shared
    
    static func getLaunchData() async throws -> [Launch] {
        guard let url = URL(string: "https://api.spacexdata.com/v5/launches/upcoming") else {fatalError("Missing URL")}
        let data = try await urlSession.data(from: url).0
        return try decoder.decode([Launch].self, from: data)
    }
    
    static func getDailyData() async throws -> Daily {
        guard let url = URL(string: "https://api.nasa.gov/planetary/apod") else {fatalError("Missing URL")}
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        components.queryItems = [URLQueryItem(name: "api_key", value: "H6E6jwPGnZxKqql1weg49sJI8IfJOrh8bOZPjbqp")]
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        let responseData = try await urlSession.data(for: request).0
        return try decoder.decode(Daily.self, from: responseData)
    }
    
}
        
extension Launch {
    static var launchTest = Launch(name: "FalconSat", dateUnix: Date(timeIntervalSince1970: 1692369079), id: "5eb87cd9ffd86e000604b32a", payloads: ["5eb0e4b6b6c3bb0006eeb1e2"], upcoming: false, links: Launch.Links(webcast: nil, wikipedia: URL(string: "https://en.wikipedia.org/wiki/DemoSat")))
}

extension Daily {
    static var dailyTest = Daily(explanation: "What's that red ring in the sky? Lightning. The most commonly seen type of lightning involves flashes of bright white light between clouds. Over the past 50 years, though, other types of upper-atmospheric lightning have been confirmed, including red sprites and blue jets. Less well known and harder to photograph is a different type of upper atmospheric lightning known as ELVES. ELVES are thought to be created when an electromagnetic pulse shoots upward from charged clouds and impacts the ionosphere, causing nitrogen molecules to glow.  The red ELVES ring pictured had a radius of about 350 km and was captured in late March about 100 kilometers above Ancona, Italy. Years of experience and ultra-fast photography were used to capture this ELVES -- which lasted only about 0.001 second.", title: "ELVES Lightning over Italy", url: "https://apod.nasa.gov/apod/image/2304/Elves_Binotto_1080.jpg", hdurl: "https://apod.nasa.gov/apod/image/2304/Elves_Binotto_2000.jpg")
}

// XCode ve starší verzi, před funkcí URL.appending
