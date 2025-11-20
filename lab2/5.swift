let s = "My names Nazyken. Im student in KBTU . kbtu kbtu"
let w = s.lowercased().split(separator: " ")
var freq: [String: Int] = [:]
for word in w {
    freq[String(word), default: 0] += 1
}
print(freq)


