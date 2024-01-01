//
//  TraitCardView.swift
//  TemDex
//
//  Created by dabiz on 01/01/2024.
//

import SwiftUI

struct TraitCardView: View {
    
    let trait: String
    let temtem: Temtem
    
    var body: some View {
        Image(.traitFrame)
            .renderingMode(.template)
            .resizable()
            .scaledToFit()
            .foregroundStyle(LinearGradient(colors: temtem.types.map { Color(for: .type($0)) }, startPoint: .topLeading, endPoint: .bottomTrailing))
            .overlay {
                Text(trait)
                    .font(for: .rubikBold, size: 16)
                    .foregroundStyle(traitTextColor)
            }
    }
    
    private var traitTextColor: Color {
        if temtem.types.contains(.neutral) || temtem.types.contains(.digital) {
            return Color.background
        }
        return .white
    }
}
