import Foundation

final class FavoritesStore {
    static let shared = FavoritesStore()
    private init() {}

    private let key = "favoriteIDs"

    var favoriteIDs: Set<String> {
        get { Set(UserDefaults.standard.stringArray(forKey: key) ?? []) }
        set { UserDefaults.standard.set(Array(newValue), forKey: key) }
    }

    func isFavorite(_ id: String) -> Bool {
        favoriteIDs.contains(id)
    }

    func toggle(_ id: String) {
        var set = favoriteIDs
        if set.contains(id) {
            set.remove(id)
        } else {
            set.insert(id)
        }
        favoriteIDs = set
    }
}
