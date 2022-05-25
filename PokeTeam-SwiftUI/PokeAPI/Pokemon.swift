//
//  Pokemon.swift
//  PokeTeam-SwiftUI
//
//  Created by Jon Duenas on 5/24/22.
//

import Foundation

struct Pokemon: Decodable {
    let id: Int
    let name: Name
    let type: [PokemonType]
    let base: BaseStats

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case type
        case base
    }

    struct Name: Decodable {
        let english: String
        let japanese: String
        let chinese: String
        let french: String
    }

    struct BaseStats: Decodable {
        let hp: Int
        let attack: Int
        let defense: Int
        let spAttack: Int
        let spDefense: Int
        let speed: Int

        enum CodingKeys: String, CodingKey {
            case hp = "HP"
            case attack = "Attack"
            case defense = "Defense"
            case spAttack = "Sp. Attack"
            case spDefense = "Sp. Defense"
            case speed = "Speed"
        }
    }
}

extension Pokemon {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(Name.self, forKey: .name)
        base = try container.decode(BaseStats.self, forKey: .base)
        let typeStrings = try container.decode([String].self, forKey: .type)
        type = typeStrings.compactMap { PokemonType(name: $0) }
    }
}

extension Pokemon {
    static let example = Pokemon(
        id: 25,
        name: Name(
            english: "Pikachu",
            japanese: "ピカチュウ",
            chinese: "皮卡丘",
            french: "Pikachu"
        ),
        type: [.electric, .electric],
        base: BaseStats(
            hp: 35,
            attack: 55,
            defense: 40,
            spAttack: 50,
            spDefense: 50,
            speed: 90
        )
    )
}
