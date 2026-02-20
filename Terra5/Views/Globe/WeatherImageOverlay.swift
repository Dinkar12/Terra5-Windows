//
//  WeatherImageOverlay.swift
//  Terra5
//
//  SwiftUI-based weather overlay that composites weather tiles as an image
//  on top of the 3D globe. This approach works regardless of map type.
//

import SwiftUI
import MapKit

struct WeatherImageOverlay: View {
    @EnvironmentObject var appState: AppState
    let layerType: WeatherLayerType

    @State private var weatherImage: NSImage?
    @State private var isLoading = false
    @State private var lastUpdate: Date?

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if let image = weatherImage {
                    Image(nsImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .opacity(0.6)
                        .allowsHitTesting(false)
                }

                if isLoading {
                    ProgressView()
                        .scaleEffect(0.5)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                        .padding(8)
                }
            }
        }
        .onAppear {
            loadWeatherImage()
        }
        .onChange(of: layerType) { _ in
            loadWeatherImage()
        }
        .onChange(of: appState.cameraLatitude) { _ in
            // Debounce updates when camera moves
            debounceLoadWeatherImage()
        }
    }

    private func debounceLoadWeatherImage() {
        // Only update every 2 seconds to avoid too many requests
        if let last = lastUpdate, Date().timeIntervalSince(last) < 2 {
            return
        }
        loadWeatherImage()
    }

    private func loadWeatherImage() {
        isLoading = true
        lastUpdate = Date()

        Task {
            let timestamp = await WeatherRadarService.shared.getLatestRadarTimestamp()
            guard timestamp > 0 else {
                await MainActor.run { isLoading = false }
                return
            }

            // Calculate tile coordinates based on camera position
            let zoom = calculateZoomLevel()
            let (tileX, tileY) = latLonToTile(
                lat: appState.cameraLatitude,
                lon: appState.cameraLongitude,
                zoom: zoom
            )

            // Build the tile URL based on layer type
            let urlString: String
            switch layerType {
            case .rain:
                urlString = "https://tilecache.rainviewer.com/v2/radar/\(timestamp)/512/\(zoom)/\(tileX)/\(tileY)/6/1_1.png"
            case .clouds:
                urlString = "https://tilecache.rainviewer.com/v2/satellite/\(timestamp)/512/\(zoom)/\(tileX)/\(tileY)/0/0_0.png"
            case .temperature:
                urlString = "https://tilecache.rainviewer.com/v2/radar/\(timestamp)/512/\(zoom)/\(tileX)/\(tileY)/2/1_1.png"
            }

            NSLog("[TERRA5] WeatherImageOverlay: Loading tile from %@", urlString)

            guard let url = URL(string: urlString) else {
                await MainActor.run { isLoading = false }
                return
            }

            do {
                let (data, response) = try await URLSession.shared.data(from: url)

                if let httpResponse = response as? HTTPURLResponse {
                    NSLog("[TERRA5] WeatherImageOverlay: HTTP status %d, data size: %d bytes", httpResponse.statusCode, data.count)
                }

                if let image = NSImage(data: data) {
                    await MainActor.run {
                        self.weatherImage = image
                        self.isLoading = false
                    }
                    NSLog("[TERRA5] WeatherImageOverlay: Image loaded successfully")
                } else {
                    NSLog("[TERRA5] WeatherImageOverlay: Failed to create image from data")
                    await MainActor.run { isLoading = false }
                }
            } catch {
                NSLog("[TERRA5] WeatherImageOverlay: Error loading tile: %@", error.localizedDescription)
                await MainActor.run { isLoading = false }
            }
        }
    }

    private func calculateZoomLevel() -> Int {
        // Calculate appropriate zoom level based on altitude
        let altitude = appState.cameraAltitude
        if altitude > 10_000_000 { return 2 }
        if altitude > 5_000_000 { return 3 }
        if altitude > 2_000_000 { return 4 }
        if altitude > 1_000_000 { return 5 }
        if altitude > 500_000 { return 6 }
        if altitude > 100_000 { return 7 }
        return 8
    }

    private func latLonToTile(lat: Double, lon: Double, zoom: Int) -> (Int, Int) {
        let n = Double(1 << zoom)
        let x = Int((lon + 180.0) / 360.0 * n)
        let latRad = lat * .pi / 180.0
        let y = Int((1.0 - asinh(tan(latRad)) / .pi) / 2.0 * n)
        return (x, y)
    }
}

#Preview {
    ZStack {
        Color.black
        WeatherImageOverlay(layerType: .rain)
            .environmentObject(AppState())
    }
    .frame(width: 800, height: 600)
}
