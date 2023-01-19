//
//  File.swift
//  
//
//  Created by Kacper Rączy on 19/01/2023.
//

import Foundation

struct EnvConfig {
    enum EnvKeys: String {
        case openAiToken = "PASTA_OPENAI_TOKEN"
    }
    
    let openAiToken: String
}

extension EnvConfig {
    struct MissingEnvVarError: Error {
        let key: String
        
        init(key: EnvKeys) {
            self.key = key.rawValue
        }
    }
    
    init(environ: [String: String]) throws {
        guard let openAiToken = environ[EnvKeys.openAiToken.rawValue] else {
            throw MissingEnvVarError(key: EnvKeys.openAiToken)
        }
        
        self.openAiToken = openAiToken
    }
}
