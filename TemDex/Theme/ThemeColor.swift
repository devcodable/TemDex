//
//  ThemeColor.swift
//  TemDex
//
//  Created by dabiz on 21/12/2023.
//

import Foundation

enum ThemeColor {
    case background
    case temtemLogoBottom
    case temtemLogoTop
    case temtemBackground
    case type(TypeElement)
}

// MARK: - Value
extension ThemeColor {
    var value: String {
        switch self {
        case .background:
            return "background"
        case .temtemLogoBottom:
            return "temtemLogoBottom"
        case .temtemLogoTop:
            return "temtemLogoTop"
        case .temtemBackground:
            return "temtemBackground"
        case let .type(typeElement):
            return typeElement.rawValue
        }
    }
}
