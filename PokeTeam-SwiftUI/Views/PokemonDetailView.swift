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
        VStack {
            HeaderImageView(pokemon: pokemon)
                .frame(maxWidth: .infinity, maxHeight: 250)

            VStack(spacing: 12.0) {
                Text(pokemon.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)

                PokemonTypeView(types: pokemon.types, compactSize: false)

                Text("No. " + String(withInt: pokemon.pokedexID, leadingZeros: 3) + " - \(pokemon.genus)")
                    .font(.subheadline)

                HStack(spacing: 12) {
                    Spacer()

                    Image(systemName: "ruler.fill")
                        .resizable(resizingMode: .stretch)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30.0, height: 30.0)

                    Text(String(pokemon.height) + " m")
                        .font(.headline)

                    Spacer()

                    Image(systemName: "scalemass.fill")
                        .resizable(resizingMode: .stretch)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30.0, height: 30.0)

                    Text(String(pokemon.height) + " kg")
                        .font(.headline)

                    Spacer()
                }

                Divider()
                    .padding(.all)

                Text(pokemon.flavorText)
                    .font(.body)
                    .padding(.horizontal)

                Divider()
                    .padding(.all)

                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
        }
        .navigationBarTitleDisplayMode(.inline)
        .statusBarStyle(.lightContent)
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PokemonDetailView(pokemon: Pokemon.example)
        }
    }
}
