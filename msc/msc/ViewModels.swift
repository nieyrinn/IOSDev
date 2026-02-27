//
//  AlbumsViewModel.swift
//  msc
//
//  Created by nieyrinn on 07.03.2026.
//


import Foundation

@MainActor
@Observable
class AlbumsViewModel {
    var albums: [Album] = []
    var isLoading = false
    var errorMessage: String? = nil
    var searchQuery = "The Beatles"

    private let service = MusicService()

    func loadAlbums() async {
        isLoading = true
        errorMessage = nil
        do {
            albums = try await service.fetchAlbums(query: searchQuery)
        } catch {
            errorMessage = "Failed to load albums. Check your connection."
        }
        isLoading = false
    }
}

@MainActor
@Observable
class TracksViewModel {
    let album: Album
    var tracks: [Track] = []
    var isLoading = false
    var errorMessage: String? = nil

    private let service = MusicService()

    init(album: Album) {
        self.album = album
    }

    func loadTracks() async {
        isLoading = true
        errorMessage = nil
        do {
            tracks = try await service.fetchTracks(for: album)
        } catch {
            errorMessage = "Failed to load tracks."
        }
        isLoading = false
    }
}

@MainActor
@Observable
class PlayerViewModel {
    let track: Track
    var isPlaying = false

    init(track: Track) {
        self.track = track
    }

    func togglePlayback() {
        isPlaying.toggle()
    }
}