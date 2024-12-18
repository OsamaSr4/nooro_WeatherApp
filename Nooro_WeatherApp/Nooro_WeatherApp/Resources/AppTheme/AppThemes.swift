//
//  AppThemes.swift
//  Nooro_WeatherApp
//
//  Created by Osama on 18/12/2024.
//

import Foundation
import SwiftUI

enum AppFonts : String {
    case black = "Poppins-Black"
    case bold = "Poppins-Bold"
    case extraBold = "Poppins-ExtraBold"
    case exrtaLight = "Poppins-ExtraLight"
    case light = "Poppins-Light"
    case medium = "Poppins-Medium"
    case regular = "Poppins-Regular"
    case semibold = "Poppins-SemiBold"
    case thin = "Poppins-Thin"
}

enum AppFontSizes : CGFloat {
    case xxxs_10 = 10.0
    case xxs_12 = 12.0
    case xs_14 = 14.0
    case s_16 = 16.0
    case m_18 = 18.0
    case l_20 = 20.0
    case xl_22 = 22.0
    case xxl_24 = 24.0
    case xxxl_26 = 26.0
    case xxxxl_28 = 28.0
    case subHeading = 40.0
    case heading = 50.0
}

enum AppColors {
    case primaryText
    case lightText
    case secondaryText
    case background
    case grayColor
    case gradient([AppColors])
    case custom(Color)
    
    // Access color values, including custom ones from the asset catalog
    var value: Color {
        switch self {
        case .primaryText:
            return Color("PrimaryText")  // Custom color from Assets
        case .lightText:
            return Color("TextColorLight") // Custom color from Assets
        case .secondaryText :
            return Color("TextSecondaryColor")
        case .background:
            return Color("Background") // Custom color from Assets
        case .grayColor:
            return Color("GreyColor") // Custom color from Assets
        case .gradient :
            return Color("PrimaryColor")
        case .custom(let color):
            return color
        }
    }
    
    var gradientColors: [Color] {
        switch self {
        case .gradient(let colors):
            return colors.map { $0.value } // Convert AppColors to Color
        default:
            return [self.value] // Return the single color as an array
        }
    }
}


