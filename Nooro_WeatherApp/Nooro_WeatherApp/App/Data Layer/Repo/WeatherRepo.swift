//
//  WeatherRepo.swift
//  Nooro_WeatherApp
//
//  Created by Osama on 18/12/2024.
//

import Foundation


enum FetchingType {
  case local
  case automatic
}

protocol WeatherRepoProtocol {
    func searchWeatherReport(param: RequestPararm) async throws -> WeatherData?
    func getCurrentWeather() -> WeatherData?
    func saveCurrentWeather(_ data: WeatherData)
    func deleteCurrentWeather()
}


class WeatherRepo : WeatherRepoProtocol {
   
    
    
    private var remoteDS : WeatherRemoteDSProtocol?
    private var localDS : WeatherLocalDSProtocol?
    
    init(remoteDS: WeatherRemoteDSProtocol, localDS: WeatherLocalDSProtocol) {
        self.remoteDS = remoteDS
        self.localDS = localDS
    }
    
    func searchWeatherReport(param: RequestPararm) async throws -> WeatherData? {
        do {
            // Attempt to fetch weather from the remote data source
            if let response = try await remoteDS?.searchWeatherReport(param: param) {
                return response
            }
        } catch {
            // If the remote request fails, attempt to fetch from the local data source
            if let localWeather = localDS?.get(key: .currentWeather) {
                return localWeather
            }
            throw error  // Rethrow the error if no local data is available
        }
        return nil
    }
    
    func getCurrentWeather() -> WeatherData? {
        let selectedWeather  = localDS?.get(key: .currentWeather)
        return selectedWeather
    }
    
    func saveCurrentWeather(_ data: WeatherData) {
        localDS?.save(weather: data)
    }
    
    
    func deleteCurrentWeather() {
        localDS?.delete(key: .currentWeather)
    }
    
    
}
