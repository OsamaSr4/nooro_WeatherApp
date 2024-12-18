//
//  WeatherUseCase.swift
//  Nooro_WeatherApp
//
//  Created by Osama on 18/12/2024.
//

import Foundation

protocol WeatherUseCaseProtocol {
    func execute(query: String) async throws -> WeatherData?
}

class WeatherUseCase: WeatherUseCaseProtocol {
    private let repo: WeatherRepoProtocol

    init(repo: WeatherRepoProtocol) {
        self.repo = repo
    }

    func execute(query: String) async throws -> WeatherData? {
        let param = RequestPararm(path: .getCurrent, queryParams: ["q": query])
        return try await repo.searchWeatherReport(param: param)
    }
}
