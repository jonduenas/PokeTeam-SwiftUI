//
//  TypeView.swift
//  PokeTeam-SwiftUI
//
//  Created by Jon Duenas on 5/24/22.
//

import SwiftUI

struct PokemonTypeView: View {
    enum Style {
        case regular
        case compact
    }

    let types: [PokemonType]
    var style: Style = .regular

    var body: some View {
        HStack {
            ForEach(types, id: \.self) { type in
                HStack {
                    type.image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20.0, height: 20.0)
                    if case .regular = style {
                        Text(type.name)
                            .font(.footnote)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.center)
                            .lineLimit(1)
                    }
                }
                .padding(.vertical, 8.0)
                .padding(.horizontal, style == .regular ? 16.0 : 8.0)
                .background(type.color)
                .clipShape(Capsule())
            }
        }
    }
}

struct TypeView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonTypeView(types: [.electric, .flying])
            .previewLayout(.sizeThatFits)
            .padding()

        PokemonTypeView(types: [.electric, .flying], style: .compact)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
