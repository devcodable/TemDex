//
//  TechniquesView.swift
//  TemDex
//
//  Created by dabiz on 27/12/2023.
//

import SwiftUI

struct TechniquesView: View {
    
    let temtem: Temtem
    let techniques: [(plain: TemtemTechnique, enhanced: Technique)]
    let selectedTechnique: (TemtemTechnique, Technique) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Techniques")
                .font(for: .rubikBold, size: 24)
                .foregroundStyle(.white)
            VStack {
                ForEach(techniques, id: \.plain) { plain, enhanced in
                    Button {
                        selectedTechnique(plain, enhanced)
                    } label: {
                        TechniqueCardView(technique: enhanced)
                    }
                }
            }
        }
    }
}
