//
//  PokemonRow.swift
//  PokeTeam-SwiftUI
//
//  Created by Jon Duenas on 5/24/22.
//

import SwiftUI

struct PokemonRow: View {
    let pokemon: Pokemon

    private var idString: String {
        String(withInt: pokemon.id, leadingZeros: 3)
    }

    var body: some View {
        HStack(spacing: 20) {
            AsyncImage(
                url: URL(string: "https://github.com/fanzeyi/pokemon.json/blob/master/thumbnails/\(idString).png?raw=true")) { phase in
                    if let image = phase.image {
                        image.resizable()
                            .scaledToFit()
                    } else if phase.error != nil {
                        Image("025")
                            .renderingMode(.template)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } else {
                        ProgressView()
                    }
                }
                .padding(8.0)
                .frame(width: 60.0, height: 60.0)

            VStack(alignment: .leading) {
            Text("No. " + String(withInt: pokemon.id, leadingZeros: 3))
                    .font(.headline)


            Text(pokemon.name.english)
                .font(.title2)
                .fontWeight(.semibold)
                .multilineTextAlignment(.leading)
            }

            Spacer()

            PokemonTypeView(types: pokemon.type, compactSize: true)
        }
            
    }
}

struct PokemonRow_Previews: PreviewProvider {
    static var previews: some View {
        PokemonRow(pokemon: Pokemon.example)
    }
}
