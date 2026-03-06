//
//  TracksView.swift
//  msc
//
//  Created by nieyrinn on 07.03.2026.
//


import SwiftUI

struct TracksView: View {
    @State var viewModel: TracksViewModel
    var onTrackTap: (Track) -> Void

    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView("Loading tracks...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let error = viewModel.errorMessage {
                ContentUnavailableView(error, systemImage: "wifi.slash")
            } else {
                List {
                    AlbumHeaderSection(album: viewModel.album)
                        .listRowInsets(EdgeInsets())
                        .listRowSeparator(.hidden)


                    ForEach(viewModel.tracks) { track in
                        TrackRow(track: track)
                            .contentShape(Rectangle())
                            .onTapGesture { onTrackTap(track) }
                            .listRowBackground(Color.blue.opacity(0.1))
                            .listRowInsets(EdgeInsets(top: 6, leading: 16, bottom: 6, trailing: 16))
                    }
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle(viewModel.album.collectionName)
        .navigationBarTitleDisplayMode(.inline)
        .task { await viewModel.loadTracks() }
    }
}

struct AlbumHeaderSection: View {
    let album: Album

    var body: some View {
        VStack(spacing: 12) {
            AsyncImage(url: URL(string: album.artworkUrl600)) { phase in
                switch phase {
                case .success(let img):
                    img.resizable().scaledToFit()
                default:
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.gray.opacity(0.2))
                        .aspectRatio(1, contentMode: .fit)
                }
            }
            .frame(width: 220, height: 220)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(radius: 8)

            VStack(spacing: 4) {
                Text(album.collectionName)
                    .font(.title3.bold())
                    .multilineTextAlignment(.center)
                Text(album.artistName)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Text("\(album.releaseYear) · \(album.trackCount) songs")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 24)
        .padding(.horizontal, 16)
    }
}

struct TrackRow: View {
    let track: Track

    var body: some View {
        HStack(spacing: 14) {
            Text("\(track.trackNumber)")
                .font(.subheadline.monospacedDigit())
                .foregroundStyle(.secondary)
                .frame(width: 24, alignment: .trailing)

            VStack(alignment: .leading, spacing: 3) {
                Text(track.trackName)
                    .font(.body)
                    .lineLimit(1)
                Text(track.artistName)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }

            Spacer()

            Text(track.durationFormatted)
                .font(.caption.monospacedDigit())
                .foregroundStyle(.secondary)

            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundStyle(.tertiary)
        }
    }
}
