//
//  Extensions + Error.swift
//  Nooro_WeatherApp
//
//  Created by Osama on 18/12/2024.
//

import Foundation
extension Error {
  var errorDescription: String {
    // Check if the error is of type AppError
    if let appError = self as? NetworkError {
        switch appError {
        case .invalidURL,.invalidResponse,.noData:
            return localizedDescription
        case .decodingFailed( _):
            return "Something Went Wrong"
        case .network(let error):
            return  error.localizedDescription
        case .apiError(_, let message):
            return message
        case .unknownError:
            return "Unknown Error"
        case .networkError:
            return "No Internet Connection Avaliable"
        }
    } else {
      // For other types of errors, return a generic message
      return "Something Went Wrong"
    }
  }
}
