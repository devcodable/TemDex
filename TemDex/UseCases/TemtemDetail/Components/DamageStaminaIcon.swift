//
//  DamageStaminaIcon.swift
//  TemDex
//
//  Created by dabiz on 01/01/2024.
//

import SwiftUI

struct DamageStaminaIcon: View {
    
    let iconType: IconType
    let value: Int
    
    var body: some View {
        Image(.photoFrame)
            .renderingMode(.template)
            .resizable()
            .scaledToFit()
            .foregroundStyle(iconType == .stamina ? .tateruTeal : .crystal)
            .overlay {
                Text("\(value)")
                    .font(for: .rubikMedium, size: 14)
                    .foregroundStyle(.white)
            }
    }
}

extension DamageStaminaIcon {
    enum IconType {
        case damage, stamina
    }
}
