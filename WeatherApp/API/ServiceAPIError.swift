import Foundation

enum ServiceAPIError: Error {
    case cityNameParseError
    case weatherDetailParseError(String)
    case serverResponseParseError
}

extension ServiceAPIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .cityNameParseError:
            return "Cannot parse city name."
        case .serverResponseParseError:
            return "Cannot parse weather detail."
        case .weatherDetailParseError(let message):
            return "Cannot parse API response. \(message)"
        }
    }
}
