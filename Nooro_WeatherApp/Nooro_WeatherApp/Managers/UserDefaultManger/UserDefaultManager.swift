//
//  UserDefaultManager.swift
//  Nooro_WeatherApp
//
//  Created by Osama on 18/12/2024.
//

import Foundation
enum UserDefaultsKeys: String {
  case currentWeather
}

class UserDefault {
  // MARK: Setters

  class func setModel<T: Encodable>(model: T, key: UserDefaultsKeys) {
    if let encodedData = try? JSONEncoder().encode(model) {
      UserDefaults.standard.set(encodedData, forKey: key.rawValue)
    }
  }

  class func setValue<T: Hashable>(value: T, key: UserDefaultsKeys) {
    UserDefaults.standard.setValue(value, forKey: key.rawValue)
  }

  // MARK: Getters

  class func getModel<T: Decodable>(key: UserDefaultsKeys) -> T? {
    guard let data = UserDefaults.standard.data(forKey: key.rawValue) else { return nil }
    return try? JSONDecoder().decode(T.self, from: data)
  }

  class func getStringValue(key: UserDefaultsKeys) -> String {
    return UserDefaults.standard.string(forKey: key.rawValue) ?? ""
  }

  class func getIntValue(key: UserDefaultsKeys) -> Int {
    return UserDefaults.standard.integer(forKey: key.rawValue)
  }

  class func getBoolValue(key: UserDefaultsKeys) -> Bool {
    return UserDefaults.standard.bool(forKey: key.rawValue)
  }

  class func deleteModel(key: UserDefaultsKeys) {
    UserDefaults.standard.removeObject(forKey: key.rawValue)
  }
}
