//
//  Image+Extension.swift
//  TemDex
//
//  Created by dabiz on 21/12/2023.
//

import SwiftUI

// MARK: - Image Theme
extension Image {
    init(for image: ThemeImage) {
        self.init(image.value)
    }
}
