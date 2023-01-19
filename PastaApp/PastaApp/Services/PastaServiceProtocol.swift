//
//  PastaService.swift
//  PastaApp
//
//  Created by Kacper Rączy on 18/01/2023.
//

protocol PastaServiceProtocol: AnyObject {
    func getPastas() async throws -> [Pasta]
    func requestPasta(prompt: String) async throws -> Pasta
}
