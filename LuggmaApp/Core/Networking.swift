import Foundation

// Eğer ayrı bir APIClient.swift dosyan yoksa, protokolü buraya ekle:
protocol APIClient {
    func get(_ path: String) async throws -> Data
    func post(_ path: String, body: Data?) async throws -> Data
}

/// Basit URLSession tabanlı API istemcisi.
/// project.yml'deki target tüm Sources klasörünü dahil ettiği için
/// bu dosyayı Sources/Core altına koyman ideal.
final class URLSessionAPIClient: APIClient {

    private let baseURL: URL
    private let session: URLSession

    init(
        baseURL: URL = URL(string: "https://example.com")!,
        session: URLSession = .shared
    ) {
        self.baseURL = baseURL
        self.session = session
    }

    // GET /path
    func get(_ path: String) async throws -> Data {
        let url = baseURL.appendingPathComponent(path)
        var req = URLRequest(url: url)
        req.httpMethod = "GET"

        let (data, response) = try await session.data(for: req)
        try Self.validate(response: response)
        return data
    }

    // POST /path
    func post(_ path: String, body: Data?) async throws -> Data {
        let url = baseURL.appendingPathComponent(path)
        var req = URLRequest(url: url)
        req.httpMethod = "POST"
        req.httpBody = body
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let (data, response) = try await session.data(for: req)
        try Self.validate(response: response)
        return data
    }

    // 2xx dışındaki HTTP durumlarını hata yap
    private static func validate(response: URLResponse) throws {
        guard let http = response as? HTTPURLResponse else { return }
        guard (200..<300).contains(http.statusCode) else {
            throw URLError(.badServerResponse)
        }
    }
}
