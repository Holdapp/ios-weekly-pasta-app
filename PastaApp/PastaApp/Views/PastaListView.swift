//
//  ContentView.swift
//  PastaApp
//
//  Created by Kacper Rączy on 18/01/2023.
//

import SwiftUI

struct PastaListView: View {
    @ObservedObject var viewModel: PastaListViewModel
    @State var isCreatePastaLinkActive: Bool = false
    
    var body: some View {
        Group {
            if viewModel.pastas.isEmpty {
                VStack {
                    Spacer()
                    Image(systemName: "fork.knife.circle")
                        .resizable()
                        .frame(width: 50.0, height: 50.0)
                    Text("Nothing to see here, yet")
                        .font(.body)
                    Text("Cook some pastas first")
                        .font(.caption)
                    Spacer()
                }
                .foregroundColor(.secondary)
            } else {
                List {
                    ForEach(viewModel.pastas) { pasta in
                        NavigationLink(destination: PastaView(pasta: pasta)) {
                            Cell(pasta: pasta)
                        }
                    }
                }
                .listStyle(.insetGrouped)
            }
        }
            .task {
                await viewModel.loadPastas()
            }
            .overlay {
                if viewModel.isLoading {
                    LoadingOverlay()
                }
            }
            .navigationTitle("Pastas 🍝")
            .safeAreaInset(edge: .bottom) {
                AddButton {
                    isCreatePastaLinkActive = true
                }
            }
            .sheet(
                isPresented: $isCreatePastaLinkActive,
                onDismiss: {
                    Task {
                        await viewModel.loadPastas()
                    }
                }
            ) {
                NavigationView {
                    CreatePastaView(
                        viewModel: .init(
                            pastaService: RemotePastaService.localhostService
                        )
                    )
                }
            }
    }
}

extension PastaListView {
    struct AddButton: View {
        let action: () -> Void
        
        var body: some View {
            Button {
                action()
            } label: {
                ZStack {
                    Circle()
                        .foregroundColor(.accentColor)
                    Image(systemName: "plus")
                        .resizable()
                        .bold()
                        .foregroundColor(.white)
                        .padding(16.0)
                }
                .frame(width: 50.0, height: 50.0)
            }
        }
    }
}

extension PastaListView {
    struct Cell: View {
        let pasta: Pasta
        
        var body: some View {
            HStack {
                VStack(alignment: .leading, spacing: 8.0) {
                    HStack {
                        Text(pasta.date, style: .date)
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Spacer()
                        Text("@\(pasta.userId)")
                            .font(.caption)
                            .bold()
                            .foregroundColor(.accentColor)
                    }
                    Text("🍝 " + pasta.prompt)
                        .font(.headline)
                        .bold()
                        .foregroundColor(.primary)
                    Text(pasta.text)
                        .font(.footnote)
                        .italic()
                        .lineLimit(2)
                        .foregroundColor(.primary)
                }
            }
        }
    }
}

struct PastaListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PastaListView(
                viewModel: .init(pastaService: MockedPastaService())
            )
        }
    }
}
