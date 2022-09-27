//import Foundation
//
//class Road {
//    let to: Int
//    var hasWayTo: [Int: Int] = [:]
//
//    init(to: Int) {
//        self.to = to
//    }
//}
//
//struct RoadArrays {
//    var green: [Road] = []
//    var yellow: [Road] = []
//    var red: [Road] = []
//}
//
//func findWay(from: Int, withType type: Character, in roads: [Int: RoadArrays], to endPoint: Int) -> Int {
//    var total = 0
//    guard let roadsFrom = roads[from] else { return 0 }
//    switch type {
//    case "g":
//        for road in roadsFrom.green {
//            if let roadHasWayTo = road.hasWayTo[endPoint] {
//                total += roadHasWayTo
//            } else {
//                let waysAmount = findWay(from: road.to, withType: "y", in: roads, to: endPoint)
//                total += waysAmount
//                road.hasWayTo[endPoint] = waysAmount
//            }
//        }
//    case "y":
//        for road in roadsFrom.yellow {
//            if let roadHasWayTo = road.hasWayTo[endPoint] {
//                total += roadHasWayTo
//            } else {
//                let waysAmount = findWay(from: road.to, withType: "r", in: roads, to: endPoint)
//                total += waysAmount
//                road.hasWayTo[endPoint] = waysAmount
//            }
//        }
//    case "r":
//        for road in roadsFrom.red {
//            if road.to == endPoint {
//                total += 1
//            }
//        }
//    default:
//        return 0
//    }
//    return total
//}
//
//func solve() {
//
//
//    let citiesAndRoadsAmount = readLine()!.split(separator: " ")
//        let citiesAmount = Int(citiesAndRoadsAmount[0])!
//        let roadsAmount = Int(citiesAndRoadsAmount[1])!
//        var cities: [Int: RoadArrays] = [:]
//
//        for _ in 0..<roadsAmount {
//            let input = readLine()!.split(separator: " ")
//            let from = Int(input[0])!
//            let to = Int(input[1])!
//            let type = Character(String(input[2]))
//
//            let road = Road(to: to)
//            if let _ = cities[from] {
//                switch type {
//                case "g":
//                    cities[from]!.green.append(road)
//                case "y":
//                    cities[from]!.yellow.append(road)
//                case "r":
//                    cities[from]!.red.append(road)
//                default:
//                    continue
//                }
//            } else {
//                cities[from] = RoadArrays()
//                switch type {
//                case "g":
//                    cities[from]!.green.append(road)
//                case "y":
//                    cities[from]!.yellow.append(road)
//                case "r":
//                    cities[from]!.red.append(road)
//                default:
//                    continue
//                }
//            }
//        }
//        let qAmount = Int(readLine()!)!
//
//        for _ in 0..<qAmount {
//            let question = readLine()!.split(separator: " ")
//            let from = Int(question[0])!
//            let to = Int(question[1])!
//
//            print(findWay(from: from, withType: "g", in: cities, to: to))
//        }
//}
//
//solve()

