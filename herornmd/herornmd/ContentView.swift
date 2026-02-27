import SwiftUI

struct Hero: Codable {
    let id: Int
    let name: String
    let powerstats: Powerstats
    let appearance: Appearance
    let biography: Biography
    let work: Work
    let connections: Connections
    let images: HeroImages
}

struct Powerstats: Codable {
    let intelligence: Int
    let strength: Int
    let speed: Int
    let durability: Int
    let power: Int
    let combat: Int
}

struct Appearance: Codable {
    let gender: String
    let race: String?
    let height: [String]
    let weight: [String]
    let eyeColor: String
    let hairColor: String
}

struct Biography: Codable {
    let fullName: String
    let publisher: String?
    let alignment: String
    let placeOfBirth: String
    let firstAppearance: String
}

struct Work: Codable {
    let occupation: String
    let base: String
}

struct Connections: Codable {
    let groupAffiliation: String
    let relatives: String
}

struct HeroImages: Codable {
    let lg: String
}


class HeroService {
    func fetchRandomHero() async throws -> Hero {
        let randomID = Int.random(in: 1...731)
        let url = URL(string: "https://akabab.github.io/superhero-api/api/id/\(randomID).json")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(Hero.self, from: data)
    }
}


@MainActor
@Observable
class HeroViewModel {
    var hero: Hero? = nil
    var isLoading = false
    var errorMessage: String? = nil

    private let service = HeroService()

    func loadRandomHero() async {
        isLoading = true
        errorMessage = nil
        do {
            hero = try await service.fetchRandomHero()
        } catch {
            errorMessage = "Failed to load hero. Check your connection."
        }
        isLoading = false
    }
}


struct ContentView: View {
    @State private var viewModel = HeroViewModel()

    var body: some View {
        ZStack {
            Color(.systemBackground).ignoresSafeArea()

            if viewModel.isLoading {
                LoadingView()
            } else if let message = viewModel.errorMessage {
                ErrorView(message: message) {
                    Task { await viewModel.loadRandomHero() }
                }
            } else if let hero = viewModel.hero {
                HeroDetailView(hero: hero) {
                    Task { await viewModel.loadRandomHero() }
                }
            } else {
                WelcomeView {
                    Task { await viewModel.loadRandomHero() }
                }
            }
        }
        .animation(.easeInOut(duration: 0.3), value: viewModel.hero?.id)
    }
}


struct WelcomeView: View {
    var onTap: () -> Void
    var body: some View {
        VStack(spacing: 25) {
            Image(systemName: "star.fill")
                .font(.system(size: 160))
                .foregroundStyle(.blue)
            Text("LETS\nDISCOVER\nHEROES!")
                .font(.largeTitle.bold())
            RandomizeButton(action: onTap)
        }
        .padding()
    }
}


struct LoadingView: View {
    var body: some View {
        VStack(spacing: 16) {
            ProgressView()
                .scaleEffect(1.5)
            Text("Loading hero...")
                .foregroundStyle(.secondary)
        }
    }
}


struct ErrorView: View {
    let message: String
    var onRetry: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 60))
                .foregroundStyle(.orange)

            Text("Something went wrong")
                .font(.title2.bold())

            Text(message)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)

            RandomizeButton(action: onRetry)
        }
        .padding()
    }
}


struct HeroDetailView: View {
    let hero: Hero
    var onRandomize: () -> Void

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                HeroImageHeader(imageURL: hero.images.lg, name: hero.name)

                VStack(spacing: 16) {
                    PowerstatsCard(powerstats: hero.powerstats)
                    BiographyCard(bio: hero.biography)
                    AppearanceCard(appearance: hero.appearance)
                    WorkCard(work: hero.work)
                    ConnectionsCard(connections: hero.connections)

                    RandomizeButton(action: onRandomize)
                        .padding(.bottom, 32)
                }
                .padding(.horizontal, 16)
                .padding(.top, 20)
            }
        }
        .ignoresSafeArea(edges: .top)
    }
}


struct HeroImageHeader: View {
    let imageURL: String
    let name: String

    var body: some View {
        ZStack(alignment: .bottom) {
            AsyncImage(url: URL(string: imageURL)) { phase in
                switch phase {
                case .empty:
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 420)
                        .overlay(ProgressView())
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(height: 420)
                        .clipped()
                case .failure:
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 420)
                        .overlay(
                            Image(systemName: "photo")
                                .font(.system(size: 50))
                                .foregroundStyle(.gray)
                        )
                @unknown default:
                    EmptyView()
                }
            }

            LinearGradient(
                colors: [.clear, .black.opacity(0.8)],
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(height: 160)

            Text(name)
                .font(.system(size: 36, weight: .black))
                .foregroundStyle(.white)
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(height: 420)
    }
}


struct PowerstatsCard: View {
    let powerstats: Powerstats

    private var stats: [(String, Int, Color)] {
        [
            ("Intelligence", powerstats.intelligence, .blue),
            ("Strength",     powerstats.strength,     .red),
            ("Speed",        powerstats.speed,         .green),
            ("Durability",   powerstats.durability,    .orange),
            ("Power",        powerstats.power,         .purple),
            ("Combat",       powerstats.combat,        .pink),
        ]
    }

    var body: some View {
        CardView(title: "⚡ Powerstats") {
            VStack(spacing: 10) {
                ForEach(stats, id: \.0) { name, value, color in
                    HStack {
                        Text(name)
                            .font(.subheadline)
                            .frame(width: 110, alignment: .leading)
                        ProgressView(value: Double(value), total: 100)
                            .tint(color)
                        Text("\(value)")
                            .font(.subheadline.monospacedDigit())
                            .frame(width: 32, alignment: .trailing)
                    }
                }
            }
        }
    }
}


struct BiographyCard: View {
    let bio: Biography

    var body: some View {
        CardView(title: "Biography") {
            VStack(spacing: 8) {
                InfoRow(label: "Full Name",       value: bio.fullName)
                InfoRow(label: "Publisher",       value: bio.publisher ?? "Unknown")
                InfoRow(label: "Alignment",       value: bio.alignment.capitalized)
                InfoRow(label: "Place of Birth",  value: bio.placeOfBirth)
                InfoRow(label: "First Appeared",  value: bio.firstAppearance)
            }
        }
    }
}


struct AppearanceCard: View {
    let appearance: Appearance

    var body: some View {
        CardView(title: "Appearance") {
            VStack(spacing: 8) {
                InfoRow(label: "Gender",    value: appearance.gender)
                InfoRow(label: "Race",      value: appearance.race ?? "Unknown")
                InfoRow(label: "Height",    value: appearance.height.last ?? "-")
                InfoRow(label: "Weight",    value: appearance.weight.last ?? "-")
                InfoRow(label: "Eye Color", value: appearance.eyeColor)
                InfoRow(label: "Hair",      value: appearance.hairColor)
            }
        }
    }
}


struct WorkCard: View {
    let work: Work

    var body: some View {
        CardView(title: "Work") {
            VStack(spacing: 8) {
                InfoRow(label: "Occupation", value: work.occupation)
                InfoRow(label: "Base",       value: work.base)
            }
        }
    }
}


struct ConnectionsCard: View {
    let connections: Connections

    var body: some View {
        CardView(title: "Connections") {
            VStack(spacing: 8) {
                InfoRow(label: "Group",     value: connections.groupAffiliation)
                InfoRow(label: "Relatives", value: connections.relatives)
            }
        }
    }
}


struct CardView<Content: View>: View {
    let title: String
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline)
            content
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}


struct InfoRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack(alignment: .top) {
            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
                .frame(width: 100, alignment: .leading)
            Text(value)
                .font(.caption)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}


struct RandomizeButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Label("Randomize Hero", systemImage: "shuffle")
                .font(.headline)
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity)
                .padding(15)
                .frame(width: 200, height: 50)
                .background(.blue.opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }
}


#Preview {
    ContentView()
}
