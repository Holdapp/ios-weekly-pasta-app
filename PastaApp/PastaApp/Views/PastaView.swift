//
//  PastaView.swift
//  PastaApp
//
//  Created by Kacper Rączy on 19/01/2023.
//

import SwiftUI

struct PastaView: View {
    let pasta: Pasta
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8.0) {
                HStack {
                    Text(pasta.date, style: .date)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Spacer()
                }
                Text("🍝 " + pasta.prompt)
                    .font(.title)
                    .bold()
                    .foregroundColor(.primary)
                Text(pasta.text)
                    .font(.body)
                    .italic()
                    .foregroundColor(.primary)
                Text("Created by: ")
                    .font(.caption)
                    .foregroundColor(.secondary) +
                Text("@\(pasta.userId)")
                    .font(.caption)
                    .bold()
                    .foregroundColor(.accentColor)
                Spacer()
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PastaView_Previews: PreviewProvider {
    static var previews: some View {
        PastaView(
            pasta: .init(id: UUID(), userId: "123", prompt: "Placeholder pasta", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", date: Date())
        )
    }
}
