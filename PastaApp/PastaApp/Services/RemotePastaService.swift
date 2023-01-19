//
//  RemotePastaService.swift
//  PastaApp
//
//  Created by Kacper Rączy on 18/01/2023.
//

import Foundation

class RemotePastaService: PastaServiceProtocol {
    enum ServiceError: Error {
        case invalidStatusCode(Int)
    }
    
    private let baseURL: URL
    private let session: URLSession
    private let userId: String
    
    init(baseURL: URL, userId: String, session: URLSession = .shared) {
        self.baseURL = baseURL
        self.session = session
        self.userId = userId
    }
    
    func getPastas() async throws -> [Pasta] {
        let url = baseURL.appending(path: "pastas")
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("\(userId)", forHTTPHeaderField: "PASTA-USER-ID")
        request.httpMethod = "GET"
        
        let (data, response) = try await session.data(for: request)
        let statusCode = (response as! HTTPURLResponse).statusCode
        if !(200..<300).contains(statusCode) {
            throw ServiceError.invalidStatusCode(statusCode)
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let pasta = try decoder.decode([Pasta].self, from: data)
        return pasta
    }
    
    func requestPasta(prompt: String) async throws -> Pasta {
        let url = baseURL.appending(path: "cook")
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("\(userId)", forHTTPHeaderField: "PASTA-USER-ID")
        request.httpMethod = "POST"
        request.httpBody = try JSONEncoder().encode(CookingBody(prompt: prompt))
        let (data, response) = try await session.data(for: request)
        let statusCode = (response as! HTTPURLResponse).statusCode
        if !(200..<300).contains(statusCode) {
            throw ServiceError.invalidStatusCode(statusCode)
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let pasta = try decoder.decode(Pasta.self, from: data)
        return pasta
    }
}

extension RemotePastaService {
    static let localhostService: RemotePastaService = {
        let url = URL(string: "http://localhost:8889")!
        let userId = "username"
        
        return RemotePastaService(baseURL: url, userId: userId)
    }()
}
