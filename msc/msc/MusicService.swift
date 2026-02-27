import Foundation

class MusicService {
    func fetchAlbums(query: String) async throws -> [Album] {
        let encoded = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? query
        let url = URL(string: "https://itunes.apple.com/search?term=\(encoded)&entity=album&limit=25")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(iTunesResponse<iTunesResult>.self, from: data)

        return response.results.compactMap { r in
            guard
                r.wrapperType == "collection",
                let id = r.collectionId,
                let name = r.collectionName,
                let artist = r.artistName,
                let artwork = r.artworkUrl100,
                let count = r.trackCount,
                let date = r.releaseDate
            else { return nil }
            return Album(id: id, collectionName: name, artistName: artist,
                         artworkUrl100: artwork, trackCount: count, releaseDate: date)
        }
    }

    func fetchTracks(for album: Album) async throws -> [Track] {
        let url = URL(string: "https://itunes.apple.com/lookup?id=\(album.id)&entity=song")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(iTunesResponse<iTunesResult>.self, from: data)

        return response.results.compactMap { r in
            guard
                r.wrapperType == "track",
                let id = r.trackId,
                let name = r.trackName,
                let artist = r.artistName,
                let collection = r.collectionName,
                let number = r.trackNumber,
                let artwork = r.artworkUrl100
            else { return nil }
            return Track(id: id, trackName: name, artistName: artist,
                         collectionName: collection, trackNumber: number,
                         trackTimeMillis: r.trackTimeMillis,
                         previewUrl: r.previewUrl, artworkUrl100: artwork)
        }
    }
}