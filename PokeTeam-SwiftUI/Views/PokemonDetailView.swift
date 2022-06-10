//
//  PokemonDetailView.swift
//  PokeTeam-SwiftUI
//
//  Created by Jon Duenas on 5/31/22.
//

import SwiftUI

struct PokemonDetailView: View {
    let pokemon: Pokemon

    private let headerHeight: CGFloat = 300

    var body: some View {
        GeometryReader { mainProxy in
            ZStack {
                ScrollView {
                    GeometryReader { scrollProxy in
                        ZStack {
                            LinearGradient(
                                gradient: pokemon.gradient,
                                startPoint: .bottomLeading,
                                endPoint: .topTrailing
                            )
                            .ignoresSafeArea()

                            RemoteImage(source: pokemon.spriteURL)
                                .frame(idealWidth: scrollProxy.size.width * 0.6)
                                .padding(.top, mainProxy.safeAreaInsets.top)
                                .padding(.bottom, 16)
                                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 10, y: 10)
                                .blur(radius: getBlurRadiusForImage(scrollProxy))
                        }
                        .frame(width: scrollProxy.size.width, height: getHeightForHeader(scrollProxy))
                        .offset(x: 0, y: getOffsetForHeader(scrollProxy, safeAreaHeight: mainProxy.safeAreaInsets.top))
                    }
                    .frame(height: headerHeight + mainProxy.safeAreaInsets.top)
                        .zIndex(1)

                    VStack(spacing: 8.0) {
                        Text(pokemon.name)
                            .font(.largeTitle)
                            .fontWeight(.bold)

                        PokemonTypeView(types: pokemon.types)

                        Divider()
                            .padding(24.0)

                        PokemonDescriptionView(pokemon: pokemon)
                            .padding(.horizontal, 32.0)

                        Divider()
                            .padding(24.0)

                        Text("Stats")
                            .font(.headline)
                            .padding(.bottom)

                        StatsView(stats: pokemon.stats, progressColor: pokemon.types[0].color)
                            .padding(.horizontal, 32.0)
                            .padding(.bottom, 500)
                    }
                    .navigationTitle("No. " + String(withInt: pokemon.pokedexID, leadingZeros: 3))
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbarBackground(.hidden)
                }
                .edgesIgnoringSafeArea(.top)
            }
        }
    }

    private func getHeightForHeader(_ geometry: GeometryProxy) -> CGFloat {
        let offset = getScrollOffset(geometry)
        let imageHeight = geometry.size.height

        if offset > 0 {
            return imageHeight + offset
        }

        return imageHeight
    }

    private func getScrollOffset(_ geometry: GeometryProxy) -> CGFloat {
        geometry.frame(in: .global).minY
    }

    private func getOffsetForHeader(_ geometry: GeometryProxy, safeAreaHeight: CGFloat) -> CGFloat {
        let offset = getScrollOffset(geometry)
        let sizeOffScreen = headerHeight

        if offset < -sizeOffScreen {
            let headerOffset = abs(min(-sizeOffScreen, offset))
            return headerOffset - sizeOffScreen
        }

        if offset > 0 {
            return -offset
        }

        return 0
    }

    private func getBlurRadiusForImage(_ geometry: GeometryProxy) -> CGFloat {
        let offset = geometry.frame(in: .global).maxY

        let height = geometry.size.height
        let blurPercent = (height - max(offset, 0)) / height

        return blurPercent * 40
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PokemonDetailView(pokemon: Pokemon.example)
        }
    }
}
