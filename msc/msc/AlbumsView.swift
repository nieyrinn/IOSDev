import SwiftUI

struct AlbumsView: View {
    @State var viewModel: AlbumsViewModel
    var onAlbumTap: (Album) -> Void

    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView("Loading albums...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let error = viewModel.errorMessage {
                ContentUnavailableView(error, systemImage: "wifi.slash")
            } else {
                List(viewModel.albums) { album in
                    Button {
                        onAlbumTap(album)
                    } label: {
                        AlbumRow(album: album)
                    }
                    .buttonStyle(.plain)
                    .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .listRowBackground(Color.blue.opacity(0.1))

                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("Albums")
        .navigationBarTitleDisplayMode(.large)
        .task { await viewModel.loadAlbums() }
    }
}

struct AlbumRow: View {
    let album: Album

    var body: some View {
        HStack(spacing: 14) {
            AsyncImage(url: URL(string: album.artworkUrl100)) { phase in
                switch phase {
                case .success(let img):
                    img.resizable().scaledToFill()
                default:
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.gray.opacity(0.2))
                        .overlay(Image(systemName: "music.note").foregroundStyle(.gray))
                }
            }
            .frame(width: 60, height: 60)
            .clipShape(RoundedRectangle(cornerRadius: 8))

            VStack(alignment: .leading, spacing: 3) {
                Text(album.collectionName)
                    .font(.headline)
                    .lineLimit(1)
                Text(album.artistName)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
                Text("\(album.trackCount) songs · \(album.releaseYear)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundStyle(.tertiary)
        }
    }
}
