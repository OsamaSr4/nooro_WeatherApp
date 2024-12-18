//
//  SearchCell.swift
//  Nooro_WeatherApp
//
//  Created by Osama on 18/12/2024.
//

import SwiftUI

struct SearchCell: View {
    
    var locationName: String
    var degree :String
    var iconURL: String
    
    var body: some View {
        HStack{
            VStack(spacing:0){
                AppText(
                    text: locationName,
                    fontName: .bold,
                    fontSize: .l_20,
                    appColor: .primaryText
                )
                HStack(alignment: .top){
                    AppText(
                        text: degree,
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
            Spacer()
            AsyncImageView(
                url: iconURL,
                placeholder: Image(systemName: "photo"),
                errorImage: Image(systemName: "cloud.fill"),
                frameSize: CGSize(width: 100, height: 100)
            )
            
        }
        .padding()
        .background(AppColors.grayColor.value)
        .cornerRadius(20)
        .padding(.horizontal)
    }
}

#Preview {
    SearchCell(
        locationName: "Mumbai",
        degree: "20",
        iconURL: "https://cdn.weatherapi.com/weather/64x64/day/113.png"
    )
}
