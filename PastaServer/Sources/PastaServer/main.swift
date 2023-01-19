import Vapor
import Fluent
import FluentSQLiteDriver
import GPT

// Initialize the app
// Listen on port 8889
let app = try Application(.detect())
app.http.server.configuration.port = 8889
defer { app.shutdown() }

// Read configuration stuff (like tokens for external APIs) from environment variables
let config = try EnvConfig(environ: ProcessInfo.processInfo.environment)

// Init services
let httpClient = HTTPClient(eventLoopGroupProvider: .shared(app.eventLoopGroup))
let gptService = OpenAIService(
    token: config.openAiToken,
    config: .init(
        maxTokens: 1200,
        temperature: 0.7
    ),
    httpClient: httpClient
)

// Database config
app.databases.use(.sqlite(.file("db.sqlite")), as: .sqlite)
app.migrations.add(PastaMigration())
try app.autoMigrate().wait()

// JSON Decoding config
// create a new JSON encoder that uses unix-timestamp dates
let encoder = JSONEncoder()
encoder.dateEncodingStrategy = .iso8601

// override the global encoder used for the `.json` media type
ContentConfiguration.global.use(encoder: encoder, for: .json)

// Routing
app.get("pastas") { request async throws -> [PastaModel] in
    try await PastaModel.query(on: request.db).all()
}

app.post("cook") { request async throws -> PastaModel in
    guard let userId = request.headers["PASTA-USER-ID"].first else {
        throw Abort(.badRequest)
    }
    
    let cookingInfo = try request.content.decode(CookingBody.self)
    let prompt = """
    Dokończ następujące opowiadanie. Opowiadanie dotyczy następujących faktów: \(cookingInfo.prompt). Abstrakcyjne, kuriozalne wydarzenia i zwroty akcji.
    
    """
    
    let completions = try await gptService.generateCompletions(prompt: prompt, count: 1, presencePenalty: 1.0, frequencyPenalty: 0.5)
    guard let completion = completions.first else {
        throw Abort(.internalServerError)
    }
    
    let pasta = PastaModel(
        id: UUID(),
        userId: userId,
        prompt: cookingInfo.prompt,
        text: completion.trimmingCharacters(in: .whitespacesAndNewlines),
        date: Date()
    )
    try await pasta.create(on: request.db)
    
    return pasta
}

// Run the app, this blocks
try app.run()
