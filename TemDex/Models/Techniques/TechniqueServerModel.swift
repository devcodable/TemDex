//
//  TechniqueServerModel.swift
//  TemDex
//
//  Created by dabiz on 27/12/2023.
//

import Foundation

// MARK: - TechniqueServerModel
struct TechniqueServerModel: Codable {
    let name: String
    let wikiURL: String
    let type: TypeElementServerModel
    let techniqueClass: TechniqueClassServerModel
    let classIcon: ClassIcon
    let damage, staminaCost, hold: Int
    let priority: PriorityServerModel
    let priorityIcon: PriorityIcon
    let synergy: TypeElementServerModel
    let synergyEffects: [SynergyEffectServerModel]
    let targets: TargetsServerModel
    let description, effectText, synergyText: String

    enum CodingKeys: String, CodingKey {
        case name
        case wikiURL = "wikiUrl"
        case type
        case techniqueClass = "class"
        case classIcon, damage, staminaCost, hold, priority, priorityIcon, synergy, synergyEffects, targets, description, effectText, synergyText
    }
}

enum ClassIcon: String, Codable {
    case imagesIconsTechniquePhysicalPNG = "/images/icons/technique/Physical.png"
    case imagesIconsTechniqueSpecialPNG = "/images/icons/technique/Special.png"
    case imagesIconsTechniqueStatusPNG = "/images/icons/technique/Status.png"
}

enum PriorityServerModel: String, Codable {
    case high = "high"
    case low = "low"
    case normal = "normal"
    case ultra = "ultra"
    case veryhigh = "veryhigh"
    case verylow = "verylow"
}

enum PriorityIcon: String, Codable {
    case imagesIconsPriorityHighPNG = "/images/icons/priority/high.png"
    case imagesIconsPriorityLowPNG = "/images/icons/priority/low.png"
    case imagesIconsPriorityNormalPNG = "/images/icons/priority/normal.png"
    case imagesIconsPriorityUltraPNG = "/images/icons/priority/ultra.png"
    case imagesIconsPriorityVeryhighPNG = "/images/icons/priority/veryhigh.png"
    case imagesIconsPriorityVerylowPNG = "/images/icons/priority/verylow.png"
}

// MARK: - SynergyEffect
struct SynergyEffectServerModel: Codable {
    let damage: Int
    let type: SynergyTypeServerModel
    let effect: String
}

enum SynergyTypeServerModel: String, Codable {
    case buff = "buff"
    case condition = "condition"
    case damage = "damage"
    case targeting = "targeting"
    case unknown = "unknown"
}

enum TargetsServerModel: String, Codable {
    case all = "All"
    case allOtherTemtem = "All Other Temtem"
    case empty = ""
    case otherTeamOrAlly = "Other Team or Ally"
    case singleOtherTarget = "Single Other Target"
    case singleTarget = "Single Target"
    case singleTeam = "Single Team"
    case targetsSelf = "Self"
}

enum TechniqueClassServerModel: String, Codable {
    case physical = "Physical"
    case special = "Special"
    case status = "Status"
}

// MARK: - Mapper
extension Array<TechniqueServerModel> {
    func toViewData() -> [Technique] {
        self.map {
            Technique(from: $0)
        }
    }
}
