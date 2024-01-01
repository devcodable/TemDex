//
//  Color+Extension.swift
//  TemDex
//
//  Created by dabiz on 21/12/2023.
//

import SwiftUI

// MARK: - Color Theme
extension Color {
    init(for color: ThemeColor) {
        self.init(color.value)
    }
}
