//
//  TemtemServerModel.swift
//  TemDex
//
//  Created by dabiz on 19/12/2023.
//
import Foundation

// MARK: - TemtemServerModel
struct TemtemServerModel: Codable {
    let number: Int
    let name: String
    let types: [TypeElementServerModel]
    let portraitWikiURL: String
    let lumaPortraitWikiURL: String
    let wikiURL: String
    let stats: [String: Int]
    let traits: [String]
    let details: Details
    let techniques: [TemtemTechniqueServerModel]
    let trivia: [String]
    let evolution: EvolutionServerModel
    let wikiPortraitURLLarge: String
    let lumaWikiPortraitURLLarge: String
    let locations: [LocationServerModel]
    let icon, lumaIcon: String
    let genderRatio: GenderRatio
    let catchRate: Int
    let hatchMins: Double
    let tvYields: [String: Int]
    let gameDescription: String
    let wikiRenderStaticURL: String
    let wikiRenderAnimatedURL: String
    let wikiRenderStaticLumaURL: String
    let wikiRenderAnimatedLumaURL: String
    let renderStaticImage: String
    let renderStaticLumaImage: String
    let renderAnimatedImage: String
    let renderAnimatedLumaImage: String

    enum CodingKeys: String, CodingKey {
        case number, name, types
        case portraitWikiURL = "portraitWikiUrl"
        case lumaPortraitWikiURL = "lumaPortraitWikiUrl"
        case wikiURL = "wikiUrl"
        case stats, traits, details, techniques, trivia, evolution
        case wikiPortraitURLLarge = "wikiPortraitUrlLarge"
        case lumaWikiPortraitURLLarge = "lumaWikiPortraitUrlLarge"
        case locations, icon, lumaIcon, genderRatio, catchRate, hatchMins, tvYields, gameDescription
        case wikiRenderStaticURL = "wikiRenderStaticUrl"
        case wikiRenderAnimatedURL = "wikiRenderAnimatedUrl"
        case wikiRenderStaticLumaURL = "wikiRenderStaticLumaUrl"
        case wikiRenderAnimatedLumaURL = "wikiRenderAnimatedLumaUrl"
        case renderStaticImage, renderStaticLumaImage, renderAnimatedImage, renderAnimatedLumaImage
    }
}

// MARK: - Details
struct Details: Codable {
    let height: Height
    let weight: Weight
}

// MARK: - Height
struct Height: Codable {
    let cm, inches: Int
}

// MARK: - Weight
struct Weight: Codable {
    let kg, lbs: Int
}

// MARK: - Evolution
struct EvolutionServerModel: Codable {
    let evolves: Bool
    let stage: Int?
    let evolutionTree: [EvolutionTreeServerModel]?
    let type: EvolutionTreeType?
    let from, to: EvolutionTreeServerModel?
    let number: Int?
    let name: String?
    let level: Int?
    let trading: Bool?
    let traits: [String]?
    let traitMapping: [String: String]?
    let description: String?
}

// MARK: - EvolutionTree
struct EvolutionTreeServerModel: Codable {
    let stage: Int
    let number: Int
    let name: String
    let level: Int
    let type: EvolutionTreeType
    let trading: Bool
    let traits: [String]
    let traitMapping: [String: String]
    let description: String?
}

enum EvolutionTreeType: String, Codable {
    case levels = "levels"
    case special = "special"
}

// MARK: - GenderRatio
struct GenderRatio: Codable {
    let male, female: Int
}

// MARK: - Location
struct LocationServerModel: Codable {
    let location, place: String
    let note: Note
    let island: Island
    let frequency, level: String
    let freetem: Freetem
}

// MARK: - Freetem
struct Freetem: Codable {
    let minLevel, maxLevel: Int
    let minPansuns, maxPansuns: Int?
}

enum Island: String, Codable {
    case arbury = "Arbury"
    case cipanku = "Cipanku"
    case deniz = "Deniz"
    case kisiwa = "Kisiwa"
    case omninesia = "Omninesia"
    case pansun = "Pansun"
    case tucma = "Tucma"
}

enum Note: String, Codable {
    case dojo = "Dojo"
    case empty = ""
}

// MARK: - Technique
struct TemtemTechniqueServerModel: Codable {
    let name: String
    let source: TechniqueSourceServerModel
    let levels: Int?
}

enum TechniqueSourceServerModel: String, Codable {
    case breeding = "Breeding"
    case levelling = "Levelling"
    case techniqueCourses = "TechniqueCourses"
}

enum TypeElementServerModel: String, Codable {
    case crystal = "Crystal"
    case digital = "Digital"
    case earth = "Earth"
    case electric = "Electric"
    case fire = "Fire"
    case melee = "Melee"
    case mental = "Mental"
    case nature = "Nature"
    case neutral = "Neutral"
    case toxic = "Toxic"
    case water = "Water"
    case wind = "Wind"
    case none = "None"
}

// MARK: Mapper
extension Array<TemtemServerModel> {
    func toViewData() -> [Temtem] {
        self.map {
            Temtem(from: $0)
        }
    }
}
