//
//  AppText.swift
//  Nooro_WeatherApp
//
//  Created by Osama on 18/12/2024.
//

import SwiftUI

struct TextModifier: ViewModifier {
    var fontName : AppFonts
    var fontSize: AppFontSizes
    var fontColor: AppColors
    
    func body(content: Content) -> some View {
        return content
            .font(.custom(fontName.rawValue, size: fontSize.rawValue))
            .foregroundColor(fontColor.value)
            
    }
}


struct AppText: View {
    var text: String
    var fontName: AppFonts
    var fontSize : AppFontSizes
    var appColor: AppColors
    
    var body: some View {
        Text(text)
            .modifier(
                TextModifier(
                    fontName: fontName,
                    fontSize: fontSize,
                    fontColor: appColor
                )
            )
    }
}




#Preview {
    AppText(
        text: "Mumbai",
        fontName: .bold,
        fontSize: .l_20,
        appColor: .primaryText
    )
}
