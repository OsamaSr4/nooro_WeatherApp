//
//  WeatherRemoteDS.swift
//  Nooro_WeatherApp
//
//  Created by Osama on 18/12/2024.
//

import Foundation

protocol WeatherRemoteDSProtocol {
    func searchWeatherReport(param: RequestPararm) async throws -> WeatherData?
}

class WeatherRemoteDS {
  private let remoteStore: RemoteDataStore

  init(remoteStore: RemoteDataStore) {
    self.remoteStore = remoteStore
  }
}

extension WeatherRemoteDS : WeatherRemoteDSProtocol {
    func searchWeatherReport(param: RequestPararm) async throws -> WeatherData? {
        return try await remoteStore.request(requestPararm: param, method: .GET, responseType: WeatherData.self)
    }
    
    
}
