//
//  Enviroments.swift
//  Nooro_WeatherApp
//
//  Created by Osama on 18/12/2024.
//

import Foundation
public enum Environment {
  enum Keys {
    static let ROOT_URL = "ROOT_URL"
    static let API_KEY = "API_KEY"
  }

  // Get the BASE_URL
  static let ROOT_URL: String = {
    guard let baseURLProperty = Bundle.main.object(
      forInfoDictionaryKey: Keys.ROOT_URL
    ) as? String else {
      fatalError("BASE_URL not found")
    }
    return baseURLProperty
  }()
    
    static let API_KEY: String = {
      guard let baseURLProperty = Bundle.main.object(
        forInfoDictionaryKey: Keys.API_KEY
      ) as? String else {
        fatalError("API_KEY not found")
      }
      return baseURLProperty
    }()
}
