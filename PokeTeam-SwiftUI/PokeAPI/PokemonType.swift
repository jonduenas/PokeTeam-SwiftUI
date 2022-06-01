//
//  PokemonType.swift
//  PokeTeam-SwiftUI
//
//  Created by Jon Duenas on 5/24/22.
//

import Foundation
import SwiftUI

enum PokemonType: String {
    case bug
    case dark
    case dragon
    case electric
    case fairy
    case fighting
    case fire
    case flying
    case ghost
    case grass
    case ground
    case ice
    case normal
    case poison
    case psychic
    case rock
    case steel
    case water

    var name: String {
        return self.rawValue.localizedCapitalized
    }

    var color: Color {
        return Color(self.rawValue)
    }

    var secondaryGradientColor: Color {
        return color.adjust(saturation: -0.2, brightness: 0.2)
    }

    var image: Image {
        return Image(self.rawValue)
    }

    init?(name: String) {
        self.init(rawValue: name.lowercased())
    }
}

extension Color {
    func adjust(hue: CGFloat = 0, saturation: CGFloat = 0, brightness: CGFloat = 0, opacity: CGFloat = 1) -> Color {
        let color = UIColor(self)
        var currentHue: CGFloat = 0
        var currentSaturation: CGFloat = 0
        var currentBrightness: CGFloat = 0
        var currentOpacity: CGFloat = 0

        if color.getHue(
            &currentHue,
            saturation: &currentSaturation,
            brightness: &currentBrightness,
            alpha: &currentOpacity
        ) {
            return Color(
                hue: currentHue + hue,
                saturation: currentSaturation + saturation,
                brightness: currentBrightness + brightness,
                opacity: currentOpacity + opacity
            )
        }

        return self
    }
}
