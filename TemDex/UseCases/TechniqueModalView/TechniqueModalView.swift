//
//  TechniqueModalView.swift
//  TemDex
//
//  Created by dabiz on 01/01/2024.
//

import SwiftUI

struct TechniqueModalView: View {
    
    let technique: Technique
    let sourceText: String
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                Text(technique.name)
                    .font(for: .rubikBold, size: 24)
                    .foregroundStyle(.white)
                    .padding(.bottom, 8)
                
                typeAndStatsSection
                    .padding(.bottom, 24)
                
                holdAndPrioritySection
                
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
                
                synergySection
                
                Spacer()
                
            }
        }
        .scrollIndicators(.hidden)
        .padding(.vertical, 24)
        .padding(.horizontal, 24)
        .background(Color.background.ignoresSafeArea())
    }
    
    private var typeAndStatsSection: some View {
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
    }
    
    private var holdAndPrioritySection: some View {
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
    }
    
    private var sourceSection: some View {
        HStack(alignment: .center, spacing: 8) {
            Text("Source:  ")
                .font(for: .rubikBold)
                .foregroundStyle(.white)
            +
            Text(sourceText)
                .font(for: .rubik)
                .foregroundStyle(.white)
            
            Spacer()
        }
    }
    
    @ViewBuilder
    private var synergySection: some View {
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
    }
    
    private var divider: some View {
        Divider()
            .frame(height: 2)
            .foregroundStyle(.digital)
    }
}
