//
//  PokemonDetailView.swift
//  PokeTeam-SwiftUI
//
//  Created by Jon Duenas on 5/31/22.
//

import SwiftUI

struct PokemonDetailView: View {
    let pokemon: Pokemon

    var body: some View {
        ScrollView {
            VStack(spacing: 8.0) {
                HeaderImageView(pokemon: pokemon)
                    .padding(.horizontal, 50.0)
                    .frame(height: 300.0)

                Spacer()

                Text(pokemon.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)

                PokemonTypeView(types: pokemon.types)

                Divider()
                    .padding(/*@START_MENU_TOKEN@*/.all, 24.0/*@END_MENU_TOKEN@*/)

                PokemonDescriptionView(pokemon: pokemon)
                    .padding(.horizontal, 32.0)

                Divider()
                    .padding(24.0)

                Text("Stats")
                    .font(.headline)
            }
            .navigationTitle("No. " + String(withInt: pokemon.pokedexID, leadingZeros: 3))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PokemonDetailView(pokemon: Pokemon.example)
        }
        .previewDevice(PreviewDevice(rawValue: "iPhone 13"))

        NavigationView {
            PokemonDetailView(pokemon: Pokemon.example)
        }
        .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
    }
}
