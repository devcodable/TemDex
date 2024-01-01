//
//  TemtemListViewModel.swift
//  TemDex
//
//  Created by dabiz on 19/12/2023.
//

import SwiftUI

@Observable class TemtemListViewModel {
    let temtemService = TemtemService()
    var temtems: [Temtem] = []
    var traits: [Trait] = []
    var techniques: [Technique] = []
    
    func loadTemtems() async throws {
        temtems = try await temtemService.fetchTemtems().toViewData()
    }
    
    func loadTraits() async throws {
        traits = try await temtemService.fetchTraits().toViewData()
    }
    
    func loadTechniques() async throws {
        techniques = try await temtemService.fetchTechniques().toViewData()
    }
}
