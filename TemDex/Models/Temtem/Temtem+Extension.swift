//
//  Temtem+Extension.swift
//  TemDex
//
//  Created by dabiz on 26/12/2023.
//

import Foundation

extension Temtem {
    var number: String {
        id.toHashtag()
    }
}

extension Array<Temtem> {
    var minTotalStat: Double {
        let totalStats: [Double] = self.compactMap { temtem in
            temtem.stats.filter { stat in
                stat.key == "total"
            }.map { $0.value.toDouble() }.first
        }
        
        if let min = totalStats.min() {
            return min
        }
        
        return 0
    }
    
    var maxTotalStat: Double {
        let totalStats: [Double] = self.compactMap { temtem in
            temtem.stats.filter { stat in
                stat.key == "total"
            }.map { $0.value.toDouble() }.first
        }
        
        if let max = totalStats.max() {
            return max
        }
        
        return 500
    }
}

extension Temtem {
    func getEvolutions(from temtems: [Temtem]) -> [Temtem] {
        return Set(self.evolution.evolutionTree.compactMap { evolution in
            temtems.first(where: { temtem in
                evolution.id == temtem.id
            })
        }).sorted { t1, t2 in
            t1.id < t2.id
        }
    }
    
    func getEvolutionTree() -> EvolutionTree? {
        return self.evolution.evolutionTree.first {
            $0.id == self.id
        }
    }
    
    private func getPreviousEvolutionTree() -> EvolutionTree? {
        let selfIndex = self.evolution.evolutionTree.firstIndex {
            $0.id == self.id
        }
        if let selfIndex, (selfIndex - 1) >= 0 {
            return self.evolution.evolutionTree[selfIndex - 1]
        }
        return nil
    }
    
    func getPreviousTraitMapping(trait: String) -> String? {
        let previousEvolution = self.getPreviousEvolutionTree()
        guard let previousEvolution else {
            return nil
        }
        let mapping = previousEvolution.traitMapping.first {
            $0.value.replacingOccurrences(of: "<", with: " ").replacingOccurrences(of: ">", with: "").lowercased() == trait.lowercased()
        }
        return mapping?.key
    }
    
    func getNextTraitMapping(trait: String) -> String? {
        let selfIndex = self.evolution.evolutionTree.firstIndex {
            $0.id == self.id
        }
        guard let selfIndex, selfIndex + 1 < self.evolution.evolutionTree.count else {
            return nil
        }
        let evolutionTree = self.evolution.evolutionTree[selfIndex]
        let mapping = evolutionTree.traitMapping.first {
            $0.key.replacingOccurrences(of: "<", with: " ").replacingOccurrences(of: ">", with: "").lowercased() == trait.lowercased()
        }
        return mapping?.value
    }
    
    func getTraits(from traits: [Trait]) -> [Trait] {
        return traits.filter { trait in
            self.traits.contains { temtemTrait in
                trait.name.lowercased() == temtemTrait.replacingOccurrences(of: "<", with: " ").replacingOccurrences(of: ">", with: "").lowercased()
            }
        }
    }
    
    func getTechniques(from techniques: [Technique]) -> [(plain: TemtemTechnique, enhanced: Technique)] {
        let filteredTechniques = techniques.compactMap { technique in
            let temtemTechnique = self.techniques.first { temtemTechnique in
                technique.name.lowercased() == temtemTechnique.name.lowercased()
            }
            if let temtemTechnique {
                return (temtemTechnique, technique)
            }
            return nil
        }
        return filteredTechniques.sorted { previous, next in
            if previous.0.source == .levelling,
               next.0.source == .levelling,
               let previousLevel = previous.0.levels,
               let nextLevel = next.0.levels {
                return previousLevel <= nextLevel
            } else {
                return previous.0.source < next.0.source
            }
        }
    }
}

// MARK: - Filters
extension Array<Temtem> {
    func filterByName(searchTerm: String) -> [Temtem] {
        guard !searchTerm.isEmpty else {
            return self
        }
        return self.filter {
            $0.name.lowercased().contains(searchTerm.lowercased()) ||
            $0.evolution.evolutionTree.contains(where: {
                $0.name.lowercased().contains(searchTerm.lowercased())
            })
        }
    }
    
    func filterByType(_ types: [TypeElement]) -> [Temtem] {
        let unwrappedTypes = types.filter { $0 != .none }
        guard !unwrappedTypes.isEmpty else {
            return self
        }
        
        if unwrappedTypes.count == 2, unwrappedTypes.first == unwrappedTypes.last {
            return self.filter {
                $0.types == [unwrappedTypes.first]
            }
        }
        
        return self.filter {
            Set(unwrappedTypes).isSubset(of: Set($0.types))
        }
    }
    
    func filterByStat(_ stat: Double) -> [Temtem] {
        self.filter { temtem in
            temtem.stats.first { stat in
                stat.key == "total"
            }?.value ?? 0 >= stat.toInt()
        }
    }
}
