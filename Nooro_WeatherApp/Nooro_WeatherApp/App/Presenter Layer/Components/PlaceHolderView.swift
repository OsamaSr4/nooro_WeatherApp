//
//  PlaceHolderView.swift
//  Nooro_WeatherApp
//
//  Created by Osama on 18/12/2024.
//

import SwiftUI

struct PlaceHolderView: View {
    var body: some View {
        VStack(spacing:10){
            AppText(
                text: "No City Selected",
                fontName: .bold,
                fontSize: .xxxxl_28,
                appColor: .primaryText
            )
            AppText(
                text: "Please Search For A City",
                fontName: .bold,
                fontSize: .s_16,
                appColor: .primaryText
            )
        }
    }
}

#Preview {
    PlaceHolderView()
}
