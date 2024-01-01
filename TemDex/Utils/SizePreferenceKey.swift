//
//  SizePreferenceKeys.swift
//  TemDex
//
//  Created by dabiz on 21/12/2023.
//

import SwiftUI

struct SizePreferenceKey: PreferenceKey {
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
    public static var defaultValue: CGSize = .zero
}

extension View {
    func readSize() -> some View {
        self.overlay {
            GeometryReader { proxy in
                Color.clear.preference(
                    key: SizePreferenceKey.self,
                    value: proxy.size
                )
            }
        }
    }
}
