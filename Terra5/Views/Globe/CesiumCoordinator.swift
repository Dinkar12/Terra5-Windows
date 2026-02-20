//
//  CesiumCoordinator.swift
//  Terra5
//
//  Handles bidirectional communication between Swift and Cesium.js
//

import WebKit
import SwiftUI

class CesiumCoordinator: NSObject, WKNavigationDelegate, WKScriptMessageHandler {
    weak var webView: WKWebView?
    var appState: AppState

    // Track what needs to sync
    private var lastVisualMode: VisualMode = .normal
    private var lastActiveLayers: Set<DataLayerType> = []
    private var pendingFlyTo: (lat: Double, lon: Double, alt: Double)?

    init(appState: AppState) {
        self.appState = appState
        super.init()
    }

    // MARK: - WKScriptMessageHandler
    func userContentController(_ userContentController: WKUserContentController,
                               didReceive message: WKScriptMessage) {
        Task { @MainActor in
            switch message.name {
            case "globeReady":
                handleGlobeReady(message.body)
            case "cameraChanged":
                handleCameraChange(message.body)
            case "entityClicked":
                handleEntityClick(message.body)
            case "dataUpdated":
                handleDataUpdated(message.body)
            default:
                print("Unknown message: \(message.name)")
            }
        }
    }

    // MARK: - Message Handlers
    private func handleGlobeReady(_ body: Any) {
        print("Globe ready!")
        Task { @MainActor in
            appState.isGlobeReady = true
            // Initial sync
            syncVisualMode()
            syncLayerVisibility()
        }
    }

    private func handleCameraChange(_ body: Any) {
        guard let dict = body as? [String: Any] else { return }

        Task { @MainActor in
            if let lat = dict["latitude"] as? Double {
                appState.cameraLatitude = lat
            }
            if let lon = dict["longitude"] as? Double {
                appState.cameraLongitude = lon
            }
            if let alt = dict["altitude"] as? Double {
                appState.cameraAltitude = alt
            }
            if let heading = dict["heading"] as? Double {
                appState.cameraHeading = heading
            }
        }
    }

    private func handleEntityClick(_ body: Any) {
        guard let dict = body as? [String: Any] else { return }
        print("Entity clicked: \(dict)")
        // Handle entity selection - could show detail panel
    }

    private func handleDataUpdated(_ body: Any) {
        // NOTE: Data updates are now handled by DataManager with MapKit
        // This Cesium coordinator is kept for potential future WebView use
        guard let dict = body as? [String: Any],
              let layer = dict["layer"] as? String,
              let _ = dict["count"] as? Int else { return }

        Task { @MainActor in
            switch layer {
            case "flights":
                appState.flightsLastUpdate = Date()
            case "satellites":
                appState.satellitesLastUpdate = Date()
            case "earthquakes":
                appState.earthquakesLastUpdate = Date()
            default:
                break
            }
        }
    }

    // MARK: - State Synchronization
    func syncState(with state: AppState) {
        guard state.isGlobeReady else { return }

        // Check if visual mode changed
        if state.visualMode != lastVisualMode {
            lastVisualMode = state.visualMode
            syncVisualMode()
        }

        // Check if active layers changed
        if state.activeLayers != lastActiveLayers {
            let added = state.activeLayers.subtracting(lastActiveLayers)
            let removed = lastActiveLayers.subtracting(state.activeLayers)

            for layer in added {
                setLayerVisibility(layer, visible: true)
            }
            for layer in removed {
                setLayerVisibility(layer, visible: false)
            }

            lastActiveLayers = state.activeLayers
        }

        // Handle fly-to requests
        if let landmark = state.selectedLandmark {
            flyTo(latitude: landmark.latitude, longitude: landmark.longitude, altitude: landmark.zoomAltitude)
            Task { @MainActor in
                state.selectedLandmark = nil
            }
        }
    }

    private func syncVisualMode() {
        let js = "Terra5.setVisualMode('\(appState.visualMode.rawValue)')"
        executeJS(js)
    }

    private func syncLayerVisibility() {
        for layer in DataLayerType.allCases {
            let visible = appState.activeLayers.contains(layer)
            setLayerVisibility(layer, visible: visible)
        }
    }

    // MARK: - JavaScript Commands
    func flyTo(latitude: Double, longitude: Double, altitude: Double, duration: Double = 2.0) {
        let js = "Terra5.flyTo(\(latitude), \(longitude), \(altitude), \(duration))"
        executeJS(js)
    }

    func flyToCity(_ city: CityPreset) {
        flyTo(latitude: city.latitude, longitude: city.longitude, altitude: city.defaultAltitude)
    }

    func setLayerVisibility(_ layer: DataLayerType, visible: Bool) {
        let js = "Terra5.setLayerVisibility('\(layer.rawValue)', \(visible))"
        executeJS(js)
    }

    func updateFlights(_ flights: [[String: Any]]) {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: flights),
              let jsonString = String(data: jsonData, encoding: .utf8) else { return }
        let js = "Terra5.updateFlights(\(jsonString))"
        executeJS(js)
    }

    func updateSatellites(_ satellites: [[String: Any]]) {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: satellites),
              let jsonString = String(data: jsonData, encoding: .utf8) else { return }
        let js = "Terra5.updateSatellites(\(jsonString))"
        executeJS(js)
    }

    func updateEarthquakes(_ earthquakes: [[String: Any]]) {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: earthquakes),
              let jsonString = String(data: jsonData, encoding: .utf8) else { return }
        let js = "Terra5.updateEarthquakes(\(jsonString))"
        executeJS(js)
    }

    private func executeJS(_ js: String) {
        DispatchQueue.main.async { [weak self] in
            self?.webView?.evaluateJavaScript(js) { result, error in
                if let error = error {
                    print("JS Error: \(error.localizedDescription)")
                }
            }
        }
    }

    // MARK: - WKNavigationDelegate
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("WebView finished loading")
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("WebView failed: \(error.localizedDescription)")
    }
}
