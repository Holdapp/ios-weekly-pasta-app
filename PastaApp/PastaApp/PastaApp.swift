//
//  PastaApp.swift
//  PastaApp
//
//  Created by Kacper Rączy on 18/01/2023.
//

import SwiftUI

@main
struct PastaApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                PastaListView(
                    viewModel: .init(pastaService: RemotePastaService.localhostService)
                )
            }
        }
    }
}
