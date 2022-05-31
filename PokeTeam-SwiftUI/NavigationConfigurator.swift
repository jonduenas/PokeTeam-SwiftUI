//
//  NavigationConfigurator.swift
//  PokeTeam-SwiftUI
//
//  Created by Jon Duenas on 5/31/22.
//
//  Found via https://stackoverflow.com/a/62785462/11417831

import SwiftUI

extension View {
    func configureNavigationBar(configure: @escaping (UINavigationController) -> Void) -> some View {
        modifier(NavigationConfigurationViewModifier(configure: configure))
    }
}

struct NavigationConfigurationViewModifier: ViewModifier {
    let configure: (UINavigationController) -> Void

    func body(content: Content) -> some View {
        content.background(NavigationConfigurator(configure: configure))
    }
}

struct NavigationConfigurator: UIViewControllerRepresentable {
    let configure: (UINavigationController) -> Void

    func makeUIViewController(
        context: UIViewControllerRepresentableContext<NavigationConfigurator>
    ) -> NavigationConfigurationViewController {
        NavigationConfigurationViewController(configure: configure)
    }

    func updateUIViewController(
        _ uiViewController: NavigationConfigurationViewController,
        context: UIViewControllerRepresentableContext<NavigationConfigurator>
    ) { }
}

final class NavigationConfigurationViewController: UIViewController {
    let configure: (UINavigationController) -> Void

    init(configure: @escaping (UINavigationController) -> Void) {
        self.configure = configure
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        if let navigationController = navigationController {
            configure(navigationController)
        }
    }
}
