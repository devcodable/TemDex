//
//  TemtemService.swift
//  TemDex
//
//  Created by dabiz on 19/12/2023.
//

import Foundation

struct TemtemService {
    func fetchTemtems() async throws -> [TemtemServerModel] {
        let url = URL(string: "https://temtem-api.mael.tech/api/temtems".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
        
        let request = URLRequest(url: url!)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        let fetchedData = try JSONDecoder().decode([TemtemServerModel].self, from: data)
        
        return fetchedData
    }
    
    func fetchTraits() async throws -> [TraitServerModel] {
        let url = URL(string: "https://temtem-api.mael.tech/api/traits".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
        
        let request = URLRequest(url: url!)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let fetchedData = try JSONDecoder().decode([TraitServerModel].self, from: data)
        
        return fetchedData
    }
    
    func fetchTechniques() async throws -> [TechniqueServerModel] {
        let url = URL(string: "https://temtem-api.mael.tech/api/techniques".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
        
        let request = URLRequest(url: url!)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let fetchedData = try JSONDecoder().decode([TechniqueServerModel].self, from: data)
        
        return fetchedData
    }
}
