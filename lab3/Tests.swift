import Foundation

@main
struct TestRunner {
    static func main() {
        // 1. Create sample products
        let laptop: Product
        let book: Product
        let headphones: Product
        do {
            laptop = try Product(id: "p-001", name: "Laptop Pro", price: 1299.99, category: .electronics, description: "Powerful laptop")
            book = try Product(id: "p-002", name: "Swift Programming", price: 39.99, category: .books, description: "Learn Swift")
            headphones = try Product(id: "p-003", name: "Headphones", price: 199.99, category: .electronics, description: "Noise cancelling")
        } catch {
            fatalError("Failed to create sample products: \(error)")
        }

        // 2. Test adding items to cart
        let cart = ShoppingCart()
        cart.addItem(product: laptop, quantity: 1)
        cart.addItem(product: book, quantity: 2)

        print("After adding laptop x1 and book x2:")
        print("Item count: \(cart.itemCount)") // expect 3
        print("Subtotal: \(cart.subtotal)")

        // 3. Test adding same product twice
        cart.addItem(product: laptop, quantity: 1)
        if let idx = cart.items.firstIndex(where: { $0.product.id == laptop.id }) {
            print("Laptop quantity after adding again: \(cart.items[idx].quantity)")
        }

        // 4. Cart totals
        print("Subtotal: \(cart.subtotal)")
        print("Item count: \(cart.itemCount)")

        // 5. Discount code
        cart.discountCode = "SAVE10"
        print("Discount amount (SAVE10): \(cart.discountAmount)")
        print("Total with discount: \(cart.total)")

        // 6. Remove items
        cart.removeItem(productId: book.id)
        print("After removing book — item count: \(cart.itemCount)")

        // 7. Reference type behavior
        func modifyCart(_ cart: ShoppingCart) {
            cart.addItem(product: headphones, quantity: 1)
        }
        modifyCart(cart)
        print("After modifyCart: itemCount = \(cart.itemCount) (should reflect change)")

        // 8. Value type behavior
        var item1 = CartItem(product: laptop, quantity: 1)
        var item2 = item1
        item2.updateQuantity(5)
        print("item1.quantity = \(item1.quantity) (should be 1)")
        print("item2.quantity = \(item2.quantity) (should be 5)")

        // 9. Create order
        let address = Address(street: "123 Main St", city: "Almaty", zipCode: "050000", country: "Kazakhstan")
        let order = Order(from: cart, shippingAddress: address)
        print("Order created: id=\(order.orderId), items=\(order.items.count), itemCount=\(order.itemCount)")

        // 10. Clear cart after order
        cart.clearCart()
        print("After clearing cart — cart.itemCount = \(cart.itemCount)")
        print("Order still has itemCount = \(order.itemCount)")

        // 11. User placing order
        let user = User(name: "Rin", email: "rin@example.com")
        user.placeOrder(order)
        print("User order history count: \(user.orderHistory.count)")
        print("User total spent: \(user.totalSpent)")
    }
}
