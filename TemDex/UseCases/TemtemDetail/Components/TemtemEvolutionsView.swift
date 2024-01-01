//
//  TemtemEvolutionsView.swift
//  TemDex
//
//  Created by dabiz on 26/12/2023.
//

import SwiftUI

struct TemtemEvolutionsView: View {
    
    let evolutions: [Temtem]
    
    @Binding var temtem: Temtem
    @Binding var shouldScrollToTop: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Evolutions")
                .font(for: .rubikBold, size: 24)
                .foregroundStyle(.white)
                .padding(.bottom, 4)
            
            if !evolutions.isEmpty {
                ForEach(evolutions) { temtem in
                    getEvolution(temtem)
                }
            } else {
                doesntEvolveText
            }
        }
    }
    
    @ViewBuilder
    private func getEvolution(_ temtem: Temtem) -> some View {
        if let evolutionTree = temtem.getEvolutionTree() {
            let isSelected = self.temtem.id == temtem.id
            let headerText = if let description = evolutionTree.description {
                description
            } else if evolutionTree.stage == 0 {
                "First stage"
            } else {
                "+ \(evolutionTree.level) levels"
            }
            
            Button(action: {
                withAnimation(.linear) {
                    self.temtem = temtem
                    self.shouldScrollToTop.toggle()
                }
            }, label: {
                TemtemRowView(
                    temtem: temtem,
                    evolutionText: headerText,
                    evolutionTextColor: isSelected ? .gray : .white
                )
            })
            .disabled(isSelected)
            .grayscale(isSelected ? 0.9 : 0)
        }
    }
    
    private var doesntEvolveText: Text {
        Text("This ")
            .font(for: .rubik)
            .foregroundStyle(.white)
        +
        Text("Temtem")
            .font(for: .temtemLogo, size: 18)
            .foregroundStyle(.white)
            .baselineOffset(-1)
        +
        Text(" doesn't evolve.")
            .font(for: .rubik)
            .foregroundStyle(.white)
    }
}
