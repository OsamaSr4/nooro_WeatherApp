//
//  Nooro_WeatherAppApp.swift
//  Nooro_WeatherApp
//
//  Created by Osama on 18/12/2024.
//

import SwiftUI

@main
struct Nooro_WeatherApp: App {
    var body: some Scene {
        WindowGroup {
            let repo = Services.shared.createRepoBuilder()
            let viewModel = WeatherViewModel(repo: repo)
            WeatherView(viewModel: viewModel)
        }
    }
}
