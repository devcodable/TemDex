//
//  TechniqueCardView.swift
//  TemDex
//
//  Created by dabiz on 01/01/2024.
//

import SwiftUI

struct TechniqueCardView: View {
    
    let technique: Technique
    
    var body: some View {
        frameImage
            .overlay(alignment: .leading, content: {
                HStack(spacing: 4) {
                    Rectangle()
                        .foregroundStyle(Color(for: .type(technique.type)))
                        .frame(width: 40, height: 100)
                    ForEach(0..<technique.hold, id: \.self) { _ in
                        Rectangle()
                            .foregroundStyle(Color(for: .type(technique.type)))
                            .frame(width: 8, height: 100)
                    }
                }
                .rotationEffect(Angle(degrees: 30))
                .offset(x: -20)
            })
            .mask {
                frameImage
            }
            .overlay {
                HStack(spacing: 6) {
                    Text(technique.name)
                        .font(for: .rubikBold, size: 16)
                        .foregroundStyle(.white)
                    if technique.synergy != .none {
                        Text("+")
                            .font(for: .rubikBold, size: 16)
                            .foregroundStyle(.white)
                    }
                }
            }
            .overlay(alignment: .trailing) {
                DamageStaminaIcon(iconType: .stamina, value: technique.staminaCost)
                    .frame(height: 24)
                    .padding(.trailing, 12)
            }
    }
    
    private var frameImage: some View {
        Image(.traitFrame)
            .resizable()
            .frame(height: 44)
    }
}
