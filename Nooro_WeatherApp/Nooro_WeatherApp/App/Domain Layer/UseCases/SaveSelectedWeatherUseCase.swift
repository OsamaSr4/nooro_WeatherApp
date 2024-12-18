//
//  SaveSelectedWeatherUseCase.swift
//  Nooro_WeatherApp
//
//  Created by Osama on 18/12/2024.
//

import Foundation

protocol SaveSelectedWeatherUseCaseProtocol {
    func execute(data:WeatherData)
}

class SaveSelectedWeatherUseCase: SaveSelectedWeatherUseCaseProtocol {
    
    
    private let repo: WeatherRepoProtocol

    init(repo: WeatherRepoProtocol) {
        self.repo = repo
    }

    func execute(data: WeatherData) {
        repo.saveCurrentWeather(data)
    }
    
}
