//
//  WeatherLocalDS.swift
//  Nooro_WeatherApp
//
//  Created by Osama on 18/12/2024.
//

import Foundation
protocol WeatherLocalDSProtocol {
    func save(weather : WeatherData)
    func get(key: UserDefaultsKeys) -> WeatherData?
    func delete(key:UserDefaultsKeys)
//    func update(weather:WeatherData)
}

struct WeatherLocalDS : WeatherLocalDSProtocol {
    let weatherStore = LocalDataStore<WeatherData>(key: .currentWeather)
    
    func save(weather: WeatherData) {
        delete(key: .currentWeather)
        weatherStore.save(item: weather)
    }
    
    func get(key: UserDefaultsKeys) -> WeatherData? {
        return weatherStore.get()
    }
    
    func delete(key: UserDefaultsKeys) {
        weatherStore.delete()
    }
    
//    func update(weather: WeatherData) {
//        delete(key: .currentWeather)
//        save(weather: weather)
//    }
    
    
}
