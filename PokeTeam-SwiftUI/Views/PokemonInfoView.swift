//
//  PokemonInfoView.swift
//  PokeTeam-SwiftUI
//
//  Created by Jon Duenas on 6/1/22.
//

import SwiftUI

struct PokemonInfoView: View {
    let pokemon: Pokemon

    var body: some View {
        VStack(alignment: .leading) {
            Text("Info")

            HStack {
                Text("Height")

                Spacer()
                    .padding(.leading, 50.0)

                Text("")
            }
        }
    }
}

struct PokemonInfoView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonInfoView(pokemon: Pokemon.example)
    }
}
