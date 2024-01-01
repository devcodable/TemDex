//
//  TraitsView.swift
//  TemDex
//
//  Created by dabiz on 27/12/2023.
//

import SwiftUI

struct TraitsView: View {
    
    let temtem: Temtem
    let traits: [Trait]
    let selectedTrait: (Trait) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Traits")
                .font(for: .rubikBold, size: 24)
                .foregroundStyle(.white)
            
            HStack(alignment: .center, spacing: 12) {
                ForEach(traits) { trait in
                    Button {
                        selectedTrait(trait)
                    } label: {
                        TraitCardView(trait: trait.name, temtem: temtem)
                    }
                }
            }
        }
    }
}
