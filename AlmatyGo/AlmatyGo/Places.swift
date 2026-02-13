import Foundation

struct RootResponse: Codable {
    let categories: [Category]
}

struct Category: Codable {
    let id: String
    let title: String
    let places: [Place]
}

struct Place: Codable {
    let id: String
    let name: String
    let type: String
    let address: String
    let open_hours: String
    let rush_hours: String
    let price_level: Int
    let avg_price: Int
}

struct PlaceItem {
    let categoryId: String
    let categoryTitle: String
    let place: Place
}
