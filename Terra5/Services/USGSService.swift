//
//  USGSService.swift
//  Terra5
//
//  Service for fetching earthquake data from USGS API
//

import Foundation

actor USGSService {
    static let shared = USGSService()

    private let baseURL = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary"

    private init() {}

    enum FeedType: String {
        case hourAll = "all_hour"       // All earthquakes, past hour
        case dayAll = "all_day"         // All earthquakes, past day
        case weekAll = "all_week"       // All earthquakes, past week
        case daySignificant = "significant_day"
        case weekSignificant = "significant_week"
        case day25 = "2.5_day"          // M2.5+ past day
        case week25 = "2.5_week"        // M2.5+ past week
        case day45 = "4.5_day"          // M4.5+ past day
        case week45 = "4.5_week"        // M4.5+ past week
    }

    /// Fetch earthquakes for specified feed type
    func fetchEarthquakes(feed: FeedType = .dayAll) async throws -> [Earthquake] {
        let urlString = "\(baseURL)/\(feed.rawValue).geojson"

        guard let url = URL(string: urlString) else {
            throw USGSError.invalidURL
        }

        var request = URLRequest(url: url)
        request.timeoutInterval = 30

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw USGSError.invalidResponse
        }

        guard httpResponse.statusCode == 200 else {
            throw USGSError.httpError(httpResponse.statusCode)
        }

        return try parseResponse(data)
    }

    /// Fetch earthquakes within date range and magnitude
    func fetchEarthquakes(
        startTime: Date,
        endTime: Date = Date(),
        minMagnitude: Double = 2.5,
        maxMagnitude: Double? = nil,
        limit: Int = 1000
    ) async throws -> [Earthquake] {
        var components = URLComponents(string: "https://earthquake.usgs.gov/fdsnws/event/1/query")!

        let dateFormatter = ISO8601DateFormatter()

        var queryItems = [
            URLQueryItem(name: "format", value: "geojson"),
            URLQueryItem(name: "starttime", value: dateFormatter.string(from: startTime)),
            URLQueryItem(name: "endtime", value: dateFormatter.string(from: endTime)),
            URLQueryItem(name: "minmagnitude", value: String(minMagnitude)),
            URLQueryItem(name: "limit", value: String(limit)),
            URLQueryItem(name: "orderby", value: "time")
        ]

        if let maxMag = maxMagnitude {
            queryItems.append(URLQueryItem(name: "maxmagnitude", value: String(maxMag)))
        }

        components.queryItems = queryItems

        guard let url = components.url else {
            throw USGSError.invalidURL
        }

        var request = URLRequest(url: url)
        request.timeoutInterval = 30

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw USGSError.invalidResponse
        }

        return try parseResponse(data)
    }

    private func parseResponse(_ data: Data) throws -> [Earthquake] {
        let decoder = JSONDecoder()
        let response = try decoder.decode(USGSResponse.self, from: data)

        return response.features.compactMap { Earthquake.from(feature: $0) }
    }
}

enum USGSError: LocalizedError {
    case invalidURL
    case invalidResponse
    case httpError(Int)
    case parsingError

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid API URL"
        case .invalidResponse:
            return "Invalid response from server"
        case .httpError(let code):
            return "HTTP error: \(code)"
        case .parsingError:
            return "Failed to parse earthquake data"
        }
    }
}
