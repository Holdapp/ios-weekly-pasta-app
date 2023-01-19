//
//  CreatePastaView.swift
//  PastaApp
//
//  Created by Kacper Rączy on 19/01/2023.
//

import SwiftUI

struct CreatePastaView: View {
    @ObservedObject var viewModel: CreatePastaViewModel
    
    var body: some View {
        VStack {
            Form {
                Section("Story setting") {
                    TextField(
                        "Story setting",
                        text: $viewModel.promptText,
                        prompt: Text("e.g. Aleksandra nie lubi pomarańczy...")
                    )
                }
                if let result = viewModel.resultText {
                    Section("Result") {
                        Text(result)
                            
                    }
                }
            }
            Button("Cook 🥘") {
                Task {
                    await viewModel.submitPastaRequest()
                }
            }
            .disabled(viewModel.isLoading)
            .padding(.horizontal, 20.0)
            .buttonStyle(WideOrangeButton())
        }
        .overlay {
            if viewModel.isLoading {
                LoadingOverlay()
            }
        }
        .navigationTitle("Create 🍝")
        .navigationBarTitleDisplayMode(.inline)
    }
}

extension CreatePastaView {
    struct WideOrangeButton: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .bold()
                .padding()
                .frame(minWidth: 0,
                       maxWidth: .infinity)
                .foregroundColor(.white)
                .background( RoundedRectangle(cornerRadius: 12.0).fill(Color.accentColor)
            )
        }
    }
}

struct CreatePastaView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CreatePastaView(
                viewModel: .init(pastaService: MockedPastaService())
            )
        }
    }
}
