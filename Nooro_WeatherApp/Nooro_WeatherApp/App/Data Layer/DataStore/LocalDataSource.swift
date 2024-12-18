//
//  LocalDataSource.swift
//  Nooro_WeatherApp
//
//  Created by Osama on 18/12/2024.
//

import Foundation

struct LocalDataStore<T: Codable> {
  private let key: UserDefaultsKeys

  init(key: UserDefaultsKeys) {
    self.key = key
  }

  func save(item: T?) {
    UserDefault.setModel(model: item, key: key)
  }

  func get() -> T? {
    if let item: T = UserDefault.getModel(key: key) {
      return item
    } else {
      return nil
    }
  }

  func delete() {
    UserDefault.deleteModel(key: key)
  }
}
