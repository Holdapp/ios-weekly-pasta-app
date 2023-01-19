//
//  Pasta.swift
//  PastaApp
//
//  Created by Kacper Rączy on 18/01/2023.
//

import Foundation

struct Pasta: Codable, Hashable, Identifiable {
    let id: UUID
    let userId: String
    let prompt: String
    let text: String
    let date: Date
}
