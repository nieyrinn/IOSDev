func uniq(_ text: String) -> Bool {
    var s: [Character] = []
    for c in text {
        if s.contains(c) {
            return false
        }
        s.append(c)
    }
    return true
}
print(uniq("Hello")) 
print(uniq("World")) 
