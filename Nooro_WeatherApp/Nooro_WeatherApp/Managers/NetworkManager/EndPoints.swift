//
//  EndPoints.swift
//  Nooro_WeatherApp
//
//  Created by Osama on 18/12/2024.
//

import Foundation

enum Domain {
  private enum Services {
    static let baseurl = Environment.ROOT_URL
    static let apiKey = Environment.API_KEY
  }
    static func completeUrl(endPoints: EndPoints) -> String {
      return Services.baseurl + endPoints.rawValue
    }
    
    static func getApiKey() -> String {
        return Services.apiKey
    }
}

enum EndPoints {
    case getCurrent
    
    var rawValue: String {
        switch self {
        case .getCurrent:
            return "/current.json"
        }
    }
}
