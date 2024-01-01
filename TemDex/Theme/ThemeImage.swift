//
//  ThemeImage.swift
//  TemDex
//
//  Created by dabiz on 21/12/2023.
//

import Foundation

enum ThemeImage {
    case type(TypeElement)
    case priority(Priority)
    case techniqueClass(TechniqueClass)
}

// MARK: - Value
extension ThemeImage {
    var value: String {
        switch self {
        case let .type(typeElement):
            return typeElement.rawValue
        case let .priority(priority):
            return priority.rawValue
        case let .techniqueClass(techniqueClass):
            return techniqueClass.rawValue
        }
    }
}
