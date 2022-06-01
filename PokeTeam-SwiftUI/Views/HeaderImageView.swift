//
//  HeaderImageView.swift
//  PokeTeam-SwiftUI
//
//  Created by Jon Duenas on 6/1/22.
//

import SwiftUI

struct HeaderImageView: View {
    let pokemon: Pokemon

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(
                    colors: [
                        pokemon.types[0].color,
                        pokemon.types[0].secondaryGradientColor
                    ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            RemoteImage(source: pokemon.spriteURL)
                .padding(/*@START_MENU_TOKEN@*/[.leading, .bottom, .trailing]/*@END_MENU_TOKEN@*/)
                .frame(width: 250.0)
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 10, y: 10)
        }
    }
}

struct HeaderImageView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderImageView(pokemon: Pokemon.example)
    }
}
