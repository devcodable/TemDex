//
//  TraitModalView.swift
//  TemDex
//
//  Created by dabiz on 01/01/2024.
//

import SwiftUI

struct TraitModalView: View {
    
    let trait: Trait
    let temtem: Temtem
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 6) {
                Text(trait.name)
                    .font(for: .rubikBold, size: 24)
                    .foregroundStyle(.white)
                    .padding(.bottom, 24)
                
                divider
                
                Text("Description")
                    .font(for: .rubikMedium, size: 18)
                    .foregroundStyle(.white)
                Text(trait.description)
                    .font(for: .rubik)
                    .foregroundStyle(.white)
                    .fixedSize(horizontal: false, vertical: true)
                
                divider
                
                Text("Effect")
                    .font(for: .rubikMedium, size: 18)
                    .foregroundStyle(.white)
                Text(trait.effect)
                    .font(for: .rubik)
                    .foregroundStyle(.white)
                    .fixedSize(horizontal: false, vertical: true)
                
                divider
                
                HStack(alignment: .center, spacing: 12) {
                    if let traitMapping = temtem.getPreviousTraitMapping(trait: trait.name) {
                        traitSection(title: "Comes from:", traitName: traitMapping)
                    }
                    if let traitMapping = temtem.getNextTraitMapping(trait: trait.name) {
                        traitSection(title: "Evolves to:", traitName: traitMapping)
                    }
                }
            }
        }
        .scrollIndicators(.hidden)
        .padding(.vertical, 24)
        .padding(.horizontal, 24)
        .background(Color.background.ignoresSafeArea())
    }
    
    private func traitSection(title: String, traitName: String) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(for: .rubikMedium, size: 18)
                .foregroundStyle(.white)
            TraitCardView(trait: traitName, temtem: temtem)
                .frame(height: 35)
        }
    }
    
    private var divider: some View {
        Divider()
            .frame(height: 2)
            .foregroundStyle(.digital)
    }
}
