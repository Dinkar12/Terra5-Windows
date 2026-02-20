//
//  Terra5App.swift
//  Terra5
//
//  WORLDVIEW Geospatial Intelligence Platform
//

import SwiftUI

@main
struct Terra5App: App {
    var body: some Scene {
        WindowGroup {
            MainView()
                .frame(minWidth: 1024, minHeight: 768)
        }
        .windowStyle(.hiddenTitleBar)
        .defaultSize(width: 1440, height: 900)
        .commands {
            // Custom menu commands
            CommandGroup(replacing: .newItem) { }

            CommandMenu("View") {
                Button("Toggle Sidebar") {
                    NotificationCenter.default.post(name: .toggleSidebar, object: nil)
                }
                .keyboardShortcut("s", modifiers: [.command, .shift])

                Divider()

                ForEach(VisualMode.allCases) { mode in
                    Button(mode.displayName) {
                        NotificationCenter.default.post(
                            name: .setVisualMode,
                            object: mode
                        )
                    }
                }
            }

            CommandMenu("Locations") {
                ForEach(CityPreset.presets) { city in
                    Button(city.name) {
                        NotificationCenter.default.post(
                            name: .flyToCity,
                            object: city
                        )
                    }
                }
            }
        }
    }
}

// MARK: - Notification Names
extension Notification.Name {
    static let toggleSidebar = Notification.Name("toggleSidebar")
    static let setVisualMode = Notification.Name("setVisualMode")
    static let flyToCity = Notification.Name("flyToCity")
}
