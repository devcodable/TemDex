//
//  ThemeFont.swift
//  TemDex
//
//  Created by dabiz on 22/12/2023.
//

import Foundation

enum ThemeFont: String {
    case temtemLogo = "Temfont-Regular"
    case rubik = "Rubik-Regular"
    case rubikMedium = "Rubik-Medium"
    case rubikBold = "Rubik-Bold"
    case typewriter = "JMH Typewriter"
}

extension ThemeFont {
    var defaultSize: CGFloat {
        switch self {
        case .temtemLogo:
            return 20
        case .rubik, .rubikBold, .rubikMedium:
            return 16
        case .typewriter:
            return 12
        }
    }
}
