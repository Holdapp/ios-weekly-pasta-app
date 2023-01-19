//
//  CreatePastaViewModel.swift
//  PastaApp
//
//  Created by Kacper Rączy on 19/01/2023.
//

import SwiftUI

@MainActor
class CreatePastaViewModel: ObservableObject {
    @Published var promptText: String = ""
    @Published var resultText: String? = nil
    @Published var isLoading: Bool = false
    
    private let pastaService: PastaServiceProtocol
    
    init(pastaService: PastaServiceProtocol) {
        self.pastaService = pastaService
    }
    
    func submitPastaRequest() async {
        guard !promptText.isEmpty else {
            return
        }
        
        isLoading = true
        do {
            let pasta = try await pastaService.requestPasta(prompt: promptText)
            resultText = pasta.text
        } catch {
            resultText = "Error: " + error.localizedDescription
            print(error)
        }
        isLoading = false
    }
}
