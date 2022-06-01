//
//  PokemonDescriptionView.swift
//  PokeTeam-SwiftUI
//
//  Created by Jon Duenas on 6/1/22.
//

import SwiftUI

struct PokemonDescriptionView: View {
    let pokemon: Pokemon

    var body: some View {
        VStack(spacing: 24) {
            Text(pokemon.genus)
                .font(.headline)

            Text(pokemon.flavorText)
                .font(.body)

            HeightAndWeightView(height: pokemon.height, weight: pokemon.weight)
        }
    }
}

struct PokemonDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDescriptionView(pokemon: Pokemon.example)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
