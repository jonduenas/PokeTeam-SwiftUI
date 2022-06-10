//
//  GenerationRow.swift
//  PokeTeam-SwiftUI
//
//  Created by Jon Duenas on 6/10/22.
//

import SwiftUI
import Kingfisher

struct GenerationRow: View {
    let generation: Generation

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            LinearGradient(
                colors: [.red.opacity(0.3), .blue.opacity(0.3)],
                startPoint: .bottomTrailing,
                endPoint: .topLeading
            )

            HStack(spacing: -60) {
                Spacer()

                ForEach(generation.starters) { species in
                    KFImage(species.spriteURL)
                        .resizable()
                        .frame(width: 120, height: 120)
                        .shadow(radius: 5)
                }
            }
            .padding()

            VStack(alignment: .leading) {
                Text(generation.region)
                    .font(.title)
                    .bold()

                Text(generation.name)
                    .font(.subheadline)
                    .bold()
                    .foregroundColor(.secondary)
            }
            .padding()
        }
        .frame(height: 150)
        .cornerRadius(20)
    }
}

struct GenerationRow_Previews: PreviewProvider {
    static var previews: some View {
        GenerationRow(generation: Generation.example)
    }
}
