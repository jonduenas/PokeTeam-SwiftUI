//
//  ContentView.swift
//  PokeTeam-SwiftUI
//
//  Created by Jon Duenas on 5/24/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var pokedex: Pokedex
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        Group {
            if pokedex.isLoadingFirstPage {
                HStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            } else {
                List {
                    ForEach(pokedex.allPokemon, id: \.id) { pokemon in
                        NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
                            PokemonRow(pokemon: pokemon)
                                .onAppear {
                                    pokedex.getPokemonIfNeeded(currentPokemon: pokemon)
                                }
                        }
                    }
                    if pokedex.isLoading {
                        HStack {
                            Spacer()
                            ProgressView()
                            Spacer()
                        }
                    }
                }
                .listStyle(.inset)
            }
        }
        .navigationTitle("Pokédex")
        .configureNavigationBar {
            $0.navigationBar.topItem?.backButtonDisplayMode = .minimal
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView().environmentObject(Pokedex(allPokemon: [Pokemon.example]))
        }
    }
}
