//
//  PokemonDTO.swift
//  PokeTeam-SwiftUI
//
//  Created by Jon Duenas on 5/25/22.
//

import Foundation

struct PokedexData: Codable {
    let pokemonEntries: [PokemonEntryData]
}

struct PokemonEntryData: Codable {
    let entryNumber: Int
    let pokemonSpecies: NameAndURL
}

struct SpeciesResourceList: Codable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [NameAndURL]?
}

struct NameAndURL: Codable {
    let name: String
    let url: String
}

struct PokemonSpeciesData: Decodable {
    let id: Int
    let name: String
    let names: [NameEntry]
    let pokedexNumbers: [PokedexNumberEntry]
    let color: NameAndURL?
    let shape: NameAndURL?
    let flavorTextEntries: [FlavorTextEntry]
    let genera: [GenusEntry]
    let habitat: NameAndURL?
    let varieties: [VarietyEntry]

    var nationalDexNumber: Int? {
        return pokedexNumbers.first(where: { $0.pokedex.name == "national" })?.entryNumber
    }

    var englishFlavorText: String? {
        return flavorTextEntries.last(where: { $0.language.name == "en" })?.flavorText.trimmingCharacters(in: .newlines).replacingOccurrences(of: "\n", with: " ")
    }

    var englishGenus: String? {
        return genera.first(where: { $0.language.name == "en" })?.genus
    }
}

struct NameEntry: Decodable {
    let language: NameAndURL
    let name: String
}

struct PokedexNumberEntry: Decodable {
    let entryNumber: Int
    let pokedex: NameAndURL
}

struct FlavorTextEntry: Codable {
    let flavorText: String
    let language: NameAndURL
    let version: NameAndURL
}

struct GenusEntry: Codable {
    let genus: String
    let language: NameAndURL
}

struct VarietyEntry: Codable {
    let isDefault: Bool
    let pokemon: NameAndURL
}

struct PokemonVarietyData: Decodable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let sprites: PokemonSprites
    let stats: [StatEntry]
    let types: [PokemonTypeEntry]

    var statsDictionary: [Stat: Int] {
        return stats.reduce(into: [Stat: Int]()) {
            if let stat = Stat(rawValue: $1.statName) {
                $0[stat] = $1.baseStat
            }
        }
    }
}

struct PokemonSprites: Decodable {
    let frontDefault: String
    let frontShiny: String
    let officialArtwork: String

    enum CodingKeys: String, CodingKey {
        case frontDefault, frontShiny, other
        case officialArtwork = "official-artwork"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        frontDefault = try container.decode(String.self, forKey: .frontDefault)
        frontShiny = try container.decode(String.self, forKey: .frontShiny)
        let other = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .other)
        let officialArtworkContainer = try other.nestedContainer(keyedBy: CodingKeys.self, forKey: .officialArtwork)
        officialArtwork = try officialArtworkContainer.decode(String.self, forKey: .frontDefault)
    }
}

struct OfficialArtwork: Codable {
    let frontDefault: String
}

struct StatEntry: Decodable {
    let baseStat: Int
    let statName: String

    enum CodingKeys: String, CodingKey {
        case stat, baseStat, name
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        baseStat = try container.decode(Int.self, forKey: .baseStat)
        let stat = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .stat)
        statName = try stat.decode(String.self, forKey: .name)
    }
}

struct PokemonTypeEntry: Decodable {
    let slot: Int
    let name: String
    let url: String

    var pokemonType: PokemonType? {
        return PokemonType(name: name)
    }

    enum CodingKeys: String, CodingKey {
        case slot, type, name, url
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        slot = try container.decode(Int.self, forKey: .slot)
        let type = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .type)
        name = try type.decode(String.self, forKey: .name)
        url = try type.decode(String.self, forKey: .url)
    }
}
