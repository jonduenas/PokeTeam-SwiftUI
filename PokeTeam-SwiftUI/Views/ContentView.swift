//
//  ContentView.swift
//  PokeTeam-SwiftUI
//
//  Created by Jon Duenas on 5/24/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var pokedex: Pokedex

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
                        NavigationLink(destination: Text(pokemon.name)) {
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView().environmentObject(Pokedex(allPokemon: [Pokemon.example]))
        }
    }
}
