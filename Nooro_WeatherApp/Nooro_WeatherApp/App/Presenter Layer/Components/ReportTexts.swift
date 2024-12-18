//
//  ReportTexts.swift
//  Nooro_WeatherApp
//
//  Created by Osama on 18/12/2024.
//

import SwiftUI

struct ReportTexts: View {
    var title : String
    var value : String
    
    var body: some View {
        VStack(spacing:10){
            AppText(
                text: title,
                fontName: .semibold,
                fontSize: .m_18,
                appColor: .lightText
            )
            AppText(
                text: value,
                fontName: .medium,
                fontSize: .s_16,
                appColor: .secondaryText
            )
        }
    }
}

#Preview {
    ReportTexts(title: "Humidity", value: "20%")
}
