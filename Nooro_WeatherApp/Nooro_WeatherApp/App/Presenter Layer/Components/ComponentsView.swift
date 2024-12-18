//
//  ComponentsView.swift
//  Nooro_WeatherApp
//
//  Created by Osama on 18/12/2024.
//

import SwiftUI

struct ComponentsView: View {
    var body: some View {
        VStack (spacing: 10){
            SearchBar(text: .constant(""))
            Spacer()
            PlaceHolderView()
            ReportView(
                humidity: 40,
                UV: 4.0,
                feelsLike: 38.0
            )
            CityView(
                locationName: "Hyderaboad",
                degree: "31",
                iconURL: "https://cdn.weatherapi.com/weather/64x64/day/113.png"
            )
            SearchCell(
                locationName: "Mumbai",
                degree: "21",
                iconURL: "https://cdn.weatherapi.com/weather/64x64/day/113.png"
            )
            Spacer()
            
        }
        .padding()
    }
}

#Preview {
    ComponentsView()
}
