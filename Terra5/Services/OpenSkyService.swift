//
//  OpenSkyService.swift
//  Terra5
//
//  Service for fetching live flight data from OpenSky Network API
//

import Foundation

actor OpenSkyService {
    static let shared = OpenSkyService()

    private let baseURL = "https://opensky-network.org/api/states/all"
    private var lastFetch: Date?
    private var cachedFlights: [Flight] = []

    // Rate limiting: OpenSky allows 1 request per 10 seconds for anonymous users
    private let minInterval: TimeInterval = 10

    private init() {}

    /// Fetch all flights worldwide
    func fetchFlights() async throws -> [Flight] {
        // Check rate limiting
        if let lastFetch = lastFetch,
           Date().timeIntervalSince(lastFetch) < minInterval {
            return cachedFlights
        }

        guard let url = URL(string: baseURL) else {
            throw OpenSkyError.invalidURL
        }

        var request = URLRequest(url: url)
        request.timeoutInterval = 30

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw OpenSkyError.invalidResponse
        }

        switch httpResponse.statusCode {
        case 200:
            break
        case 429:
            throw OpenSkyError.rateLimited
        case 503:
            throw OpenSkyError.serviceUnavailable
        default:
            throw OpenSkyError.httpError(httpResponse.statusCode)
        }

        let flights = try parseResponse(data)
        lastFetch = Date()
        cachedFlights = flights
        return flights
    }

    /// Fetch flights within a bounding box
    func fetchFlights(
        minLat: Double,
        maxLat: Double,
        minLon: Double,
        maxLon: Double
    ) async throws -> [Flight] {
        let urlString = "\(baseURL)?lamin=\(minLat)&lamax=\(maxLat)&lomin=\(minLon)&lomax=\(maxLon)"

        guard let url = URL(string: urlString) else {
            throw OpenSkyError.invalidURL
        }

        var request = URLRequest(url: url)
        request.timeoutInterval = 30

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw OpenSkyError.invalidResponse
        }

        return try parseResponse(data)
    }

    private func parseResponse(_ data: Data) throws -> [Flight] {
        guard let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
              let states = json["states"] as? [[Any]] else {
            // No flights or empty response
            return []
        }

        return states.compactMap { Flight.from(stateVector: $0) }
            .filter { !$0.onGround } // Only show airborne flights
    }
}

enum OpenSkyError: LocalizedError {
    case invalidURL
    case invalidResponse
    case rateLimited
    case serviceUnavailable
    case httpError(Int)
    case parsingError

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid API URL"
        case .invalidResponse:
            return "Invalid response from server"
        case .rateLimited:
            return "Rate limited - try again in 10 seconds"
        case .serviceUnavailable:
            return "OpenSky service temporarily unavailable"
        case .httpError(let code):
            return "HTTP error: \(code)"
        case .parsingError:
            return "Failed to parse flight data"
        }
    }
}
