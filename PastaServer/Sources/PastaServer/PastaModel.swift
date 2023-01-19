//
//  Pasta.swift
//  PastaApp
//
//  Created by Kacper Rączy on 18/01/2023.
//

import Vapor
import Fluent

final class PastaModel: Model, Content {
    // Name of the table or collection.
    static let schema = "pastas"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "userId")
    var userId: String
    
    @Field(key: "prompt")
    var prompt: String
    
    @Field(key: "text")
    var text: String
    
    @Field(key: "date")
    var date: Date
    
    required init() {}
    
    init(id: UUID? = nil, userId: String, prompt: String, text: String, date: Date) {
        self.id = id
        self.userId = userId
        self.prompt = prompt
        self.text = text
        self.date = date
    }
}

struct PastaMigration: AsyncMigration {
    // Prepares the database for storing Galaxy models.
    func prepare(on database: Database) async throws {
        try await database.schema("pastas")
            .id()
            .field("userId", .string)
            .field("prompt", .string)
            .field("text", .string)
            .field("date", .datetime)
            .create()
    }

    // Optionally reverts the changes made in the prepare method.
    func revert(on database: Database) async throws {
        try await database.schema("pastas").delete()
    }
}
