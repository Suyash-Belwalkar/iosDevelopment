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
    
//DAY 7
//FUNCTIONS

func sbel(){
    print("name is ")
    print("suyash")
}

sbel()

func tables(number:Int){
    for i in 1...10{
        print("\(i) * \(number) is \(i * number)")
    }
}

tables(number: 2)


func buyMobile(range: Int){
    switch range{
    case 0...20_000:
            print("buy xiaomi ")
    case 20_001...50_000:
        print("buy samsung")
    case 50_001...90_000:
        print("Buy iPhone")
    default:
        print("not worth buying phone of that price")
    }
}

buyMobile(range: 80000)
buyMobile(range: 95_000)


func isSame(first: String , second: String)->Bool{
    let sort1 = first.sorted()
    let sort2 = second.sorted()
    
    if sort1 == sort2{
        return true
    }else{
        return false
    }
}

print(isSame(first: "suyash", second: "atharva"))

//OR
//when a function which will return value has ONLY ONE LINE OF CODE we can skip writing `return` keyword
func isSame1(first: String,second:String)->Bool{
     first.sorted() == second.sorted()
}

print(isSame1(first: "suyash", second: "suyash"))

func pytha(side1:Double,side2:Double)->Double{
     sqrt((side1 * side1) + (side2 * side2))
}
print(pytha(side1: 3, side2: 4))


//`for` acts as a parameter tor accept value and `number` is used as an internal parameter inside of the function

//DAY 8 Default vaalue for functions and handling errors in func

// `= 12` acts as a default value for the parameter `end` if no value is provided while calling the function 12 will be the value of `end`
func timesTables(for number: Int,end:Int = 12){
    for i in 1...end{
        print("\(number) times \(i) is \(number * i)")
    }
}

timesTables(for: 2, end: 10)
timesTables(for: 2)

//Throwing Errors
enum PasswordError:Error{
    case short,easy
}
func checkPass(password:String)throws -> String{
    if password.count<5{
        throw PasswordError.short
    }
    if password == "qwert"{
        throw PasswordError.easy
    }
    if password.count>8{
        return "ok"
    }
    else if password.count>10{
        return "noicee"
    }
    else{
        return "excellent"
    }
}

let St = "sbel"

do{
    let result = try checkPass(password: St)
    print("Password security:\(result)")
}catch PasswordError.easy{
    print("there was an error")
}catch PasswordError.short{
    print("your password is short")
}catch{
    print("Pokemon catch block")
}


//CHECKPOINT 4

enum sqrtErrors:Error{
    case outOfBound , noRoot
}
func squareRoot(of nom : Int)throws ->String{
    guard nom > 1 && nom < 10000 else{
        throw sqrtErrors.outOfBound
    }
    for i in 1...100{
        if nom == i * i{
            return "\(i)"
        }
    }
    throw sqrtErrors.noRoot
}

do{
    var result1 = try squareRoot(of: 7)
    print("The root is \(result1)")
}catch sqrtErrors.outOfBound{
    print("ERROR: Enter number in range 1-10000")
}catch sqrtErrors.noRoot{
    print("no root found")
}catch{
    print("help")
}


//DAY 9 CLOUSRES

//clousres are like functions written without using func keyword assigned directly to a var or let

let greetUser={
    print("hi there")
}
//passing values to a clousre and defining return type

let greet={(name : String ) -> String in
            "hi there \(name)"
}
print(greet("suyash"))

//COPYING a func into  another var or let
func greetUser1(){
    print("hello")
}
greetUser1()

var greetCopy = greetUser1
greetCopy()

//Passing func inside a func

let team69 = ["suyash","atharva","shinde","rajat"]
let sortedTeam69 = team69.sorted()
print(sortedTeam69)

func sortedCaptain(name12: String, name22:String)->Bool{
    if name12 == "shinde"{
        return true
    }else if name22 == "shinde"{
        return false
    }
    return name12 < name22
}

//let captainSorted = team69.sorted(by: sortedCaptain)
//print(captainSorted)

//the same code can be written using closure

let captainSortC = team69.sorted(by: {(name34:String,name35:String) -> Bool in
    if name34 == "shinde"{
        return true
    }else if name35 == "shinde"{
        return false
    }
    return name34 < name35
}
)
print(captainSortC)


//CheckPoint 5
//Accept an array of integers then filter out the elements who are multiple of 2 then sort the filtered array and map it print out string with the element and msg `is a lucky number`

let luckyNumbers = [7,4,38,21,16,15,12,33,31,49]
let numberThree = [20,30,40,90,88,57,69,13,5]

//let filter = luckyNumbers.filter{%2 == 0 ? print(filter) : print("false")}

let _ = luckyNumbers
    .filter{ !$0.isMultiple(of: 2)}
    .sorted()
    .map{ print("\($0) is a lucky number")}

func solve(evolve:[Int]){
    let _ = evolve
        .filter{ !$0.isMultiple(of: 2)}
        .sorted()
        .map{ print("\($0) is a lucky number")}
}

solve(evolve: numberThree)

//func trying(first:([Int])->[Int] , second:([Int])->[Int] , third:([Int])->[String]){
//    print("Implementing filter")
//    first(luckyNumbers)
//    print("implementing sort")
//    second(luckyNumbers)
//    print("implementing mapping")
//    third(luckyNumbers)
//    print("Done!!")
//}
//
//trying {
//    luckyNumbers in
//        .filter{ !$0.isMultiple(of: 2)}
//}second: { luckyNumbers in
//        .sorted()
//}third: { luckyNumbers in
//    print("\(luckyNumbers) is a lucky number")
//}


//DAY 10
//Structures

struct Album{
    let title:String
    let artist:String
    let year:Int
    
    func printSummary()
    {
        print("\(title) is an song of \(artist) from year \(year)")
    }
}

let Kamikaze = Album(title:"kamikaze",artist:"Eminem",year:2015)

print(Kamikaze.artist)

Kamikaze.printSummary()


//Changing values of a struct by calling functions

struct Employee{
    let name:String
    var remainingVacation:Int
    
    mutating func takevacation(days:Int){
        if remainingVacation >= days{
            remainingVacation -= days
            print("i'm going on a vaccation")
            print("Your remaining vacation has \(remainingVacation) days left")
        }else{
            print("OOPSSS!!!! not enough days remaining")
        }
    }
}

var Tanmay = Employee(name: "Tanmay", remainingVacation: 15)
Tanmay.takevacation(days: 7)

//Dynamically change values using get and set
struct Emp{
    let name:String
    var vaccation = 15
    var vaccationUsed = 0
    
    var vaccationReamain : Int{
        get{
            vaccation - vaccationUsed
        }
        set{
            vaccation = vaccationUsed + newValue
        }
    }
}

var Achal = Emp(name:"achal",vaccation: 20)
print(Achal)
Achal.vaccationUsed = 10
print(Achal.vaccationReamain)
Achal.vaccationReamain = 15
print(Achal)


//Initializers

struct player70{
    let name:String
    let number:Int
    
    init(name: String) {
        self.name = name
        self.number = Int.random(in: 1...10)
    }
}

var Player = player70(name: "Ronaldo")
print(Player.number)
print(Player.self)

//DAY 11 Access controls

struct BankAccount{
    private(set) var funds = 0
    
    mutating func deposit(amt:Int){
        funds += amt
    }
    
    mutating func withdraw(amount:Int)->Bool{
        if funds>=amount{
            funds -= amount
            print("Funds withdrawn successfully")
            print("Remaining Balance is: \(funds)")
            return true
        }else{
            print("OOPPPSSS!!! not enoungh funds")
            return false
        }
    }
}

var account = BankAccount()
account.deposit(amt: 100)
print(account.funds)
account.withdraw(amount: 50)
print(account.funds)
account.withdraw(amount: 80)
print(account.funds)

//CHECKPOINT 6

struct Car{
    let model:String
    let noSeats:Int
    var gear:Int
    
    mutating func changeGear(shiftTo:Int){
        if shiftTo >= 10 || shiftTo <= 0{
            print("Invalid Gear number")
        }else{
            gear = shiftTo
            print("The Gear has been changed to \(shiftTo)")
        }
       
    }
}

var car = Car(model: "Porche 9/11", noSeats: 2, gear: 3)
print(car)
car.changeGear(shiftTo: 6)
print(car.gear)
car.changeGear(shiftTo: -1)
print(car.gear)
//car.noSeats = 4
//print(car.noSeats)


//DAY 12  CLASSES

class Team{
    var players90 = 11{
        didSet{
            print("The total numbers of players are \(players90)")
        }
    }
}

var supa = Team()
supa.players90 += 1
print(supa.players90)

//Inheritance

class empl{
    let hours:Int
    
    init(hours: Int) {
        self.hours = hours
    }
    
    func printSummury(){
        print("i just work ")
    }
    
}

class Developer:empl{
    func work(){
        print("i work \(hours) hours a day")
    }
    
    override func printSummury() {
        print("i work for \(hours) hours but also argue a lot")
    }
}

final class Manager:empl{
    func work(){
        print("i do meetings for \(hours) hours")
    }
}

var suyash50 = Developer(hours: 8)
suyash50.work()
var suyash51 = Manager(hours: 10)
suyash51.work()
suyash50.printSummury()

//override keyword enables us to make changes in func present in parent class
//final keyword is used to prohibit other classes from inheriting properties of that class

class Vehical{
    let isElectric : Bool
    
    init(isElectric: Bool) {
        self.isElectric = isElectric
    }
}

class Car59:Vehical{
    let isConvertible : Bool
    
    init(isElectric:Bool ,isConvertible: Bool) {
        self.isConvertible = isConvertible
        super.init(isElectric: isElectric)
    }
}

let teslax = Car59(isElectric: true, isConvertible: false)
print(teslax.isConvertible)
print(teslax.isElectric)

//Deinitializers

class User40{
    var id40 : Int
    
    init(id40: Int) {
        self.id40 = id40
        print("I'am user \(id40) and i'm alive")
    }
    
    deinit{
        print("I'm user \(id40) and i'm dead")
    }
}

var user = [User40]()
for i in 1...3 {
    var user43 = User40(id40: i)
    print("i'm user \(user43.id40) and i'm in control")
    user.append(user43)
}
print("Loop is finished")
user.removeAll()
print("Array is cleared")


//CHECKPOINT 7

class Animals{
    var legs :Int
    
    init(legs: Int) {
        self.legs = legs
    }
}
class Dogs:Animals{
    func speak(){
        print("BARK BARK BARK !!!!")
    }
}
class Corgi : Dogs{
    override func speak() {
        print("Corgi barks: BHAU BHAU BHAU")
    }
}
class Poodle : Dogs{
}

class Cat : Animals{
    
    var isTamed : Bool
    
    init(legs:Int ,isTamed: Bool) {
        self.isTamed = isTamed
        super.init(legs: legs)
    }
    func speak(){
        print("MEOW MEOW MEOW!!!")
    }
}
class Persian : Cat{
    override func speak() {
        print("Persian MEOW MEOW MEOW")
    }
}

class Lion : Cat{
    override func speak() {
        print("ROAR ROAAAAAARRRRR")
    }
}

var dog = Corgi(legs: 4)
dog.speak()
var dog2 = Poodle(legs: 4)
dog2.speak()
var lion = Lion(legs: 4, isTamed: false)
lion.speak()
print("\(lion.isTamed)")
var cat = Persian(legs: 4, isTamed: true)
cat.speak()

//Day 13 PROTOCOLS


protocol Vehical1{
    func estimateTime(for distance:Int)->Int
    func travel(distance:Int)
}

struct Car90 : Vehical1{
    func estimateTime(for distance: Int) -> Int {
        distance / 20
    }
    func travel(distance: Int) {
        print("I will travel \(distance)km today")
    }
    func openSunroof(){
        print("It's a beautiful day")
    }
}

struct Bicycle : Vehical1{
    func estimateTime(for distance: Int) -> Int {
        distance / 40
    }
    func travel(distance: Int) {
        print("I will travel \(distance) on my bike today")
    }
}

let car69 = Car90()
print(car69.estimateTime(for: 90))

func commute(distance:Int , using vehical:Vehical1){
    if vehical.estimateTime(for: distance) > 100{
        print("It's too slowwww!!!")
    }else{
        vehical.travel(distance: distance)
    }
}

func getEstimatesForAll(using vehicals:[Vehical1] , distance:Int){
    for vehical in vehicals {
        let estimate = vehical.estimateTime(for: distance)
        print("\(vehical) : \(estimate) hours for travelling \(distance)km")
    }
}

let car91 = Car90()
commute(distance: 90, using: car91)
let bike = Bicycle()
commute(distance: 70, using: bike)
getEstimatesForAll(using: [car91 , bike], distance: 180)



