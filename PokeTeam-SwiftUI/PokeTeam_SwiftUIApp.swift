//
//  PokeTeam_SwiftUIApp.swift
//  PokeTeam-SwiftUI
//
//  Created by Jon Duenas on 5/24/22.
//

import SwiftUI

@main
struct PokeTeam_SwiftUIApp: App {
    @StateObject private var pokedex = Pokedex()
    
    var body: some Scene {
        WindowGroup {
            RootView {
                NavigationView {
                    ContentView()
                        .environmentObject(pokedex)
                }
            }
        }
    }
}
