//
//  Pokedex.swift
//  PokeTeam-SwiftUI
//
//  Created by Jon Duenas on 5/27/22.
//

import Foundation

@MainActor
class Pokedex: ObservableObject {
    @Published private(set) var allPokemon: [Pokemon] = []
    @Published private(set) var canLoadMorePokemon: Bool = true
    @Published private(set) var isLoading: Bool = false

    var isLoadingFirstPage: Bool { isLoading && allPokemon.isEmpty }

    private var nextPageURLString: String?
    private let api = PokeAPI()
    private let baseURLString = "https://pokeapi.co/api/v2/pokemon-species"

    init() {
        Task {
            try? await getPokemon()
        }
    }

    init(allPokemon: [Pokemon]) {
        self.allPokemon = allPokemon
        self.canLoadMorePokemon = false
    }

    func getPokemonIfNeeded(currentPokemon pokemon: Pokemon?) async throws {
        guard let pokemon = pokemon else {
            try await getPokemon()
            return
        }

        let thresholdIndex = allPokemon.index(allPokemon.endIndex, offsetBy: -5)
        if allPokemon.firstIndex(where: { $0.id == pokemon.id }) == thresholdIndex {
            try await getPokemon()
        }
    }

    func refreshPokemon() async throws {
        allPokemon.removeAll()
        canLoadMorePokemon = true
        nextPageURLString = nil

        try await getPokemon()
    }

    private func getPokemon() async throws {
        guard canLoadMorePokemon, !isLoading else { return }
        guard let url = buildURL() else { return }

        isLoading = true
        let (newPokemon, nextPage) = try await api.getPokemon(with: url)
        allPokemon.append(contentsOf: newPokemon)
        nextPageURLString = nextPage
        if nextPage == nil {
            canLoadMorePokemon = false
        }
        isLoading = false
    }

    private func buildURL() -> URL? {
        if let nextPageURLString = nextPageURLString {
            return URL(string: nextPageURLString)
        }

        var components = URLComponents(string: baseURLString)

        let querys = [URLQueryItem(name: "limit", value: "20")]
        components?.queryItems = querys

        return components?.url
    }
}
