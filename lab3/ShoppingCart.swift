import Foundation

class ShoppingCart {
    private(set) var items: [CartItem] = []
    var discountCode: String? = nil
    
    init() {}
        private func indexOfProduct(_ productId: String) -> Int? {
        return items.firstIndex { $0.product.id == productId }
    }
    
    func addItem(product: Product, quantity: Int = 1) {
        guard quantity > 0 else {
            print("Cannot add non-positive quantity: \(quantity)")
            return
        }
        if let idx = indexOfProduct(product.id) {
            var item = items[idx]
            item.increaseQuantity(by: quantity)
            items[idx] = item
        } else {
            let newItem = CartItem(product: product, quantity: quantity)
            items.append(newItem)
        }
    }
    
    func removeItem(productId: String) {
        items.removeAll { $0.product.id == productId }
    }
    
    func updateItemQuantity(productId: String, quantity: Int) {
        guard quantity >= 0 else {
            print("Quantity must be >= 0")
            return
        }
        guard let idx = indexOfProduct(productId) else { return }
        if quantity == 0 {
            removeItem(productId: productId)
        } else {
            var item = items[idx]
            item.updateQuantity(quantity)
            items[idx] = item
        }
    }
    
    func clearCart() {
        items.removeAll()
    }
    
    var subtotal: Double {
        return items.reduce(0.0) { $0 + $1.subtotal }
    }
    
    var discountAmount: Double {
        guard let code = discountCode?.uppercased() else { return 0.0 }
        switch code {
        case "SAVE10":
            return subtotal * 0.10
        case "SAVE20":
            return subtotal * 0.20
        default:
            return 0.0
        }
    }
    
    var total: Double {
        return max(0.0, subtotal - discountAmount)
    }
    
    var itemCount: Int {
        return items.reduce(0) { $0 + $1.quantity }
    }
    
    var isEmpty: Bool {
        return items.isEmpty
    }
}
