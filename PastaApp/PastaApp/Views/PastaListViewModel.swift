//
//  ContentViewModel.swift
//  PastaApp
//
//  Created by Kacper Rączy on 18/01/2023.
//

import Foundation

@MainActor
final class PastaListViewModel: ObservableObject {
    
    @Published var pastas: [Pasta] = []
    @Published var isLoading: Bool = false
    
    private let pastaService: PastaServiceProtocol
    
    init(pastaService: PastaServiceProtocol) {
        self.pastaService = pastaService
    }
    
    func loadPastas() async {
        isLoading = true
        do {
            pastas = try await pastaService.getPastas()
        } catch {
            print(error)
        }
        isLoading = false
    }
}
