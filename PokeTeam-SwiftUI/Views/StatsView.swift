//
//  StatsView.swift
//  PokeTeam-SwiftUI
//
//  Created by Jon Duenas on 6/1/22.
//

import SwiftUI

struct StatsView: View {
    let stats: [Stat: Int]
    let progressColor: Color

    var body: some View {
        VStack {
            ForEach(Stat.allCases, id: \.self) { stat in
                HStack {
                    Text(stat.shortName)
                        .font(.callout)
                        .frame(width: 50)

                    Text("\(stats[stat] ?? 0)")
                        .font(.callout)
                        .fontWeight(.bold)
                        .frame(width: 50)

                    ProgressView(value: CGFloat(stats[stat] ?? 0), total: 255)
                        .tint(progressColor)

                }
            }
        }
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView(
            stats: [
                .hp: 35,
                .attack: 55,
                .defense: 40,
                .specialAttack: 50,
                .specialDefense: 50,
                .speed: 90
            ],
            progressColor: PokemonType.electric.color
        )
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
