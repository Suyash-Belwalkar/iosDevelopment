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


var teams=["napoli","elche","napoli","barca","real madrid","bayern"]
var size=teams.count
print(size)

var teams1=Set(teams)
print(teams1.count)

//Day 5  CONDITIONS and SWITCH statements

var mrks = 70

if mrks>80{
    print ("distinction")
}else{
    print("behhh")
}

var myname = "a"
var friendname = "b"

if myname>friendname{
    print("ohhh")
}else{
    print("nooo")
}

var username = ""

if username.isEmpty == false{
    print("welcome \(username).")
}else{
    print("please set your username!!!")
}

enum amigos{
    case suyash, atharva , shivendra, rajat ,aryan
}

var player = amigos.suyash

if player == .atharva{
    print("he is the captain")
}else if player == .aryan{
    print("he is the defender")
}else if player == .rajat{
    print("he is the keeper")
}else {
    print("he is a strikerrr")
}


var temp123 = 50
var temp = 20

if temp123<51 && temp>21{
    print("good day")
}else if temp123>49{
    print("its hot")
}else if temp<21{
    print("its cold")
}


if temp123<51 || temp>21{
    print("good day")
}else if temp123>49{
    print("its hot")
}else if temp<21{
    print("its cold")
}


//SWITCH statements

enum amigos12{
    case suyash,atharva,aryan,rajat
}

let player5 = amigos12.atharva

switch player5{
case .aryan:
    print("he is a defender")
case .atharva:
    print("he is the captain")
    fallthrough
case .suyash:
    print("he is a striker")
case .rajat:
    print("he is the goalkeeper")
default:
    print("not a player of amigos fc")
}

//TERNARY OPERATOR

let hour = 18

let greetings = hour>=12 ? "good afternoon" : "good morning"
print(greetings)

enum Theme{
    case dark,light
}

var style = Theme.dark

var background = style == .dark ? "dark" : "light"
print(background)

//DAY 6
//LOOPS

//FOR LOOPS

var nah = [1,2,3,4,5]
for i in nah{
    if i.isMultiple(of: 2){
        print(i)
    }
}

var com = "eee mes MESSIII"
print(com)
for _ in 1...5{
    print("ankara messi")
}

//WHILE LOOPS
var num = 0
while num<5{
    print("ronaldo")
    num += 1
}

//WORKING WITH RANDOM INT RANGE
var roll = 0
while roll != 20{
    roll = Int.random(in: 1...30)
    print(roll)
}
print("FINAALLYYY INNNER PEACE")

//CHECKPOINT 3 day 6
//SELF CODE
// Q. THE FIZZBUZZ PROBLEM
//in range 1-100 print fizz if multiple of 3 print buzz if multiple of 5 and print FizzBuzz if multipe of both

for i in 1...100{
    if i.isMultiple(of: 3){
        if i.isMultiple(of: 5){
            print("FizzBuzz")
        }else{
            print("Fizz")
        }
    }
    else if i.isMultiple(of: 5){
            print("Buzz")
    }
    else{
        print(i)
    }
}
    
