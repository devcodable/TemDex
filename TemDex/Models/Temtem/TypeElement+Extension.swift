//
//  TypeElement+Extension.swift
//  TemDex
//
//  Created by dabiz on 26/12/2023.
//

import Foundation

extension TypeElement {
    
    var weaknesses: [TypeElement] {
        switch self {
        case .crystal:
            [.fire, .earth, .melee]
        case .digital:
            [.water, .electric, .digital]
        case .earth:
            [.water, .nature, .melee]
        case .electric:
            [.earth, .crystal]
        case .fire:
            [.water, .earth]
        case .melee:
            [.mental, .digital]
        case .mental:
            [.electric, .digital, .crystal]
        case .nature:
            [.fire, .toxic]
        case .neutral:
            [.mental]
        case .toxic:
            [.wind]
        case .water:
            [.nature, .electric, .toxic]
        case .wind:
            [.electric]
        case .none:
            []
        }
    }
    
    var resistances: [TypeElement] {
        switch self {
        case .crystal:
            [.electric, .mental, .toxic]
        case .digital:
            [.toxic]
        case .earth:
            [.fire, .electric, .crystal, .toxic]
        case .electric:
            [.electric, .wind]
        case .fire:
            [.fire, .nature, .crystal]
        case .melee:
            [.melee]
        case .mental:
            [.neutral, .melee]
        case .nature:
            [.water, .nature, .electric, .earth]
        case .neutral:
            []
        case .toxic:
            [.water, .nature, .toxic]
        case .water:
            [.fire, .water, .earth]
        case .wind:
            [.earth, .wind]
        case .none:
            []
        }
    }
}

extension Array<TypeElement> {
    var x025: [TypeElement] {
        guard let first = self.first, let last = self.last, first != last else {
            return []
        }
        return first.resistances.filter { type in
            last.resistances.contains(type)
        }.sorted { $0.rawValue < $1.rawValue }
    }
    
    var x05: [TypeElement] {
        var result: [TypeElement] = []
        guard let first = self.first else {
            return []
        }
        
        guard let last = self.last, first != last else {
            return first.resistances
        }
        
        result.append(contentsOf: first.resistances.filter {
            !last.resistances.contains($0) && !last.weaknesses.contains($0)
        })
        result.append(contentsOf: last.resistances.filter {
            !first.resistances.contains($0) && !first.weaknesses.contains($0)
        })
        
        return result.sorted { $0.rawValue < $1.rawValue }
    }
    
    var x2: [TypeElement] {
        var result: [TypeElement] = []
        guard let first = self.first else {
            return []
        }
        
        guard let last = self.last, first != last else {
            return first.weaknesses
        }
        
        result.append(contentsOf: first.weaknesses.filter {
            !last.weaknesses.contains($0) && !last.resistances.contains($0)
        })
        result.append(contentsOf: last.weaknesses.filter {
            !first.weaknesses.contains($0) && !first.resistances.contains($0)
        })
        
        return result.sorted { $0.rawValue < $1.rawValue }
    }
    
    var x4: [TypeElement] {
        guard let first = self.first, let last = self.last, first != last else {
            return []
        }
        return first.weaknesses.filter { type in
            last.weaknesses.contains(type)
        }.sorted { $0.rawValue < $1.rawValue }
    }
}
