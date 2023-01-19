//
//  OpenAIService.swift
//  
//
//  Created by Kacper Rączy on 08/01/2023.
//

import Foundation
import AsyncHTTPClient
import NIOFoundationCompat

public final class OpenAIService: GPTServiceProtocol {
    private enum Constants {
        static let url = URL(string: "https://api.openai.com/v1/completions")!
        static let timeoutInSeconds: Int64 = 60
    }
    
    private let token: String
    private let model: OpenAIModel
    private let config: OpenAIConfig
    private let httpClient: HTTPClient
    
    public init(token: String, model: OpenAIModel = .davinci003, config: OpenAIConfig = .init(), httpClient: HTTPClient) {
        self.token = token
        self.model = model
        self.config = config
        self.httpClient = httpClient
    }
    
    public func generateCompletions(prompt: String, count: Int, presencePenalty: Double, frequencyPenalty: Double) async throws -> [String] {
        let requestData = RequestData(
            model: model.rawValue,
            prompt: prompt,
            count: count,
            temperature: config.temperature,
            maxTokens: config.maxTokens,
            presencePenalty: presencePenalty,
            frequencyPenalty: frequencyPenalty
        )
        
        var request = HTTPClientRequest(url: Constants.url.absoluteString)
        request.method = .POST
        request.headers = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(token)"
        ]
        request.body = .bytes(try JSONEncoder().encode(requestData))
        
        let response = try await httpClient.execute(request, timeout: .seconds(Constants.timeoutInSeconds))
        let statusCode = response.status.code
        if !(200..<300).contains(statusCode) {
            throw OpenAIError.invalidStatusCode(statusCode)
        }
        
        let data = try await response.body.collect(upTo: 1024 * 1024) // 1 MB
        let responseData = try JSONDecoder().decode(ResponseData.self, from: data)
        
        return responseData.choices.map { $0.text }
    }
    
    public var description: String {
        "OpenAI[model: \(model.rawValue), maxTokens: \(config.maxTokens), temperature: \(config.temperature)]"
    }
}

extension OpenAIService {
    struct RequestData: Encodable {
        enum CodingKeys: String, CodingKey {
            case model
            case prompt
            case count = "n"
            case temperature
            case maxTokens = "max_tokens"
            case presencePenalty = "presence_penalty"
            case frequencyPenalty = "frequency_penalty"
        }
        
        let model: String
        let prompt: String
        let count: Int
        let temperature: Double
        let maxTokens: Int
        let presencePenalty: Double
        let frequencyPenalty: Double
    }
    
    struct ResponseData: Decodable {
        struct Choice: Decodable {
            let index: Int
            let text: String
        }
        
        let id: String
        let created: Int
        let choices: [Choice]
    }
}
