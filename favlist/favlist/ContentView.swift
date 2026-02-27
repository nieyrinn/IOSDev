import SwiftUI
struct FavoriteItem: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let emoji: String
}

struct ItemRow: View {
    let item: FavoriteItem
    var isFavorite: Bool
    var onToggle: () -> Void
    var body: some View {
        HStack(spacing: 12) {
            Text(item.emoji)
                .font(.title2)
            VStack(alignment: .leading, spacing: 2) {
                Text(item.title)
                    .font(.headline)
                Text(item.subtitle)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Button(action: onToggle) {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
               .foregroundStyle(isFavorite ? .red : .gray)
            }
            .buttonStyle(.plain)
        }
        .padding(.vertical, 4)
    }
}

struct ContentView: View {
    @State private var sciFiMovies: [FavoriteItem] = [
        FavoriteItem(title: "Interstellar", subtitle: "2014 · Nolan", emoji: "🌌"),
        FavoriteItem(title: "The Matrix", subtitle: "1999 · Wachowski", emoji: "💊"),
        FavoriteItem(title: "Arrival", subtitle: "2016 · Villeneuve", emoji: "🛸"),
        FavoriteItem(title: "Blade Runner 2049", subtitle: "2017 · Villeneuve", emoji: "🤖"),
        FavoriteItem(title: "Dune", subtitle: "2021 · Villeneuve", emoji: "🏜️"),
        FavoriteItem(title: "Ex Machina", subtitle: "2014 · Garland", emoji: "🧠"),
        FavoriteItem(title: "2001: A Space Odyssey", subtitle: "1968 · Kubrick", emoji: "🚀"),
        FavoriteItem(title: "Inception", subtitle: "2010 · Nolan", emoji: "🌀"),
        FavoriteItem(title: "Her", subtitle: "2013 · Jonze", emoji: "🖥️"),
        FavoriteItem(title: "Moon", subtitle: "2009 · Jones", emoji: "🌕"),
    ]

    @State private var rpgGames: [FavoriteItem] = [
        FavoriteItem(title: "Elden Ring", subtitle: "2022 · FromSoftware", emoji: "⚔️"),
        FavoriteItem(title: "The Witcher 3", subtitle: "2015 · CD Projekt", emoji: "🐺"),
        FavoriteItem(title: "Dark Souls III", subtitle: "2016 · FromSoftware", emoji: "🔥"),
        FavoriteItem(title: "Baldur's Gate 3", subtitle: "2023 · Larian", emoji: "🎲"),
        FavoriteItem(title: "Cyberpunk 2077", subtitle: "2020 · CD Projekt", emoji: "🦾"),
        FavoriteItem(title: "Red Dead Redemption 2", subtitle: "2018 · Rockstar", emoji: "🤠"),
        FavoriteItem(title: "Sekiro", subtitle: "2019 · FromSoftware", emoji: "🗡️"),
        FavoriteItem(title: "God of War", subtitle: "2018 · Santa Monica", emoji: "🪓"),
        FavoriteItem(title: "Mass Effect 2", subtitle: "2010 · BioWare", emoji: "🪐"),
        FavoriteItem(title: "Hollow Knight", subtitle: "2017 · Team Cherry", emoji: "🦋"),
    ]

    @State private var electronicMusic: [FavoriteItem] = [
        FavoriteItem(title: "Daft Punk", subtitle: "Random Access Memories", emoji: "🤖"),
        FavoriteItem(title: "Boards of Canada", subtitle: "Music Has the Right...", emoji: "🌿"),
        FavoriteItem(title: "Aphex Twin", subtitle: "Selected Ambient Works", emoji: "🌀"),
        FavoriteItem(title: "Jon Hopkins", subtitle: "Immunity", emoji: "💫"),
        FavoriteItem(title: "Burial", subtitle: "Untrue", emoji: "🌧️"),
        FavoriteItem(title: "Four Tet", subtitle: "There Is Love In You", emoji: "🎶"),
        FavoriteItem(title: "Moderat", subtitle: "II", emoji: "⚡"),
        FavoriteItem(title: "Tycho", subtitle: "Dive", emoji: "🌊"),
        FavoriteItem(title: "Caribou", subtitle: "Swim", emoji: "🐠"),
        FavoriteItem(title: "Nils Frahm", subtitle: "Felt", emoji: "🎹"),
    ]

    @State private var fictionBooks: [FavoriteItem] = [
        FavoriteItem(title: "Dune", subtitle: "Frank Herbert · 1965", emoji: "📖"),
        FavoriteItem(title: "1984", subtitle: "George Orwell · 1949", emoji: "👁️"),
        FavoriteItem(title: "The Road", subtitle: "Cormac McCarthy · 2006", emoji: "🛣️"),
        FavoriteItem(title: "Hyperion", subtitle: "Dan Simmons · 1989", emoji: "🌹"),
        FavoriteItem(title: "Solaris", subtitle: "Stanisław Lem · 1961", emoji: "🌊"),
        FavoriteItem(title: "Flowers for Algernon", subtitle: "Daniel Keyes · 1966", emoji: "🌸"),
        FavoriteItem(title: "Never Let Me Go", subtitle: "Ishiguro · 2005", emoji: "🫀"),
        FavoriteItem(title: "The Left Hand of Darkness", subtitle: "Le Guin · 1969", emoji: "❄️"),
        FavoriteItem(title: "Catch-22", subtitle: "Joseph Heller · 1961", emoji: "✈️"),
        FavoriteItem(title: "Slaughterhouse-Five", subtitle: "Vonnegut · 1969", emoji: "💫"),
    ]

    @State private var favoriteIDs: Set<UUID> = []
    var body: some View {
        NavigationStack {
       List {
                sectionView(title: "Sci-Fi Movies", items: sciFiMovies)
                sectionView(title: "RPG Games",    items: rpgGames)
                sectionView(title: "Electronic",   items: electronicMusic)
                sectionView(title: "Fiction Books", items: fictionBooks)
                Section {
                    HStack {
                        Text("Total items:")
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text("\(totalCount)")
                            .bold()
                        Text("· Favorites:")
                            .foregroundStyle(.secondary)
                        Text("\(favoriteIDs.count)")
                            .bold()
                            .foregroundStyle(.red)
                    }
                    .font(.footnote)
                }
            }
            .navigationTitle("My Favorites")
            .navigationBarTitleDisplayMode(.large)
        }
    }


    @ViewBuilder
    private func sectionView(title: String, items: [FavoriteItem]) -> some View {
        Section(title) {
            ForEach(items) { item in
                ItemRow(
                    item: item,
                    isFavorite: favoriteIDs.contains(item.id),
                     onToggle: {
                        toggleFavorite(id: item.id)
                    }
                )
            }
        }
    }


    private func toggleFavorite(id: UUID) {
        if favoriteIDs.contains(id) {
            favoriteIDs.remove(id)
        } else {
            favoriteIDs.insert(id)
        }
    }


    private var totalCount: Int {
       sciFiMovies.count + rpgGames.count + electronicMusic.count + fictionBooks.count
    }
}

#Preview {
    ContentView()
}
