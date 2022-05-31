//
//  APIService.swift
//  PokeTeam-SwiftUI
//
//  Created by Jon Duenas on 5/24/22.
//

import Foundation

enum PokeAPIError: Error {
    case badRequest
    case invalidURL(from: String)
    case httpResponse(code: Int)
    case noDefaultVarietyFound
    case speciesDataError(Error)
    case varietyDataError(Error)
}

class PokeAPI {
    func getPokemon(with url: URL) async throws -> (pokemon: [Pokemon], nextPageURL: String?) {
        let resourceList: SpeciesResourceList = try await get(from: url)
        let pokemonData = try await getPokemonData(for: resourceList.results ?? [])
        let pokemon = pokemonData.compactMap {
            Pokemon(speciesData: $0.speciesData, varietyData: $0.varietyData)
        }.sorted(by: { $0.pokedexID < $1.pokedexID })

        return (pokemon, resourceList.next)
    }

    func get<T: Decodable>(from url: URL) async throws -> T {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse else { throw PokeAPIError.badRequest }
        guard httpResponse.statusCode == 200 else { throw PokeAPIError.httpResponse(code: httpResponse.statusCode) }

        return try decode(data: data)
    }

    private func decode<T: Decodable>(data: Data) throws -> T {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let value = try decoder.decode(T.self, from: data)
        return value
    }

    private func getPokemonData(for pokemonEntries: [NameAndURL]) async throws -> [(speciesData: PokemonSpeciesData, varietyData: PokemonVarietyData)] {
        return try await withThrowingTaskGroup(of: (PokemonSpeciesData, PokemonVarietyData).self, body: { group in
            var pokemonData = [(PokemonSpeciesData, PokemonVarietyData)]()

            for entry in pokemonEntries {
                group.addTask {
                    return try await self.getSpeciesAndVarietyData(for: entry)
                }
            }

            for try await groupData in group {
                pokemonData.append(groupData)
            }

            return pokemonData
        })
    }

    private func getSpeciesAndVarietyData(for pokemonEntry: NameAndURL) async throws -> (PokemonSpeciesData, PokemonVarietyData) {

        let speciesData = try await getSpeciesData(at: pokemonEntry.url)

        guard let varietyURLString = speciesData.varieties.first(where: { $0.isDefault })?.pokemon.url else {
            throw PokeAPIError.noDefaultVarietyFound
        }

        let varietyData = try await getVarietyData(at: varietyURLString)

        return (speciesData, varietyData)
    }

    private func getSpeciesData(at urlString: String) async throws -> PokemonSpeciesData {
        guard let url = URL(string: urlString) else { throw PokeAPIError.invalidURL(from: urlString) }

        do {
            return try await get(from: url)
        } catch {
            throw PokeAPIError.speciesDataError(error)
        }
    }

    private func getVarietyData(at urlString: String) async throws -> PokemonVarietyData {
        guard let url = URL(string: urlString) else { throw PokeAPIError.invalidURL(from: urlString) }

        do {
            return try await get(from: url)
        } catch {
            throw PokeAPIError.varietyDataError(error)
        }
    }
}
