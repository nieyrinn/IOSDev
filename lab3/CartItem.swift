import Foundation

struct CartItem {
    let product: Product
    private(set) var quantity: Int
    
    init(product: Product, quantity: Int = 1) {
        self.product = product
        self.quantity = max(1, quantity)
    }
    
    var subtotal: Double {
        return product.price * Double(quantity)
    }
    
    mutating func updateQuantity(_ newQuantity: Int) {
        guard newQuantity > 0 else {
            print("Invalid quantity (\(newQuantity)). Quantity must be > 0. Keeping existing quantity: \(quantity)")
            return
        }
        quantity = newQuantity
    }
    
    mutating func increaseQuantity(by amount: Int) {
        guard amount > 0 else {
            print("Increase amount must be positive. Ignoring.")
            return
        }
        quantity += amount
    }
}
