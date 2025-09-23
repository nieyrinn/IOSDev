func CtoF(_ c: Double) -> Double { return c * 9/5 + 32 }
func CtoK(_ c: Double) -> Double { return c + 273.15 }
let value = 100.0
print("\(CtoF(value))°F")
print("\(CtoK(value))K")

