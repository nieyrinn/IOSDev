var list: [String] = []
print ("before: \(list)")
list.append("Milk")
list.append("Eggs")
print("adding: \(list)")

if let index = list.firstIndex(of: "Milk") {
    list.remove(at: index)
}
print("removibg: \(list)")
