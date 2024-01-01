//
//  TraitServerModel.swift
//  TemDex
//
//  Created by dabiz on 27/12/2023.
//

import Foundation

struct TraitServerModel: Codable {
    let name: String
    let wikiURL: String
    let description, effect: String

    enum CodingKeys: String, CodingKey {
        case name
        case wikiURL = "wikiUrl"
        case description, effect
    }
}

// MARK: - Mapper
extension Array<TraitServerModel> {
    func toViewData() -> [Trait] {
        self.map {
            Trait(from: $0)
        }
    }
}
