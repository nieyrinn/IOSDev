let s = ["Nazyken": 100, "Nazy": 70, "Naz": 95]
let n = Array(s.values)
let a = n.reduce(0, +) / n.count
let h = n.max()!
let l = n.min()!
print("average: \(a), highest: \(h), lowsrt: \(l)")
for (name, score) in s {
    if score >= a {
        print("\(name) above average")
    } else {
        print("\(name) below average")
    }
}
