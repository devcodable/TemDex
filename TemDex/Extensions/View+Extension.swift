//
//  View+Extension.swift
//  TemDex
//
//  Created by dabiz on 21/12/2023.
//

import SwiftUI

// MARK: - Hide keyboard
extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}

// MARK: - Font Theme
extension View {
    func font(for font: ThemeFont, size: CGFloat? = nil) -> some View {
        self.font(.custom(font.rawValue, size: size ?? font.defaultSize))
    }
}

// MARK: - Close button for modals
extension View {
    func closeModalButton(_ close: @escaping () -> Void) -> some View {
        self.overlay(alignment: .topTrailing) {
            Button {
                close()
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24)
                    .foregroundStyle(.white)
            }
            .padding(16)
            .shadow(color: Color.background, radius: 2)
        }
    }
}

//MARK: - Easter egg background
extension View {
    func easterBackground() -> some View {
        self.background(
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Text("made by dabiz")
                        .font(for: .typewriter)
                        .foregroundStyle(Color.digital)
                    Spacer()
                }
                Spacer()
                Spacer()
            }
                .background(Color.background.ignoresSafeArea())
        )
    }
}
