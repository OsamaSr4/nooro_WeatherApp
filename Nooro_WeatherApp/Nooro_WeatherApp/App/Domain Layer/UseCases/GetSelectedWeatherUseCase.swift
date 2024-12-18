//
//  GetSelectedWeatherUseCase.swift
//  Nooro_WeatherApp
//
//  Created by Osama on 18/12/2024.
//

import Foundation


protocol GetSelectedWeatherUseCaseProtocol {
    func execute(data:WeatherData) -> WeatherData?
}

class GetSelectedWeatherUseCase: GetSelectedWeatherUseCaseProtocol {
    
    
    private let repo: WeatherRepoProtocol

    init(repo: WeatherRepoProtocol) {
        self.repo = repo
    }

    func execute(data: WeatherData) -> WeatherData? {
        return repo.getCurrentWeather()
    }
    
}
