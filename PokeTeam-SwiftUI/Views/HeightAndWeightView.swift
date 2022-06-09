//
//  HeightAndWeightView.swift
//  PokeTeam-SwiftUI
//
//  Created by Jon Duenas on 6/1/22.
//

import SwiftUI

struct HeightAndWeightView: View {
    let height: Double
    let weight: Double

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "ruler.fill")
                .resizable(resizingMode: .stretch)
                .aspectRatio(contentMode: .fit)
                .frame(width: 20.0, height: 20.0)

            Text(String(height) + " m")
                .font(.headline)

            Text("/")
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16.0)

            Image(systemName: "scalemass.fill")
                .resizable(resizingMode: .stretch)
                .aspectRatio(contentMode: .fit)
                .frame(width: 20.0, height: 20.0)

            Text(String(weight) + " kg")
                .font(.headline)
        }
        .padding(.horizontal)
        .frame(height: 44)
        .background {
            Capsule()
                .foregroundColor(Color(uiColor: .systemBackground))
                .shadow(color: Color(uiColor: .separator), radius: 2, x: 0, y: 2)
        }
    }
}

struct HeightAndWeightView_Previews: PreviewProvider {
    static var previews: some View {
        HeightAndWeightView(height: 123.4, weight: 5678.1)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
