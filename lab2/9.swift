func add(_ a: Double, _ b: Double) -> Double { a + b }
func sub(_ a: Double, _ b: Double) -> Double { a - b }
func mul(_ a: Double, _ b: Double) -> Double { a * b }
func div(_ a: Double, _ b: Double) -> Double { b == 0 ? 0 : a / b }

print(add(5, 3))
print(div(10, 0))
