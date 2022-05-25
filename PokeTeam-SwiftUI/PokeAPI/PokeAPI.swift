//
//  APIService.swift
//  PokeTeam-SwiftUI
//
//  Created by Jon Duenas on 5/24/22.
//

import Foundation

class PokeAPI {
    func getPokemon() -> [Pokemon] {
        guard let url = Bundle.main.url(forResource: "pokedex", withExtension: "json") else {
            fatalError("Failed to locate pokedex.json file")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load pokedex.json from bundle")
        }

        let decoder = JSONDecoder()

        guard let pokemon = try? decoder.decode([Pokemon].self, from: data) else {
            fatalError("Failed to decode pokedex.json from bundle")
        }

        return pokemon
    }
}
