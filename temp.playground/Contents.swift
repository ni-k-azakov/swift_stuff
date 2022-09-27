func solve() {
    let input = readLine()!
    let parsed = input.split(separator: " ")
    let s = Int(parsed[0])!
    let n = Int(parsed[1])!
    var houses: [Int] = []

    for _ in 0..<n {
        houses.append(Int(readLine()!)!)
    }

    houses.sort()

    if n > 1 {
        guard houses[0] < s else {
            print(houses[n - 1] - s)
            return
        }
        guard houses[n - 1] > s else {
            print(s - houses[0])
            return
        }
        if houses[n - 1] - s > s - houses[0] {
            print((s - houses[0]) * 2 + houses[n - 1] - s)
        } else {
            print(s - houses[0] + (houses[n - 1] - s) * 2)
        }
    } else {
        print(abs(houses[0] - s))
    }
}

solve()
