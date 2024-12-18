//
//  WeatherViewModel.swift
//  Nooro_WeatherApp
//
//  Created by Osama on 18/12/2024.
//

import Foundation
import Combine

class WeatherViewModel: ObservableObject {
    @Published var searchText: String = "" {
            didSet {
                if searchText.isEmpty {
                    errorMessage = nil
                }
            }
        }
    @Published var showPlaceholder: Bool = true
    @Published var searchResult: WeatherData? = nil
    @Published var selectedWeather: WeatherData? = nil
    @Published var errorMessage: String? = nil
    @Published var showToast: Bool = false // Track toast visibility

    
    private var cancellables = Set<AnyCancellable>()
    private let weatherUseCase: WeatherUseCaseProtocol
    private let saveWeatherUseCase : SaveSelectedWeatherUseCaseProtocol
    
    init(repo: WeatherRepo) {
        self.weatherUseCase = WeatherUseCase(repo:repo)
        self.saveWeatherUseCase = SaveSelectedWeatherUseCase(repo: repo)
        loadSelectedWeather()
        $searchText
            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
            .sink { [weak self] query in
                self?.fetchWeather(query: query)
            }
            .store(in: &cancellables)
    }
    
    // Fetch Weather from API
    func fetchWeather(query: String) {
        guard !query.isEmpty else {
            self.searchResult = nil
            return
        }
        
        Task {
            do {
                let result = try await weatherUseCase.execute(query: query)
                DispatchQueue.main.async {
                    self.searchResult = result
                    self.showPlaceholder = false
                    self.errorMessage = nil
                    self.showToast = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "\(error.errorDescription)"
                    self.searchResult = nil
                    self.showToast = true
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.dismissToast()
                }
            }
        }
    }
    
    // Save Selected Weather to UserDefaults
    func saveSelectedWeather(_ weather: WeatherData) {
        selectedWeather = weather
        showPlaceholder = false
        searchResult = nil
        saveWeatherUseCase.execute(data: weather)
    }
    
    // Load Saved Weather from UserDefaults
    private func loadSelectedWeather() {
        if let data : WeatherData = UserDefault.getModel(key: .currentWeather){
            selectedWeather = data
            showPlaceholder = false
        }
    }
    
    func dismissToast() {
            self.showToast = false
            self.errorMessage = nil
        }
}
