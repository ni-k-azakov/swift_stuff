import UIKit

var array: [[String : String]] = []
var dict = ["mem" : "mom", "kek" : "kok"]
array.append(dict)
print(dict)
print(array)
dict.removeAll()
print(dict)
print(array)

print(NSDate(timeIntervalSince1970: NSDate().timeIntervalSince1970 + Double(TimeZone.current.secondsFromGMT())))


