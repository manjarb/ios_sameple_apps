//: Playground - noun: a place where people can play

import UIKit

//var str = "Hello, playground23"
//
//let numberOfStoplights: Int = 4
//var population: Int
//population = 5422
//
//let townName: String = "Knowhere"
//
//let townDescription = "\(townName) has population of \(population)"
//print(townDescription)

//var myFirstInt: Int = 0
//
//for _ in 1...5 {
//    myFirstInt += 1
//    print(myFirstInt)
//    
//}

//var shields = 5
//var blastersOverheating = false
//var blasterFireCount = 0

//while shields > 0 {
//    
//    if blastersOverheating {
//        print("Blasetttt")
//        sleep(5)
//        print("oeoaeao")
//        sleep(1)
//        blastersOverheating = false
//        blasterFireCount = 0
//    }
//    
//    if blasterFireCount > 100 {
//        blastersOverheating = true
//        continue
//    }
//    
//    print("FFFFF")
//    blasterFireCount += 1
//    
//}

//var bucketList = ["test"]
//bucketList.append("eeooaa")
//bucketList.append(",'.,'.")
//bucketList.append("l/r/rnstnst")
//bucketList.removeAtIndex(0)
//bucketList
//bucketList.count
//bucketList[0...2]
//bucketList[2] += "in us"
//bucketList.insert("owmv", atIndex: 2)
//bucketList

//var movieRatings = ["Donnie Darko": 4, "chcek norris":5, "dark city": 4]
//print("i readdd \(movieRatings.count) mavies")
//let darkoRating = movieRatings["Donnie Darko"]
//let oldRating: Int? = movieRatings.updateValue(5, forKey: "Donnie Darko")
////movieRatings.removeValueForKey("dark city")
//movieRatings["dark city"] = nil
//movieRatings
//
//for (key, value) in movieRatings {
//    print("The mo \(key) was rr \(value)")
//}
//
//for (key) in movieRatings.keys {
//    print("The mo \(key)")
//}
//
//let watchedMovies = Array(movieRatings.keys)

//var groceryBag = Set<String>()
//var groceryBag: Set = ["Apples","Oranges","Pineapple"]
//
//groceryBag.insert("Apples")
//groceryBag.insert("Oranges")
//groceryBag.insert("Pineapple")
//
//for food in groceryBag {
//    print(food)
//}

enum TextAlignment {
    case Left
    case Right
    case Center
    case Justify
}

var alignment = TextAlignment.Justify
//alignment = .Right

switch alignment {
    case .Left:
        print("Left al")
    case .Right:
        print("Right ali")
    case .Center:
        print("Center align")
    case .Justify:
        print("Justifyed")
}








