//import Foundation
//
//let firstTime = readLine()!.split(separator: ":")
//let secondTime = readLine()!.split(separator: ":")
//let offset = Int(readLine()!)!
//
//var actHour = Int(secondTime[0])! - offset
//if actHour < 0 || actHour < Int(firstTime[0])! {
//    actHour += 24
//}
//var hourDiff = actHour - Int(firstTime[0])!
//var minuteDiff = Int(secondTime[1])! - Int(firstTime[1])!
//if minuteDiff < 0 {
//    minuteDiff += 60
//    hourDiff -= 1
//}
//
//print("\(hourDiff):\(minuteDiff < 10 ? "0" : "")\(minuteDiff)")
