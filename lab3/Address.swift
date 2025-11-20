import Foundation

struct Address {
    let street: String
    let city: String
    let zipCode: String
    let country: String
    
    var formattedAddress: String {
        return """
        \(street)
        \(city), \(zipCode)
        \(country)
        """
    }
}
