//
//  ContentView.swift
//  Nooro_WeatherApp
//
//  Created by Osama on 18/12/2024.
//

import SwiftUI

struct WeatherView: View {
    @StateObject private var viewModel: WeatherViewModel
    
    init(viewModel: WeatherViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
        UITextField.appearance().clearButtonMode = .always
    }
    
    var body: some View {
        ZStack {
            VStack {
                SearchBar(text: $viewModel.searchText)
                    .padding()
                
                Spacer()
                
                if viewModel.showPlaceholder {
                    PlaceHolderView()
                }
                
                else if let searchResult = viewModel.searchResult {
                    List {
                        SearchCell(
                            locationName: searchResult.location.name,
                            degree: "\(Int(searchResult.current.temp_c))",
                            iconURL: searchResult.current.condition.icon
                        )
                        .onTapGesture {
                            viewModel.saveSelectedWeather(searchResult)
                        }
                    }
                    .listStyle(PlainListStyle())
                }
                // Display Selected City
                else if let weather = viewModel.selectedWeather {
                    CityView(
                        locationName: weather.location.name,
                        degree: "\(Int(weather.current.temp_c))",
                        iconURL: weather.current.condition.icon
                    )
                    ReportView(
                        humidity: weather.current.humidity,
                        UV: weather.current.uv,
                        feelsLike: weather.current.feelslike_c
                    )
                }
                
                Spacer()
            }
            
            ToastView(
                message: viewModel.errorMessage ?? "",
                isShowing: viewModel.showToast,
                onDismiss: {
                    viewModel.dismissToast()
                }
            )
        }

    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        let repo = Services.shared.createRepoBuilder()
        let viewModel = WeatherViewModel(repo: repo)
        WeatherView(viewModel: viewModel)
    }
}
