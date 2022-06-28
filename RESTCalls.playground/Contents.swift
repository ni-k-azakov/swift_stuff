import UIKit
import Foundation

func sendRequest() {
    let session = URLSession.shared
    guard let url = URL(string: "https://wyre-data.p.rapidapi.com/restaurants/town/newcastle") else { return }
    let request = NSMutableURLRequest(url: url)
    
    request.httpMethod = "GET"
    request.allHTTPHeaderFields = [
        "X-RapidAPI-Host": "wyre-data.p.rapidapi.com",
        "X-RapidAPI-Key": "8b01978092msh4ddcb0ce82bdbcdp1a067ajsn1c82239e1ba4"
    ]
    print("SENDING...")
    let task = session.dataTask(with: request as URLRequest) { data, response, error in
        guard let data = data, error == nil else {
            print("NO_DATA")
            return
        }
        do {
            let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
            print(result)
        } catch {
            print("UNDECODED")
        }
        
    }
    task.resume()
}

sendRequest()
