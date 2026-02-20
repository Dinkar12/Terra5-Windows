# Terra5 - WORLDVIEW Geospatial Intelligence Platform

## Context
Building a macOS app that replicates the "WORLDVIEW" geospatial intelligence demo - a tactical surveillance-style interface with live flight tracking, satellite positions, weather radar, and AI object detection. The goal is to create a polished, full-featured clone using publicly available APIs.

**Design Requirements:**
- Dark background: `#0a0a0a`
- Accent color: `#00d4aa` (cyan/teal)
- Tactical HUD styling with fake classification headers

---

## Architecture Overview

**Hybrid Approach:** SwiftUI native shell + WKWebView with Cesium.js for 3D globe

```
┌─────────────────────────────────────────────────────────┐
│                    SwiftUI Shell                        │
│  ┌──────────┐  ┌─────────────────────┐  ┌───────────┐  │
│  │ Sidebar  │  │   WKWebView         │  │ HUD       │  │
│  │ (native) │  │   (Cesium.js)       │  │ (native)  │  │
│  └──────────┘  └─────────────────────┘  └───────────┘  │
└─────────────────────────────────────────────────────────┘
              ▲              ▲
              │   JS Bridge  │
              └──────────────┘
```

---

## Project Structure

```
Terra5/
├── Terra5App.swift
├── App/
│   ├── AppState.swift              # Global state (ObservableObject)
│   └── AppConstants.swift          # Colors, fonts, API endpoints
├── Views/
│   ├── MainView.swift              # Primary layout container
│   ├── Sidebar/
│   │   ├── SidebarView.swift
│   │   ├── DataLayerToggle.swift
│   │   ├── CityPresetPicker.swift
│   │   └── VisualModePicker.swift
│   ├── HUD/
│   │   ├── ClassificationHeader.swift
│   │   ├── TacticalHUDView.swift
│   │   ├── CoordinatesDisplay.swift
│   │   └── CompassView.swift
│   └── Globe/
│       ├── CesiumWebView.swift     # WKWebView wrapper
│       └── CesiumCoordinator.swift # JS bridge handler
├── ViewModels/
│   ├── GlobeViewModel.swift
│   ├── FlightDataViewModel.swift
│   └── SatelliteViewModel.swift
├── Services/
│   ├── OpenSkyService.swift        # Live flights API
│   ├── CelesTrakService.swift      # Satellite TLEs
│   ├── USGSService.swift           # Earthquakes
│   ├── NOAAService.swift           # Weather radar
│   └── PANOPTICService.swift       # CoreML detection
├── Models/
│   ├── Flight.swift
│   ├── Satellite.swift
│   ├── Earthquake.swift
│   └── VisualMode.swift
├── Resources/
│   └── Web/
│       └── cesium/
│           ├── index.html
│           ├── globe-controller.js
│           ├── layer-renderers.js
│           └── visual-filters.js
└── Extensions/
    └── Color+Theme.swift
```

---

## Data Sources (Public APIs)

| Layer | API | Update Frequency |
|-------|-----|------------------|
| Live Flights | OpenSky Network | 10 seconds |
| Satellites | CelesTrak TLE | 6 hours |
| Earthquakes | USGS GeoJSON | 5 minutes |
| Weather Radar | NOAA NEXRAD | 5 minutes |
| CCTV | City-specific | Varies |

---

## Visual Modes

| Mode | Implementation |
|------|----------------|
| Normal | Default Cesium imagery |
| CRT | GLSL shader (scanlines, barrel distortion, green tint) |
| NVG | GLSL shader (green phosphor, noise, high contrast) |
| FLIR | GLSL shader (thermal gradient colormap) |
| Anime | GLSL shader (edge detection, flat colors) |
| Noir | GLSL shader (desaturated, high contrast B&W) |
| Snow | GLSL shader (blue tint, desaturation) |

---

## Implementation Phases

### Phase 1: Foundation (Days 1-3)
- [ ] Create folder structure
- [ ] Add Cesium.js to Resources/Web
- [ ] Implement `CesiumWebView.swift` with basic WKWebView
- [ ] Create `index.html` with Cesium initialization
- [ ] Implement dark theme colors (`Color+Theme.swift`)
- [ ] Basic `MainView.swift` layout

**Deliverable:** Interactive 3D globe with dark styling

### Phase 2: Tactical UI (Days 4-6)
- [ ] `ClassificationHeader.swift` (TOP SECRET styling)
- [ ] `SidebarView.swift` with collapse animation
- [ ] `DataLayerToggle.swift` components
- [ ] `TacticalHUDView.swift` with coordinates display
- [ ] `CityPresetPicker.swift` with 8 cities
- [ ] `VisualModePicker.swift` with all modes

**Deliverable:** Complete tactical UI framework

### Phase 3: Live Data (Days 7-10)
- [ ] `OpenSkyService.swift` - fetch ~6K flights
- [ ] `FlightDataViewModel.swift` with auto-refresh
- [ ] `layer-renderers.js` - render aircraft on globe
- [ ] `CelesTrakService.swift` - satellite TLEs
- [ ] SGP4 propagation (use satellite.js)
- [ ] `USGSService.swift` - earthquake data

**Deliverable:** Live flight/satellite/earthquake data

### Phase 4: Visual Filters (Days 11-13)
- [ ] `visual-filters.js` - GLSL post-processing
- [ ] CRT shader implementation
- [ ] NVG shader implementation
- [ ] FLIR thermal shader
- [ ] Other stylized modes
- [ ] SwiftUI scanline overlay (optional)

**Deliverable:** All visual modes working

### Phase 5: Advanced Features (Days 14-17)
- [ ] Weather radar integration (NOAA)
- [ ] CCTV camera markers
- [ ] Landmark quick-jump buttons
- [ ] `PANOPTICService.swift` - CoreML detection
- [ ] Bounding box overlay for detections

**Deliverable:** Full feature set

### Phase 6: Polish (Days 18-20)
- [ ] Performance optimization
- [ ] Keyboard shortcuts
- [ ] Settings persistence
- [ ] Window management
- [ ] Final UI refinements

---

## Key Files to Modify

1. **Terra5/ContentView.swift** - Replace with MainView composition
2. **Terra5/Terra5App.swift** - Add AppState environment

## Key Files to Create

1. **Resources/Web/cesium/index.html** - Cesium container
2. **Resources/Web/cesium/globe-controller.js** - Globe initialization & bridge
3. **Views/Globe/CesiumWebView.swift** - WKWebView wrapper
4. **Views/Globe/CesiumCoordinator.swift** - JS message handling
5. **App/AppState.swift** - Global observable state
6. **App/AppConstants.swift** - Theme colors, typography

---

## Dependencies

**Required:**
- Cesium Ion token (free at cesium.com)
- Share Tech Mono font (Google Fonts)

**JavaScript (embedded):**
- Cesium.js 1.114+
- satellite.js 4.1+ (TLE propagation)

**Optional:**
- YOLOv8 CoreML model (for PANOPTIC detection)

---

## Verification

1. **Globe rendering:** App launches with interactive 3D globe
2. **Live data:** Aircraft icons appear and update every 10s
3. **Visual modes:** Switching modes applies correct filters
4. **City presets:** Flying to cities animates smoothly
5. **HUD:** Coordinates update as camera moves
6. **Detection:** PANOPTIC shows bounding boxes when enabled

---

## Notes

- Network entitlement required for API calls
- Cesium can be memory-intensive - implement entity cleanup
- Visual shaders are GPU-accelerated via WebGL
- All data sources are publicly available, no special API keys needed (except Cesium Ion for terrain)
