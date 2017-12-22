import Foundation
import Alamofire

class ServiceAPI {

    enum APIEndpoint {
        case weather(String)
        case xpto
        var path: String? {
            let baseURL = "http://api.openweathermap.org/data/2.5/"
            switch self {
            case .weather(let city):
                return "\(baseURL)/weather?appid=bd5e378503939ddaee76f12ad7a97608&q=\(city)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
            case .xpto:
                return "/xpto"
            }
        }
    }

    typealias Completion = (_ detail: WeatherDetail?, _ error: Error?) -> ()

    static func getWheather(cityName: String, completion: @escaping Completion) -> Void {

        guard let url = APIEndpoint.weather(cityName).path else {
            completion(nil, ServiceAPIError.cityNameParseError)
            return
        }

        Alamofire.request(url).responseJSON { (response) in
            
            if let error = response.error {
                completion(nil, error)
                return
            }
            
            if let json = response.result.value as? [String:AnyObject] {
                guard let temperature = json["main"]?["temp"] as? Float, let weather = json["weather"] as? [AnyObject], let description = weather[0]["description"] as? String else {
                    let errorMessage = json["message"] as? String ?? ""
                    completion(nil, ServiceAPIError.weatherDetailParseError(errorMessage.capitalized))
                    return
                }
                let detail = WeatherDetail(temperature: ceilf(temperature - 273), description: description)
                completion(detail, nil)
            } else {
                completion(nil, ServiceAPIError.serverResponseParseError)
            }
        }
    }
}
