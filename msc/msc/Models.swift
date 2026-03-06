import Foundation

struct Album: Codable, Identifiable {
    let id: Int
    let collectionName: String
    let artistName: String
    let artworkUrl100: String
    let trackCount: Int
    let releaseDate: String

    enum CodingKeys: String, CodingKey {
        case id = "collectionId"
        case collectionName
        case artistName
        case artworkUrl100
        case trackCount
        case releaseDate
    }

    var artworkUrl600: String {
        artworkUrl100.replacingOccurrences(of: "100x100bb", with: "600x600bb")
    }

    var releaseYear: String {
        String(releaseDate.prefix(4))
    }
}

struct Track: Codable, Identifiable {
    let id: Int
    let trackName: String
    let artistName: String
    let collectionName: String
    let trackNumber: Int
    let trackTimeMillis: Int?
    let previewUrl: String?
    let artworkUrl100: String

    enum CodingKeys: String, CodingKey {
        case id = "trackId"
        case trackName
        case artistName
        case collectionName
        case trackNumber
        case trackTimeMillis
        case previewUrl
        case artworkUrl100
    }

    var durationFormatted: String {
        guard let ms = trackTimeMillis else { return "--:--" }
        let totalSeconds = ms / 1000
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%d:%02d", minutes, seconds)
    }

    var artworkUrl600: String {
        artworkUrl100.replacingOccurrences(of: "100x100bb", with: "600x600bb")
    }
}

struct iTunesResponse<T: Codable>: Codable {
    let resultCount: Int
    let results: [T]
}

struct iTunesResult: Codable {
    let wrapperType: String?
    let collectionId: Int?
    let trackId: Int?
    let collectionName: String?
    let trackName: String?
    let artistName: String?
    let artworkUrl100: String?
    let trackCount: Int?
    let releaseDate: String?
    let trackNumber: Int?
    let trackTimeMillis: Int?
    let previewUrl: String?
}
