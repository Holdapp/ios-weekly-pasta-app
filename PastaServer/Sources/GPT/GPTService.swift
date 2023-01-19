//
//  GPTServiceProtocol.swift
//  DialogOptionsGPT
//
//  Created by Kacper Rączy on 29/12/2022.
//

public protocol GPTServiceProtocol: CustomStringConvertible {
    func generateCompletions(prompt: String, count: Int, presencePenalty: Double, frequencyPenalty: Double) async throws -> [String]
}
