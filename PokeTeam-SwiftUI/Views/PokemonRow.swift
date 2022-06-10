//
//  PokemonRow.swift
//  PokeTeam-SwiftUI
//
//  Created by Jon Duenas on 5/24/22.
//

import SwiftUI
import Kingfisher

struct PokemonRow: View {
    let pokemon: Pokemon

    private var idString: String {
        String(withInt: pokemon.id, leadingZeros: 3)
    }

    var body: some View {
        HStack(spacing: 20) {
            KFImage(pokemon.spriteURL)
                .downsampling(size: CGSize(width: 60, height: 60))
                .cacheOriginalImage()
                .placeholder { _ in
                    ProgressView()
                }
                .cancelOnDisappear(true)
                .resizable()
                .padding(8.0)
                .frame(width: 60.0, height: 60.0)

            VStack(alignment: .leading) {
            Text("No. " + String(withInt: pokemon.id, leadingZeros: 3))
                    .font(.headline)


            Text(pokemon.name)
                .font(.title2)
                .fontWeight(.semibold)
                .multilineTextAlignment(.leading)
            }

            Spacer()

            PokemonTypeView(types: pokemon.types, style: .compact)
        }
            
    }
}

struct PokemonRow_Previews: PreviewProvider {
    static var previews: some View {
        PokemonRow(pokemon: Pokemon.example)
    }
}
