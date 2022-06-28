import Foundation

func ask() {
//    let maxN = Int(readLine()!) ?? 0
    let maxN = 100
    print("31.12.2020")
    fflush(stdout)
    let firstResponce = readLine()!.split(separator: " ")
    if firstResponce[0] == "!" {
        return
    }
    let amount = Int(firstResponce[1]) ?? 0
    let answer = amount / 2 + 1
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd.MM.yyyy"
    var right = dateFormatter.date(from: "31.12.2020")
    var left = dateFormatter.date(from: "01.01.1970")
    
//    let step = 86400
    for _ in 1..<maxN {
        let middle = left!.timeIntervalSince1970 + right!.timeIntervalSince(left!) / 2
        let middleDate = Date(timeIntervalSince1970: middle)
        print(dateFormatter.string(from: middleDate))
        fflush(stdout)
        let responce = readLine()!.split(separator: " ")
        if responce[0] == "!" {
            return
           }
        if Int(responce[1])! < answer {
            left = middleDate
        } else {
            right = middleDate
        }
    }
}

ask()
