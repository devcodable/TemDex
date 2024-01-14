//
//  TemtemModel.swift
//  TemDex
//
//  Created by dabiz on 20/12/2023.
//

import Foundation

struct Temtem: Identifiable, Hashable {
    let id: Int
    let name: String
    let evolution: Evolution
    let types: [TypeElement]
    let portraitUrl: String
    let temtemImageUrl: String
    let temtemLumaImageUrl: String
    let temtemGifUrl: String
    let temtemLumaGifUrl: String
    let gameDescription: String
    let stats: [StatElement]
    let locations: [Location]
    let height: Int
    let weight: Int
    let traits: [String]
    let techniques: [TemtemTechnique]
}

struct Evolution: Hashable {
    let evolves: Bool
    let evolutionTree: [EvolutionTree]
}

struct EvolutionTree: Hashable {
    let id: Int
    let stage: Int
    let name: String
    let level: Int
    let evolutionType: EvolutionType
    let trading: Bool
    let traits: [String]
    let traitMapping: [String: String]
    let description: String?
}

enum EvolutionType: String, Hashable {
    case levels
    case special
}

enum TypeElement: String, Hashable, CaseIterable {
    case crystal
    case digital
    case earth
    case electric
    case fire
    case melee
    case mental
    case nature
    case neutral
    case toxic
    case water
    case wind
    
    case none
    
    static var firstHalf: [TypeElement] {
        [.crystal, .digital, .earth, .electric, .fire, .melee]
    }
    
    static var secondHalf: [TypeElement] {
        [.mental, .nature, .neutral, .toxic, .water, .wind]
    }
}

enum StatElement: Hashable {
    case hp(value: Int)
    case sta(value: Int)
    case atk(value: Int)
    case def(value: Int)
    case spatk(value: Int)
    case spdef(value: Int)
    case spd(value: Int)
    case total(value: Int)
    
    var key: String {
        switch self {
        case .hp: "hp"
        case .sta: "sta"
        case .atk: "atk"
        case .def: "def"
        case .spatk: "spatk"
        case .spdef: "spdef"
        case .spd: "spd"
        case .total: "total"
        }
    }
    
    var value: Int {
        switch self {
        case .hp(let value): value
        case .sta(let value): value
        case .atk(let value): value
        case .def(let value): value
        case .spatk(let value): value
        case .spdef(let value): value
        case .spd(let value): value
        case .total(let value): value
        }
    }
    
    var maxValue: Int {
        switch self {
        case .total: 600
        default: 200
        }
    }
}

struct Location: Hashable, Identifiable {
    let location: String
    let island: String
    let frequency: String
    let level: String
    let id = UUID()
}

struct TemtemTechnique: Hashable {
    let name: String
    let source: TechniqueSource
    let levels: Int?
}

enum TechniqueSource: String {
    case breeding = "Breeding"
    case levelling = "Levelling"
    case techniqueCourses = "Technique courses"
}

// MARK: - Mappers
extension Temtem {
    init(from api: TemtemServerModel) {
        self.id = api.number
        self.name = if let name = api.name.split(separator: " (").first { String(name) } else { api.name }
        self.evolution = Evolution(from: api.evolution)
        self.types = api.types.map { TypeElement(from: $0) }.sorted { $0.rawValue < $1.rawValue }
        self.portraitUrl = api.portraitWikiURL.replacingOccurrences(of: "55px", with: "250px")
        self.temtemImageUrl = api.wikiRenderStaticURL
        self.temtemLumaImageUrl = api.wikiRenderStaticLumaURL
        self.temtemGifUrl = api.wikiRenderAnimatedURL
        self.temtemLumaGifUrl = api.wikiRenderAnimatedLumaURL
        self.gameDescription = api.gameDescription
        self.stats = api.stats.toStatElementArray()
        self.locations = api.locations.map { Location(from: $0) }
        self.height = api.details.height.cm
        self.weight = api.details.weight.kg
        self.traits = api.traits
        self.techniques = api.techniques.map { TemtemTechnique(from: $0) }
    }
}

extension Evolution {
    init(from api: EvolutionServerModel) {
        self.evolves = api.evolves
        self.evolutionTree = api.evolutionTree?.map { EvolutionTree(from: $0) } ?? []
    }
}

extension EvolutionTree {
    init(from api: EvolutionTreeServerModel) {
        self.id = api.number
        self.stage = api.stage
        self.name = api.name
        self.level = api.level
        self.evolutionType = EvolutionType(from: api.type)
        self.trading = api.trading
        self.traits = api.traits
        self.traitMapping = api.traitMapping
        self.description = api.description
    }
}

extension EvolutionType {
    init(from api: EvolutionTreeType) {
        switch api {
        case .levels:
            self = .levels
        case .special:
            self = .special
        }
    }
}

extension TypeElement {
    init(from api: TypeElementServerModel) {
        switch api {
        case .crystal:
            self = .crystal
        case .digital:
            self = .digital
        case .earth:
            self = .earth
        case .electric:
            self = .electric
        case .fire:
            self = .fire
        case .melee:
            self = .melee
        case .mental:
            self = .mental
        case .nature:
            self = .nature
        case .neutral:
            self = .neutral
        case .toxic:
            self = .toxic
        case .water:
            self = .water
        case .wind:
            self = .wind
        case .none:
            self = .none
        }
    }
}

extension Dictionary where Key == String, Value == Int {
    func toStatElementArray() -> [StatElement] {
        var result: [StatElement] = []
        if let value = self["hp"] {
            result.append(.hp(value: value))
        }
        if let value = self["sta"] {
            result.append(.sta(value: value))
        }
        if let value = self["atk"] {
            result.append(.atk(value: value))
        }
        if let value = self["def"] {
            result.append(.def(value: value))
        }
        if let value = self["spatk"] {
            result.append(.spatk(value: value))
        }
        if let value = self["spdef"] {
            result.append(.spdef(value: value))
        }
        if let value = self["spd"] {
            result.append(.spd(value: value))
        }
        if let value = self["total"] {
            result.append(.total(value: value))
        }
        return result
    }
}

extension Location {
    init(from api: LocationServerModel) {
        self.location = api.location
        self.island = api.island.rawValue
        self.frequency = api.frequency
        self.level = api.level
    }
}

extension TemtemTechnique {
    init(from api: TemtemTechniqueServerModel) {
        self.name = api.name
        self.source = TechniqueSource(from: api.source)
        self.levels = api.levels
    }
}

extension TechniqueSource {
    init(from api: TechniqueSourceServerModel) {
        switch api {
        case .breeding:
            self = .breeding
        case .levelling:
            self = .levelling
        case .techniqueCourses:
            self = .techniqueCourses
        }
    }
}
