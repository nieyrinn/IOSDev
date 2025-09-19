//step1
var firstName = "Nazyken"
var lastName = "Amanzholova"
var birthYear: Int = 2006
var isStudent = true
var height: Double = 1.67

//Bonus1
let currentYear: Int = 2025
var age = currentYear - birthYear

//step2
var hobby = "Coding"
var numberOfHobbies = 3
var favoriteNumber = 8
var isHobbyCreative = true

//some more details
var friend = "Alina"
var favoriteFood = "Besh"
var isInAlmaty = true

//step3
let text = """

Hello, My name is \(firstName) \(lastName)! I am \(age) years old. My height is \(height) cm and I am currently \(isStudent ? "a" : "not a") student, 
I have \(numberOfHobbies) hobbies, one of them is \(hobby), which is \(isHobbyCreative ? "requires" : "not requires") creativity. 
I love eating \(favoriteFood) with my friend \(friend). My favorite number is \(favoriteNumber) and Im living \(isInAlmaty ? "in Almaty" : "in other city").
"""

//step4
print(text)

//bonus
var studyGoal = "upper scolarship"
var futureGoal = "IOS developer💻"
var 💻 = "games"

print("""
In future,I want to get \(studyGoal) and become \(futureGoal) also create some \(💻)  
I know that it will be hard, but doest mind if u want it and try hard😙

""")