func fibonacci(_ n: Int) -> [Int] {
    if n <= 0 { return [] }
    if n == 1 { return [0] }
    var s = [0, 1]
    for i in 2..<n {
        s.append(s[i-1] + s[i-2])   }
    return s
}
print(fibonacci(10))
