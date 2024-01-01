//
//  TechniqueModalView.swift
//  TemDex
//
//  Created by dabiz on 01/01/2024.
//

import SwiftUI

struct TechniqueModalView: View {
    
    let technique: Technique
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                Text(technique.name)
                    .font(for: .rubikBold, size: 24)
                    .foregroundStyle(.white)
                    .padding(.bottom, 8)
                
                HStack(alignment: .center, spacing: 12) {
                    TypeCapsuleView(typeElement: technique.type)
                    
                    Image(for: .techniqueClass(technique.techniqueClass))
                        .resizable()
                        .scaledToFit()
                        .frame(height: 32)
                    
                    Spacer()
                    
                    DamageStaminaIcon(iconType: .damage, value: technique.damage)
                        .frame(height: 32)
                    DamageStaminaIcon(iconType: .stamina, value: technique.staminaCost)
                        .frame(height: 32)
                }
                .padding(.bottom, 24)
                
                HStack(alignment: .center, spacing: 8) {
                    Text("Hold:  ")
                        .font(for: .rubikBold)
                    +
                    Text("\(technique.hold)")
                        .font(for: .rubik)
                    
                    Spacer()
                    
                    Image(for: .priority(technique.priority))
                        .resizable()
                        .scaledToFit()
                        .frame(height: 32)
                }
                
                sourceSection
                
                divider
                
                Text("Description")
                    .font(for: .rubikMedium, size: 18)
                    .foregroundStyle(.white)
                Text(technique.description)
                    .font(for: .rubik)
                    .foregroundStyle(.white)
                    .fixedSize(horizontal: false, vertical: true)
                
                divider
                
                Text("Effect")
                    .font(for: .rubikMedium, size: 18)
                    .foregroundStyle(.white)
                Text(technique.effectText)
                    .font(for: .rubik)
                    .foregroundStyle(.white)
                    .fixedSize(horizontal: false, vertical: true)
                
                if technique.synergy != .none {
                    divider
                    HStack(spacing: 6) {
                        Text("Synergy")
                            .font(for: .rubikMedium, size: 18)
                            .foregroundStyle(.white)
                        Image(for: .type(technique.synergy))
                            .resizable()
                            .scaledToFit()
                            .frame(height: 32)
                        
                        Spacer()
                    }
                    Text(technique.synergyText)
                        .font(for: .rubik)
                        .foregroundStyle(.white)
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                Spacer()
                
            }
        }
        .scrollIndicators(.hidden)
        .padding(.vertical, 24)
        .padding(.horizontal, 24)
        .background(Color.background.ignoresSafeArea())
    }
    
    @ViewBuilder
    private var sourceSection: some View {
        if let source = technique.source {
            var sourceText: String = if let levels = technique.levels, source == .levelling {
                "\(levels) levels"
            } else {
                source.rawValue
            }
            
            HStack(alignment: .center, spacing: 8) {
                Text("Source:  ")
                    .font(for: .rubikBold)
                +
                Text(sourceText)
                    .font(for: .rubik)
                
                Spacer()
            }
        }
    }
    
    private var divider: some View {
        Divider()
            .frame(height: 2)
            .foregroundStyle(.digital)
    }
}
