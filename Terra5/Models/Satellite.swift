//
//  Satellite.swift
//  Terra5
//
//  Model for satellite data from CelesTrak
//

import Foundation
import MapKit

struct Satellite: Identifiable, Equatable {
    let id: String // NORAD catalog number
    let name: String
    let line1: String // TLE line 1
    let line2: String // TLE line 2

    // Computed position (updated via SGP4 propagation)
    var longitude: Double = 0
    var latitude: Double = 0
    var altitude: Double = 0 // km

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    var altitudeFormatted: String {
        String(format: "%.0f km", altitude)
    }

    var category: SatelliteCategory {
        let nameLower = name.lowercased()
        if nameLower.contains("starlink") { return .starlink }
        if nameLower.contains("oneweb") { return .oneweb }
        if nameLower.contains("iss") || nameLower.contains("zarya") { return .station }
        if nameLower.contains("gps") || nameLower.contains("navstar") { return .navigation }
        if nameLower.contains("cosmos") || nameLower.contains("usa") { return .military }
        return .other
    }
}

enum SatelliteCategory: String, CaseIterable {
    case starlink = "Starlink"
    case oneweb = "OneWeb"
    case station = "Space Station"
    case navigation = "Navigation"
    case military = "Military"
    case other = "Other"

    var icon: String {
        switch self {
        case .starlink, .oneweb: return "antenna.radiowaves.left.and.right"
        case .station: return "house.fill"
        case .navigation: return "location.north.fill"
        case .military: return "shield.fill"
        case .other: return "circle.fill"
        }
    }
}

// MARK: - TLE Parsing
extension Satellite {
    /// Parse TLE (Two-Line Element) format
    /// Line 0: Name
    /// Line 1: 1 NNNNNC NNNNNAAA NNNNN.NNNNNNNN +.NNNNNNNN +NNNNN-N +NNNNN-N N NNNNN
    /// Line 2: 2 NNNNN NNN.NNNN NNN.NNNN NNNNNNN NNN.NNNN NNN.NNNN NN.NNNNNNNNNNNNNN
    static func from(tle: String) -> Satellite? {
        let lines = tle.components(separatedBy: .newlines).filter { !$0.isEmpty }
        guard lines.count >= 3 else { return nil }

        let name = lines[0].trimmingCharacters(in: .whitespaces)
        let line1 = lines[1]
        let line2 = lines[2]

        // Extract NORAD ID from line 2 (positions 2-6)
        guard line2.count > 7 else { return nil }
        let startIndex = line2.index(line2.startIndex, offsetBy: 2)
        let endIndex = line2.index(line2.startIndex, offsetBy: 7)
        let noradId = String(line2[startIndex..<endIndex]).trimmingCharacters(in: .whitespaces)

        return Satellite(
            id: noradId,
            name: name,
            line1: line1,
            line2: line2
        )
    }

    /// Parse multiple TLEs from a 3LE file
    static func parseMultiple(from data: String) -> [Satellite] {
        // Normalize line endings and filter out empty lines
        let normalizedData = data
            .replacingOccurrences(of: "\r\n", with: "\n")
            .replacingOccurrences(of: "\r", with: "\n")
        let lines = normalizedData.components(separatedBy: "\n")
            .map { $0.trimmingCharacters(in: .whitespaces) }
            .filter { !$0.isEmpty }

        var satellites: [Satellite] = []
        var i = 0

        while i < lines.count - 2 {
            let name = lines[i]
            let line1 = lines[i + 1]
            let line2 = lines[i + 2]

            // Validate TLE format (line1 starts with "1 " and line2 starts with "2 ")
            if line1.hasPrefix("1 ") && line2.hasPrefix("2 ") {
                if let sat = Satellite.from(tle: "\(name)\n\(line1)\n\(line2)") {
                    satellites.append(sat)
                }
                i += 3
            } else {
                i += 1
            }
        }

        return satellites
    }
}

// MARK: - Simple SGP4-like Position Estimation
extension Satellite {
    /// Simplified position calculation (not accurate SGP4, just for visualization)
    /// For accurate tracking, use a proper SGP4 library
    mutating func updatePosition(at date: Date = Date()) {
        // Extract orbital elements from TLE
        guard line2.count > 50 else { return }

        // Parse mean motion (revolutions per day) from line 2, positions 52-63
        let mmStart = line2.index(line2.startIndex, offsetBy: 52)
        let mmEnd = line2.index(line2.startIndex, offsetBy: min(63, line2.count))
        let meanMotionStr = String(line2[mmStart..<mmEnd]).trimmingCharacters(in: .whitespaces)
        let meanMotion = Double(meanMotionStr) ?? 15.0 // Default to ~LEO

        // Parse inclination from line 2, positions 8-16
        let incStart = line2.index(line2.startIndex, offsetBy: 8)
        let incEnd = line2.index(line2.startIndex, offsetBy: 16)
        let inclinationStr = String(line2[incStart..<incEnd]).trimmingCharacters(in: .whitespaces)
        let inclination = Double(inclinationStr) ?? 51.6 // Default to ISS-like

        // Parse RAAN (Right Ascension of Ascending Node) from line 2, positions 17-25
        let raanStart = line2.index(line2.startIndex, offsetBy: 17)
        let raanEnd = line2.index(line2.startIndex, offsetBy: 25)
        let raanStr = String(line2[raanStart..<raanEnd]).trimmingCharacters(in: .whitespaces)
        let raan = Double(raanStr) ?? 0

        // Estimate altitude from mean motion (Kepler's third law approximation)
        // a = (GM / (2π * n)^2)^(1/3) where n is mean motion in rad/s
        let earthRadius = 6371.0 // km
        let n = meanMotion * 2 * .pi / 86400 // Convert rev/day to rad/s
        let mu = 398600.4418 // Earth's gravitational parameter km³/s²
        let semiMajorAxis = pow(mu / (n * n), 1.0/3.0)
        altitude = semiMajorAxis - earthRadius

        // Simple position estimation based on time and orbital parameters
        let secondsSinceEpoch = date.timeIntervalSince1970.truncatingRemainder(dividingBy: 86400)
        let orbitalPeriod = 86400 / meanMotion // seconds
        let phase = (secondsSinceEpoch / orbitalPeriod) * 2 * .pi

        // Simplified ground track (not accurate but visually reasonable)
        let incRad = inclination * .pi / 180
        let raanRad = raan * .pi / 180

        latitude = asin(sin(incRad) * sin(phase)) * 180 / .pi
        longitude = (raanRad + atan2(cos(incRad) * sin(phase), cos(phase))) * 180 / .pi

        // Normalize longitude to -180 to 180
        while longitude > 180 { longitude -= 360 }
        while longitude < -180 { longitude += 360 }
    }
}
