import Foundation

enum ProductError: Error {
    case invalidPrice(Double)
    case invalidId
}

struct Product {
    let id: String
    let name: String
    let price: Double
    let category: Category
    let description: String
    
    enum Category: String, Codable {
        case electronics, clothing, food, books
    }
    
    var displayPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter.string(from: NSNumber(value: price)) ?? String(format: "$%.2f", price)
    }
    
    init(id: String, name: String, price: Double, category: Category, description: String = "") throws {
        guard !id.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            throw ProductError.invalidId
        }
        guard price >= 0 else {
            throw ProductError.invalidPrice(price)
        }
        self.id = id
        self.name = name
        self.price = price
        self.category = category
        self.description = description
    }
}
