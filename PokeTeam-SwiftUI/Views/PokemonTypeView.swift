//
//  TypeView.swift
//  PokeTeam-SwiftUI
//
//  Created by Jon Duenas on 5/24/22.
//

import SwiftUI

struct PokemonTypeView: View {
    let types: [PokemonType]
    let compactSize: Bool

    var body: some View {
        HStack {
            ForEach(types, id: \.self) { type in
                HStack {
                    type.image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20.0, height: 20.0)
                    if !compactSize {
                        Text(type.name)
                            .font(.footnote)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.center)
                            .lineLimit(1)
                    }
                }
                .padding(8.0)
                .background(type.color)
                .cornerRadius(compactSize ? .infinity : /*@START_MENU_TOKEN@*/5.0/*@END_MENU_TOKEN@*/)
            }
        }
    }
}

struct TypeView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonTypeView(types: [.electric, .flying], compactSize: true)
    }
}
