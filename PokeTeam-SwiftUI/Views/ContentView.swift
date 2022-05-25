//
//  ContentView.swift
//  PokeTeam-SwiftUI
//
//  Created by Jon Duenas on 5/24/22.
//

import SwiftUI

struct ContentView: View {
    @State private var pokemon = [Pokemon]()

    var body: some View {
        NavigationView {
            List {
                ForEach(pokemon, id: \.id) { pokemon in
                    NavigationLink(destination: Text(pokemon.name.english)) {
                        PokemonRow(pokemon: pokemon)
                    }
                }
            }
            .onAppear {
                pokemon = PokeAPI().getPokemon()
            }
            .listStyle(.inset)
            .navigationTitle("Pokédex")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
