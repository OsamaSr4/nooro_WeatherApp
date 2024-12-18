//
//  ReportView.swift
//  Nooro_WeatherApp
//
//  Created by Osama on 18/12/2024.
//

import SwiftUI

struct ReportView: View {
    
    var humidity: Int
    var UV: Double
    var feelsLike : Double
    
    var body: some View {
        HStack{
            ReportTexts(
                title: "Humidity",
                value: "\(humidity)%"
            )
            Spacer()
            ReportTexts(
                title: "UV",
                value: "\(UV)"
            )
            Spacer()
            ReportTexts(
                title: "Feels Like",
                value: "\(feelsLike)°"
            )
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(AppColors.grayColor.value)
        .cornerRadius(20)
        .padding(.horizontal)
    }
}

#Preview {
    ReportView(
        humidity: 20,
        UV: 4.0,
        feelsLike: 38.0
    )
}
