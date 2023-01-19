//
//  MockedPastaService.swift
//  PastaApp
//
//  Created by Kacper Rączy on 18/01/2023.
//

import Foundation

class MockedPastaService: PastaServiceProtocol {
    func getPastas() async throws -> [Pasta] {
        try await Task.sleep(for: .seconds(2))
        
        return [
            .init(id: UUID(), userId: "123", prompt: "Lorem ipsum", text: "Et mollitia non reprehenderit eaque aut consequuntur. Et voluptatibus in voluptas incidunt dignissimos. Doloremque maiores maxime accusamus. Dolorem saepe unde nemo omnis. Corrupti cumque quod deleniti voluptatem omnis.", date: Date().addingTimeInterval(-3600)),
            .init(id: UUID(), userId: "123", prompt: "blah blah blah", text: "Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?", date: Date().addingTimeInterval(-2*3600)),
            .init(id: UUID(), userId: "123", prompt: "blah blah blah", text: "At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga.", date: Date().addingTimeInterval(-3*3600)),
            .init(id: UUID(), userId: "123", prompt: "blah blah blah blah", text: "Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat", date: Date().addingTimeInterval(-4*3600)),
            .init(id: UUID(), userId: "123", prompt: "blah blah blah blah", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", date: Date().addingTimeInterval(-5*3600))
        ]
    }
    
    func requestPasta(prompt: String) async throws -> Pasta {
        try await Task.sleep(for: .seconds(2))
        
        return .init(id: UUID(), userId: "123", prompt: "Placeholder pasta", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", date: Date())
    }
}
