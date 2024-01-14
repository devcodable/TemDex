//
//  TechniqueModel.swift
//  TemDex
//
//  Created by dabiz on 27/12/2023.
//

import Foundation

struct Technique: Identifiable {
    let id = UUID()
    let name: String
    let type: TypeElement
    let techniqueClass: TechniqueClass
    let damage: Int
    let staminaCost: Int
    let hold: Int
    let priority: Priority
    let synergy: TypeElement
    let synergyEffects: [SynergyEffect]
    let targets: Targets
    let description: String
    let effectText: String
    let synergyText: String
}

enum TechniqueClass: String {
    case physical = "physicalTechnique"
    case special = "specialTechnique"
    case status = "statusTechnique"
}

enum Priority: String {
    case high = "highPriority"
    case low = "lowPriority"
    case normal = "normalPriority"
    case ultra = "ultraPriority"
    case veryhigh = "veryHighPriority"
    case verylow = "veryLowPriority"
}

struct SynergyEffect: Hashable {
    let damage: Int
    let type: SynergyType
    let effect: String
}

enum SynergyType: String {
    case buff
    case condition
    case damage
    case targeting
    case unknown
}

enum Targets: String {
    case all = "All"
    case allOtherTemtem = "All Other Temtem"
    case empty = ""
    case otherTeamOrAlly = "Other Team or Ally"
    case singleOtherTarget = "Single Other Target"
    case singleTarget = "Single Target"
    case singleTeam = "Single Team"
    case targetsSelf = "Self"
}

// MARK: - Mappers
extension Technique {
    init(from api: TechniqueServerModel) {
        self.name = api.name
        self.type = TypeElement(from: api.type)
        self.techniqueClass = TechniqueClass(from: api.techniqueClass)
        self.damage = api.damage
        self.staminaCost = api.staminaCost
        self.hold = api.hold
        self.priority = Priority(from: api.priority)
        self.synergy = TypeElement(from: api.synergy)
        self.synergyEffects = api.synergyEffects.map { SynergyEffect(from: $0) }
        self.targets = Targets(from: api.targets)
        self.description = api.description
        self.effectText = api.effectText
        self.synergyText = api.synergyText
    }
}

extension TechniqueClass {
    init(from api: TechniqueClassServerModel) {
        switch api {
        case .physical:
            self = .physical
        case .special:
            self = .special
        case .status:
            self = .status
        }
    }
}

extension Priority {
    init(from api: PriorityServerModel) {
        switch api {
        case .high:
            self = .high
        case .low:
            self = .low
        case .normal:
            self = .normal
        case .ultra:
            self = .ultra
        case .veryhigh:
            self = .veryhigh
        case .verylow:
            self = .verylow
        }
    }
}

extension SynergyEffect {
    init(from api: SynergyEffectServerModel) {
        self.damage = api.damage
        self.type = SynergyType(from: api.type)
        self.effect = api.effect
    }
}

extension SynergyType {
    init(from api: SynergyTypeServerModel) {
        switch api {
        case .buff:
            self = .buff
        case .condition:
            self = .condition
        case .damage:
            self = .damage
        case .targeting:
            self = .targeting
        case .unknown:
            self = .unknown
        }
    }
}

extension Targets {
    init(from api: TargetsServerModel) {
        switch api {
        case .all:
            self = .all
        case .allOtherTemtem:
            self = .allOtherTemtem
        case .empty:
            self = .empty
        case .otherTeamOrAlly:
            self = .otherTeamOrAlly
        case .singleOtherTarget:
            self = .singleOtherTarget
        case .singleTarget:
            self = .singleTarget
        case .singleTeam:
            self = .singleTeam
        case .targetsSelf:
            self = .targetsSelf
        }
    }
}
