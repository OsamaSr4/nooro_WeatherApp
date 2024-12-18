//
//  CityView.swift
//  Nooro_WeatherApp
//
//  Created by Osama on 18/12/2024.
//

import SwiftUI

struct CityView: View {
    var locationName: String
    var degree :String
    var iconURL: String
    
    var body: some View {
        VStack(spacing:5) {
            AsyncImageView(
                url: iconURL,
                placeholder: Image(systemName: "photo"),
                errorImage: Image(systemName: "cloud.fill"),
                frameSize: CGSize(width: 100, height: 100)
            )
            HStack() {
                AppText(
                    text: locationName,
                    fontName: .bold,
                    fontSize: .xxxxl_28,
                    appColor: .primaryText
                )
                Image(.icLocation)
            }
            HStack(alignment: .top){
                AppText(
                    text: degree ,
                    fontName: .bold,
                    fontSize: .heading,
                    appColor: .primaryText
                )
                AppText(
                    text: "°",
                    fontName: .bold,
                    fontSize: .s_16,
                    appColor: .primaryText
                )
            }
        }
    }
}

#Preview {
    CityView(
        locationName: "Hyderabad",
        degree: "31",
        iconURL: "https://cdn.weatherapi.com/weather/64x64/day/113.png"
    )
}
