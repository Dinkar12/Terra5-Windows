//
//  Earthquake.swift
//  Terra5
//
//  Model for earthquake data from USGS
//

import Foundation
import MapKit

struct Earthquake: Identifiable, Equatable {
    let id: String
    let magnitude: Double
    let place: String
    let time: Date
    let longitude: Double
    let latitude: Double
    let depth: Double // km
    let tsunami: Bool
    let significance: Int

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    var formattedMagnitude: String {
        String(format: "M%.1f", magnitude)
    }

    var severityColor: String {
        switch magnitude {
        case ..<3: return "minor"
        case 3..<5: return "moderate"
        case 5..<7: return "strong"
        default: return "major"
        }
    }

    var depthCategory: String {
        switch depth {
        case ..<70: return "Shallow"
        case 70..<300: return "Intermediate"
        default: return "Deep"
        }
    }
}

// MARK: - USGS GeoJSON Response
struct USGSResponse: Codable {
    let type: String
    let metadata: USGSMetadata
    let features: [USGSFeature]

    struct USGSMetadata: Codable {
        let generated: Int
        let url: String
        let title: String
        let count: Int
    }

    struct USGSFeature: Codable {
        let type: String
        let properties: USGSProperties
        let geometry: USGSGeometry
        let id: String

        struct USGSProperties: Codable {
            let mag: Double?
            let place: String?
            let time: Int
            let updated: Int?
            let tsunami: Int?
            let sig: Int?
            let title: String?
        }

        struct USGSGeometry: Codable {
            let type: String
            let coordinates: [Double] // [longitude, latitude, depth]
        }
    }
}

extension Earthquake {
    static func from(feature: USGSResponse.USGSFeature) -> Earthquake? {
        let props = feature.properties
        let coords = feature.geometry.coordinates

        guard coords.count >= 3 else { return nil }

        return Earthquake(
            id: feature.id,
            magnitude: props.mag ?? 0,
            place: props.place ?? "Unknown location",
            time: Date(timeIntervalSince1970: TimeInterval(props.time) / 1000),
            longitude: coords[0],
            latitude: coords[1],
            depth: coords[2],
            tsunami: (props.tsunami ?? 0) == 1,
            significance: props.sig ?? 0
        )
    }
}
