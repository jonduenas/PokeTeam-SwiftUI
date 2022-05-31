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
        ZStack {
            pokemon.types.first?.color
                .ignoresSafeArea()

            Text(pokemon.name)
        }
        .navigationBarTitleDisplayMode(.inline)
        .statusBarStyle(.lightContent)
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailView(pokemon: Pokemon.example)
    }
}
