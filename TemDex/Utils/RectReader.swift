//
//  RectReader.swift
//  TemDex
//
//  Created by dabiz on 21/12/2023.
//

import SwiftUI

extension View {
    func rectReader(for height: inout CGFloat) -> some View {
        self.background {
            GeometryReader { geometry -> AnyView in
                DispatchQueue.main.async {
                    height = geometry.size.height
                }
                Color.clear
            }
        }
    }
}

struct RectReader {
    @ViewBuilder
    private func rectReader(for height: inout CGFloat) -> some View {
        return GeometryReader { geometry -> AnyView in
            DispatchQueue.main.async {
                height = geometry.size.height
            }
            AnyView(Rectangle().fill(Color.clear))
        }
    }
}
