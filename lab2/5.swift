let s = "Hello hello world world world"
let w = s.lowercased().split(separator: " ")
var freq: [String: Int] = [:]

for word in w {
    freq[String(word), default: 0] += 1
}
print(freq)
