//
//  Pokemon.swift
//  PokeTeam-SwiftUI
//
//  Created by Jon Duenas on 5/24/22.
//

import Foundation
import SwiftUI

struct Pokemon: Identifiable {
    var id: Int { return pokedexID }
    let pokedexID: Int
    let name: String
    let height: Double
    let weight: Double
    let color: String
    let shape: String
    let flavorText: String
    let genus: String
    let habitat: String
    let spriteURL: URL
    let stats: [Stat: Int]
    let types: [PokemonType]

    var gradient: Gradient {
        let color1 = types[0].color.adjust(brightness: 0.3)
        let color2 = (types.count > 1 ? types[1].color : types[0].secondaryGradientColor).adjust(brightness: 0.3)

        return Gradient(colors: [color1, color2])
    }
}

extension Pokemon {
    init?(speciesData: PokemonSpeciesData, varietyData: PokemonVarietyData) {
        guard let nationalDexID = speciesData.nationalDexNumber else {
            return nil
        }
        pokedexID = nationalDexID
        name = speciesData.names.first(where: { $0.language.name == "en" })?.name ?? speciesData.name
        height = Double(varietyData.height) / 10
        weight = Double(varietyData.weight) / 10
        color = speciesData.color?.name ?? ""
        shape = speciesData.shape?.name ?? ""
        flavorText = speciesData.englishFlavorText ?? ""
        genus = speciesData.englishGenus ?? ""
        habitat = speciesData.habitat?.name ?? ""
        spriteURL = URL(string: varietyData.sprites.officialArtwork)!
        stats = varietyData.statsDictionary
        types = varietyData.types.compactMap { $0.pokemonType }
    }
}

extension Pokemon {
    static let example = Pokemon(
        pokedexID: 25,
        name: "Pikachu",
        height: 0.4,
        weight: 6.0,
        color: "yellow",
        shape: "quadruped",
        flavorText: "When several of these POKéMON gather, their electricity could build and cause lightning storms.",
        genus: "Mouse Pokémon",
        habitat: "forest",
        spriteURL: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png")!,
        stats: [
            .hp: 35,
            .attack: 55,
            .defense: 40,
            .specialAttack: 50,
            .specialDefense: 50,
            .speed: 90
        ],
        types: [.electric]
    )
}

enum Stat: String, CaseIterable {
    case hp
    case attack
    case defense
    case specialAttack = "special-attack"
    case specialDefense = "special-defense"
    case speed

    var shortName: String {
        switch self {
        case .hp:
            return "HP"
        case .attack:
            return "ATK"
        case .defense:
            return "DEF"
        case .specialAttack:
            return "SPA"
        case .specialDefense:
            return "SPD"
        case .speed:
            return "SPE"
        }
    }
}
