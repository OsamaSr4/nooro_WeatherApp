//
//  Services.swift
//  Nooro_WeatherApp
//
//  Created by Osama on 18/12/2024.
//

import Foundation
final class Services {
    
    static var shared = Services()
    private init() {}
    let networkManager: NetworkManagerProtocol = NetworkManager()
    
    func createRepoBuilder() -> WeatherRepo {
      let store = RemoteDataStore(networkManager: networkManager)
      let remoteDS = WeatherRemoteDS(remoteStore: store)
      let localDS = WeatherLocalDS()
      return WeatherRepo(remoteDS: remoteDS, localDS: localDS)
    }
}
