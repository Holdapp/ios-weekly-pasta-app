//
//  OpenAIConfig.swift
//  
//
//  Created by Kacper Rączy on 08/01/2023.
//

public struct OpenAIConfig {
    public let maxTokens: Int
    public let temperature: Double
    
    public init(maxTokens: Int = 1200, temperature: Double = 0.7) {
        self.maxTokens = maxTokens
        self.temperature = temperature
    }
}
