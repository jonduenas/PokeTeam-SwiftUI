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

    var image: Image {
        return Image(self.rawValue)
    }

    init?(name: String) {
        self.init(rawValue: name.lowercased())
    }
}
