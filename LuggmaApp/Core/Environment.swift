import Foundation

struct AppEnvironment {
    var api: APIClient = MockAPIClient()
    static var current = AppEnvironment()
}

// Basit mock istemci; preview/test senaryolarında boş veri döner.
struct MockAPIClient: APIClient {
    func get(_ path: String) async throws -> Data {
        Data()
    }

    func post(_ path: String, body: Data?) async throws -> Data {
        Data()
    }
}
