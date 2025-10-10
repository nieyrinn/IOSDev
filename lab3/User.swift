import Foundation

class User {
    let userId: String
    let name: String
    let email: String
    private(set) var orderHistory: [Order] = []
    
    init(userId: String = UUID().uuidString, name: String, email: String) {
        self.userId = userId
        self.name = name
        self.email = email
    }
    
    func placeOrder(_ order: Order) {
        orderHistory.append(order)
    }
    
    var totalSpent: Double {
        return orderHistory.reduce(0.0) { $0 + $1.total }
    }
}
