import Cocoa

//declaring variables(var) and constants(let)
var greeting = "Hello, playground"
greeting = "hi"

let name = "Suyash Bel"
let name1 = "👾 a"

//values of constants(let0 never change


//printing output to screen using print() command
//changing the value of var playername
var playername = "suyash"
print(playername)

playername = "god"
print(playername)

playername = "JOD"
print(playername)

//operations on string
print(name.count)
print(name1.count)

playername = "suyash"
print(playername.uppercased())
print(playername.lowercased())


print(name.hasPrefix("Su"))
print(name.hasSuffix("Bel"))

//operations on integers

let score = 10
let highScore = score+2
let lowScore = score-2
let halfScore = score/2
print("\(highScore) ; \(lowScore) ; \(halfScore)")
var counter = 10
print(counter)
counter += 5
print(counter)

let number = 20
print(number.isMultiple(of: 2))

//Working with doubles

let a = 2.0
let b = 1.0
let c = a + b
print(c)

//Adding Int with Double

let d = 5
let e = Int(a) + d
print(e)

//storing Bool values and toggling them
var passer :Bool = true
print(passer)
var key = true
key = !key
print(key)
key = !key
print(key)

key.toggle()
print(key)

//String contacination and Interpolation

let fname = "suyash"
let lname = " belwalkar"
let age = 20
let fullName = fname + lname
print(fullName)
let namee = fname + " rajendra " + lname
print(namee)
print("Hii, my name is \(fname) and i'm \(age) years old")

print("5 x 5 is \(5*5)")

//CeckPoint 1!!! [self code]

let tempInCelsius = 10
print("The temprature is \(tempInCelsius)°")
var tempInFar = (tempInCelsius*9/5+32)
print("The temprature in farheneit is \(tempInFar)")

//Arrays

var clan = ["hells","Gate","farmers","league"]
var marks = [20,40,36,50]

//Adding items to and array
clan.append("Maghad")
marks.append(69)
print("clans are \(clan) and marks are \(marks)")
print(marks[1])

//Creating user deefined array
var scoress = Array<Int>()
scoress.append(20)
scoress.append(90)
print(scoress)

var scoress1 = [Int]()
scoress1.append(20)
scoress1.append(90)
print(scoress1)

//Basic functions
print(marks.count)

var count = marks.count
print(count)
print(marks)
marks.remove(at:2)
print(marks)
print(marks.count)

let bondMovies = ["spectare","casino royal","no time to die"]
let ans = bondMovies.contains("spectare")
print(ans)
let ans1 = bondMovies.contains("spectare2")
print(ans1)
print(marks.sorted())
print(clan.sorted())

let marks3 = [20,30,40,50]
let reversedMarks3 = marks3.reversed()
print(reversedMarks3)
print(marks3)

let lang = "Swift"
var lang2 = lang.reversed()
var lang3 = lang.sorted()
print("\(lang2) , \(lang3)")

//Dictonaries
let employee = ["name":"Suyash","job":"Devloper","company":"Apple"]
print(employee["name", default:"Unknown"])

let olympics = [
    2012 : "Brazil",
    2016 : "Tokyo",
    2021 : "India"
]
print(olympics)

//Another way to declare an array with declaring its key and value types and adding data later
var info = [String : String]()
info["manchester united"] = "Prem"
info["Juventus"] = "Seria A"
info["Real Madrid"] = "La Liga"
print(info)
var c12 = info.count
print(c12)

//Sets

let friends = (["suyash","shivam","shreyas","atharva"])
print(friends)

//Alternate way
var rm = Set<String>()
rm.insert("Vini")
rm.insert("Rodrygo")
rm.insert("Modric")
print(rm)
print(rm.contains("Vini"))
rm.sorted()
print(rm)
rm.reversed()
print(rm)

//enum (enumerations)

enum manUtd{
    case pogba,sancho,eriksen,rashford
}
var manutdPlayer = manUtd.eriksen
manutdPlayer = .pogba
manutdPlayer = manUtd.sancho
print(manutdPlayer)
