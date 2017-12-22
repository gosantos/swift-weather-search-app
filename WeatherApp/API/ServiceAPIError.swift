import Foundation

enum ServiceAPIError: Error {
    case cityNameParseError
    case weatherDetailParseError
    case serverResponseParseError
}

extension ServiceAPIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .cityNameParseError:
            return "Cannot parse city name."
        case .serverResponseParseError:
            return "Cannot parse weather detail."
        case .weatherDetailParseError:
            return "Cannot parse API response"
        }
    }
}
