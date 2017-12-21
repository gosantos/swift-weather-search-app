import Foundation
import Alamofire

class ServiceAPI {
    typealias Completion = (_ detail: WeatherDetail?, _ error: Error?) -> ()
    static func getWheather(cityName: String, completion: @escaping Completion) -> Void {
        
        guard let url = "http://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=bd5e378503939ddaee76f12ad7a97608".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else {
            completion(nil, NSError(domain: "ServiceAPI", code: 2, userInfo: [NSLocalizedDescriptionKey:"Cannot parse city name"]))
            return
        }
        
        print("Dispatch request for \(url)")
        Alamofire.request(url).responseJSON { (response) in
            
            if let error = response.error {
                completion(nil, error)
                return
            }
            
            if let json = response.result.value as? [String:AnyObject] {
                guard let temperature = json["main"]?["temp"] as? Float, let weather = json["weather"] as? [AnyObject], let description = weather[0]["description"] as? String else {
                    completion(nil, NSError(domain: "ServiceAPI", code: 2, userInfo: [NSLocalizedDescriptionKey:"Cannot parse weather detail"]))
                    return
                }
                let detail = WeatherDetail(temperature: temperature - 273, description: description)
                completion(detail, nil)
            } else {
                completion(nil, NSError(domain: "ServiceAPI", code: 1, userInfo: [NSLocalizedDescriptionKey:"Cannot parse response"]))
            }
        }
    }
}
