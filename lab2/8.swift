func isPalindrome(_ text: String) -> Bool {
    var slovo = ""
        for c in text.lowercased() {
        if c.isLetter {
            slovo.append(c)
        }
    }
    return slovo == String(slovo.reversed())
}
print(isPalindrome("naffan"))   
print(isPalindrome("banana"))   

