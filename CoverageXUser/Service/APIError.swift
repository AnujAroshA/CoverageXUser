//
//  APIError.swift
//  CoverageXUser
//
//  Created by Arosha Piyadigama on 2025-08-07.
//

import Foundation
import Combine

enum APIError: Error, LocalizedError {
    case urlError, decodingError, networkError(Error)

    var errorDescription: String? {
        switch self {
        case .urlError: return "Invalid URL"
        case .decodingError: return "Failed to decode data"
        case .networkError(let err): return err.localizedDescription
        }
    }

    static func from(_ error: Error) -> APIError {
        if error is DecodingError {
            return .decodingError
        } else {
            return .networkError(error)
        }
    }
}
