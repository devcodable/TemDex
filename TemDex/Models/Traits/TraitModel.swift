//
//  TraitModel.swift
//  TemDex
//
//  Created by dabiz on 27/12/2023.
//

import Foundation

struct Trait: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let effect: String
}

// MARK: - Mapper
extension Trait {
    init(from api: TraitServerModel) {
        self.name = api.name
        self.description = api.description
        self.effect = api.effect
    }
}
