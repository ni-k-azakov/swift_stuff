//import Foundation
//
//var dict: [String: [String]] = [:]
//
//var firstInput = readLine()!
//firstInput.removeLast()
//var secondInput = readLine()!
//secondInput.removeLast()
//let firstArr = firstInput.components(separatedBy: ", ")
//let secondArr = secondInput.components(separatedBy: ", ")
//
//for child in firstArr {
//    let nameSurname = child.split(separator: " ")
//    let name = String(nameSurname[0])
//    let surname = String(nameSurname[1])
//    if let _ = dict[name] {
//        dict[name]?.append(surname)
//    } else {
//        dict[name] = [surname]
//    }
//    if let _ = dict[surname] {
//        dict[surname]?.append(name)
//    } else {
//        dict[surname] = [name]
//    }
//}
//
//var hasAll = true
//for child in secondArr {
//    let nameSurname = child.split(separator: " ")
//    let name = String(nameSurname[0])
//    let surname = String(nameSurname[1])
//    if let dictSurname = dict[name] {
//        if dictSurname.contains(surname) {
//            continue
//        }
//    }
//    if let dictName = dict[surname] {
//        if dictName.contains(name) {
//            continue
//        }
//    }
//    hasAll = false
//    break
//}
//
//print(hasAll ? "YES" : "NO")
