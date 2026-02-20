//
//  AppState.swift
//  Terra5
//
//  Global application state
//

import SwiftUI
import Combine

@MainActor
class AppState: ObservableObject {
    // MARK: - Visual State
    @Published var visualMode: VisualMode = .normal
    @Published var isSidebarExpanded: Bool = true
    @Published var isPanopticActive: Bool = false

    // MARK: - Data Layers
    @Published var activeLayers: Set<DataLayerType> = [.flights, .satellites, .earthquakes]

    // MARK: - Location State
    @Published var currentCity: CityPreset = CityPreset.presets[0]
    @Published var selectedLandmark: Landmark?

    // MARK: - Camera State (updated from MapKit)
    @Published var cameraLatitude: Double = 38.9072
    @Published var cameraLongitude: Double = -77.0369
    @Published var cameraAltitude: Double = 10_000_000
    @Published var cameraHeading: Double = 0

    // MARK: - Live Data Arrays
    @Published var flights: [Flight] = []
    @Published var satellites: [Satellite] = []
    @Published var earthquakes: [Earthquake] = []

    // MARK: - Data Counts (computed)
    var flightCount: Int { flights.count }
    var satelliteCount: Int { satellites.count }
    var earthquakeCount: Int { earthquakes.count }

    // MARK: - Timestamps
    @Published var flightsLastUpdate: Date?
    @Published var satellitesLastUpdate: Date?
    @Published var earthquakesLastUpdate: Date?

    // MARK: - Loading States
    @Published var isLoadingFlights: Bool = false
    @Published var isLoadingSatellites: Bool = false
    @Published var isLoadingEarthquakes: Bool = false

    // MARK: - Error States
    @Published var flightsError: String?
    @Published var satellitesError: String?
    @Published var earthquakesError: String?

    // MARK: - Globe Ready State
    @Published var isGlobeReady: Bool = false

    // MARK: - Detection State
    @Published var detectionCount: Int = 0
    @Published var detectionDensity: Double = 0
    @Published var detectionLatency: Double = 0

    // MARK: - Data Manager
    private var dataManager: DataManager?

    func startDataRefresh() {
        dataManager = DataManager(appState: self)
        dataManager?.startRefreshing()
    }

    func stopDataRefresh() {
        dataManager?.stopRefreshing()
    }

    // MARK: - Methods
    func toggleLayer(_ layer: DataLayerType) {
        if activeLayers.contains(layer) {
            activeLayers.remove(layer)
        } else {
            activeLayers.insert(layer)
        }
    }

    func isLayerActive(_ layer: DataLayerType) -> Bool {
        activeLayers.contains(layer)
    }

    func selectCity(_ city: CityPreset) {
        currentCity = city
        selectedLandmark = nil
    }

    func selectLandmark(_ landmark: Landmark) {
        selectedLandmark = landmark
    }

    // MARK: - Computed Properties
    var formattedAltitude: String {
        if cameraAltitude >= 1_000_000 {
            return String(format: "%.1fM", cameraAltitude / 1_000_000)
        } else if cameraAltitude >= 1000 {
            return String(format: "%.1fK", cameraAltitude / 1000)
        } else {
            return String(format: "%.0f", cameraAltitude)
        }
    }

    var formattedCoordinates: String {
        let latDir = cameraLatitude >= 0 ? "N" : "S"
        let lonDir = cameraLongitude >= 0 ? "E" : "W"
        return String(format: "%.4f°%@ %.4f°%@",
                     abs(cameraLatitude), latDir,
                     abs(cameraLongitude), lonDir)
    }

    var mgrsCoordinates: String {
        // Simplified MGRS-style display
        return String(format: "MGRS: %02d%@ %05d %05d",
                     Int((cameraLongitude + 180) / 6) + 1,
                     mgrsLatitudeBand,
                     Int(abs(cameraLongitude).truncatingRemainder(dividingBy: 6) * 100000 / 6),
                     Int(abs(cameraLatitude).truncatingRemainder(dividingBy: 8) * 100000 / 8))
    }

    private var mgrsLatitudeBand: String {
        let bands = "CDEFGHJKLMNPQRSTUVWX"
        let index = min(max(Int((cameraLatitude + 80) / 8), 0), bands.count - 1)
        return String(bands[bands.index(bands.startIndex, offsetBy: index)])
    }

    var gsdValue: String {
        // Ground Sample Distance - varies with altitude
        let gsd = cameraAltitude * 0.00001 // Simplified calculation
        if gsd >= 1 {
            return String(format: "%.2fM", gsd)
        } else {
            return String(format: "%.2fcm", gsd * 100)
        }
    }

    var niirsValue: String {
        // NIIRS rating (simplified - higher is better, lower altitude = higher rating)
        let rating = max(0, min(9, 9 - log10(cameraAltitude / 1000)))
        return String(format: "%.1f", rating)
    }

    var currentTime: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        formatter.timeZone = TimeZone(identifier: "UTC")
        return formatter.string(from: Date()) + "Z"
    }

    var recordingTimestamp: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone = TimeZone(identifier: "UTC")
        return "REC " + formatter.string(from: Date()) + "Z"
    }
}
