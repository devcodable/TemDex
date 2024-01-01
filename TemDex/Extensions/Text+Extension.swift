//
//  Text+Extension.swift
//  TemDex
//
//  Created by dabiz on 22/12/2023.
//

import SwiftUI

// MARK: - Font Theme
extension Text {
    func font(for font: ThemeFont, size: CGFloat? = nil) -> Text {
        self.font(.custom(font.rawValue, size: size ?? font.defaultSize))
    }
}
