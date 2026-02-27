//
//  MilitaryBase.swift
//  Terra5
//
//  Military base locations worldwide
//

import Foundation
import MapKit

struct MilitaryBase: Identifiable {
    let id: String
    let name: String
    let latitude: Double
    let longitude: Double
    let country: String
    let branch: Branch
    let baseType: BaseType
    let operatedBy: String
    let isOverseas: Bool

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    enum Branch: String, CaseIterable {
        case army = "ARMY"
        case navy = "NAVY"
        case airForce = "AIRFORCE"
        case marines = "MARINES"
        case spaceForce = "SPACE"
        case multiService = "MULTI"
        case foreign = "FOREIGN"

        var displayName: String {
            switch self {
            case .army: return "Army"
            case .navy: return "Navy"
            case .airForce: return "Air Force"
            case .marines: return "Marines"
            case .spaceForce: return "Space Force"
            case .multiService: return "Joint/Multi"
            case .foreign: return "Foreign"
            }
        }

        var icon: String {
            switch self {
            case .army: return "figure.stand"
            case .navy: return "ferry"
            case .airForce: return "airplane"
            case .marines: return "water.waves"
            case .spaceForce: return "sparkles"
            case .multiService: return "building.2.fill"
            case .foreign: return "globe"
            }
        }
    }

    enum BaseType: String, CaseIterable {
        case airBase = "AIR"
        case navalBase = "NAVAL"
        case armyPost = "ARMY_POST"
        case marineBase = "MARINE"
        case jointBase = "JOINT"
        case missileSilo = "SILO"
        case commandCenter = "COMMAND"
        case trainingFacility = "TRAINING"
        case intelligenceFacility = "INTEL"
        case foreignBase = "FOREIGN"

        var displayName: String {
            switch self {
            case .airBase: return "Air Base"
            case .navalBase: return "Naval Base"
            case .armyPost: return "Army Post"
            case .marineBase: return "Marine Base"
            case .jointBase: return "Joint Base"
            case .missileSilo: return "ICBM Silo"
            case .commandCenter: return "Command Center"
            case .trainingFacility: return "Training Facility"
            case .intelligenceFacility: return "Intelligence"
            case .foreignBase: return "Foreign Base"
            }
        }

        var icon: String {
            switch self {
            case .airBase: return "airplane.circle.fill"
            case .navalBase: return "ferry.fill"
            case .armyPost: return "figure.stand"
            case .marineBase: return "water.waves"
            case .jointBase: return "building.2.fill"
            case .missileSilo: return "bolt.circle.fill"
            case .commandCenter: return "laptopcomputer"
            case .trainingFacility: return "person.fill.and.arrow.left.and.arrow.right"
            case .intelligenceFacility: return "binoculars.circle.fill"
            case .foreignBase: return "globe"
            }
        }
    }
}

// MARK: - Worldwide Military Base Database
extension MilitaryBase {

    static let sampleBases: [MilitaryBase] = {
        var b: [MilitaryBase] = []

        // ═══════════════════════ UNITED STATES - DOMESTIC ARMY BASES ═══════════════════════

        b.append(contentsOf: [
            MilitaryBase(id: "US-ARMY-001", name: "Fort Liberty (Bragg)", latitude: 35.139, longitude: -79.006, country: "US", branch: .army, baseType: .armyPost, operatedBy: "United States", isOverseas: false),
            MilitaryBase(id: "US-ARMY-002", name: "Fort Cavazos (Hood)", latitude: 31.135, longitude: -97.776, country: "US", branch: .army, baseType: .armyPost, operatedBy: "United States", isOverseas: false),
            MilitaryBase(id: "US-ARMY-003", name: "Fort Moore (Benning)", latitude: 32.359, longitude: -84.949, country: "US", branch: .army, baseType: .armyPost, operatedBy: "United States", isOverseas: false),
            MilitaryBase(id: "US-ARMY-004", name: "Fort Campbell", latitude: 36.667, longitude: -87.475, country: "US", branch: .army, baseType: .armyPost, operatedBy: "United States", isOverseas: false),
            MilitaryBase(id: "US-ARMY-005", name: "Fort Drum", latitude: 44.055, longitude: -75.758, country: "US", branch: .army, baseType: .armyPost, operatedBy: "United States", isOverseas: false),
            MilitaryBase(id: "US-ARMY-006", name: "Fort Riley", latitude: 39.055, longitude: -96.826, country: "US", branch: .army, baseType: .armyPost, operatedBy: "United States", isOverseas: false),
            MilitaryBase(id: "US-ARMY-007", name: "Fort Eisenhower (Gordon)", latitude: 33.425, longitude: -82.133, country: "US", branch: .army, baseType: .armyPost, operatedBy: "United States", isOverseas: false),
            MilitaryBase(id: "US-ARMY-008", name: "Fort Novosel (Rucker)", latitude: 31.343, longitude: -85.729, country: "US", branch: .army, baseType: .armyPost, operatedBy: "United States", isOverseas: false),
            MilitaryBase(id: "US-ARMY-009", name: "Fort Huachuca", latitude: 31.554, longitude: -110.344, country: "US", branch: .army, baseType: .armyPost, operatedBy: "United States", isOverseas: false),
            MilitaryBase(id: "US-ARMY-010", name: "Fort Sill", latitude: 34.650, longitude: -98.400, country: "US", branch: .army, baseType: .armyPost, operatedBy: "United States", isOverseas: false),
            MilitaryBase(id: "US-ARMY-011", name: "Fort Irwin", latitude: 35.262, longitude: -116.683, country: "US", branch: .army, baseType: .armyPost, operatedBy: "United States", isOverseas: false),
            MilitaryBase(id: "US-ARMY-012", name: "Fort Johnson (Polk)", latitude: 31.045, longitude: -93.203, country: "US", branch: .army, baseType: .armyPost, operatedBy: "United States", isOverseas: false),
            MilitaryBase(id: "US-ARMY-013", name: "Fort Stewart", latitude: 31.872, longitude: -81.611, country: "US", branch: .army, baseType: .armyPost, operatedBy: "United States", isOverseas: false),
            MilitaryBase(id: "US-ARMY-014", name: "Fort Bliss", latitude: 31.817, longitude: -106.413, country: "US", branch: .army, baseType: .armyPost, operatedBy: "United States", isOverseas: false),
            MilitaryBase(id: "US-ARMY-015", name: "Fort Wainwright", latitude: 64.828, longitude: -147.638, country: "US", branch: .army, baseType: .armyPost, operatedBy: "United States", isOverseas: false),
            MilitaryBase(id: "US-ARMY-016", name: "Joint Base Lewis-McChord", latitude: 47.087, longitude: -122.579, country: "US", branch: .multiService, baseType: .jointBase, operatedBy: "United States", isOverseas: false),
            MilitaryBase(id: "US-ARMY-017", name: "West Point (USMA)", latitude: 41.391, longitude: -73.957, country: "US", branch: .army, baseType: .trainingFacility, operatedBy: "United States", isOverseas: false),
        ])

        // ═══════════════════════ UNITED STATES - DOMESTIC AIR FORCE BASES ═══════════════════════

        b.append(contentsOf: [
            MilitaryBase(id: "US-AF-001", name: "Nellis AFB", latitude: 36.236, longitude: -115.034, country: "US", branch: .airForce, baseType: .airBase, operatedBy: "United States", isOverseas: false),
            MilitaryBase(id: "US-AF-002", name: "Edwards AFB", latitude: 34.905, longitude: -117.884, country: "US", branch: .airForce, baseType: .airBase, operatedBy: "United States", isOverseas: false),
            MilitaryBase(id: "US-AF-003", name: "Eglin AFB", latitude: 30.483, longitude: -86.525, country: "US", branch: .airForce, baseType: .airBase, operatedBy: "United States", isOverseas: false),
            MilitaryBase(id: "US-AF-004", name: "Wright-Patterson AFB", latitude: 39.826, longitude: -84.048, country: "US", branch: .airForce, baseType: .airBase, operatedBy: "United States", isOverseas: false),
            MilitaryBase(id: "US-AF-005", name: "Travis AFB", latitude: 38.268, longitude: -121.927, country: "US", branch: .airForce, baseType: .airBase, operatedBy: "United States", isOverseas: false),
            MilitaryBase(id: "US-AF-006", name: "Joint Base Andrews", latitude: 38.811, longitude: -76.867, country: "US", branch: .multiService, baseType: .jointBase, operatedBy: "United States", isOverseas: false),
            MilitaryBase(id: "US-AF-007", name: "Vandenberg SFB", latitude: 34.733, longitude: -120.568, country: "US", branch: .spaceForce, baseType: .airBase, operatedBy: "United States", isOverseas: false),
            MilitaryBase(id: "US-AF-008", name: "Peterson SFB", latitude: 38.824, longitude: -104.700, country: "US", branch: .spaceForce, baseType: .airBase, operatedBy: "United States", isOverseas: false),
            MilitaryBase(id: "US-AF-009", name: "Schriever SFB", latitude: 38.797, longitude: -104.527, country: "US", branch: .spaceForce, baseType: .airBase, operatedBy: "United States", isOverseas: false),
            MilitaryBase(id: "US-AF-010", name: "Offutt AFB", latitude: 41.118, longitude: -95.912, country: "US", branch: .airForce, baseType: .commandCenter, operatedBy: "United States", isOverseas: false),
            MilitaryBase(id: "US-AF-011", name: "Barksdale AFB", latitude: 32.501, longitude: -93.663, country: "US", branch: .airForce, baseType: .airBase, operatedBy: "United States", isOverseas: false),
            MilitaryBase(id: "US-AF-012", name: "Whiteman AFB", latitude: 38.727, longitude: -93.548, country: "US", branch: .airForce, baseType: .airBase, operatedBy: "United States", isOverseas: false),
            MilitaryBase(id: "US-AF-013", name: "Tinker AFB", latitude: 35.415, longitude: -97.385, country: "US", branch: .airForce, baseType: .airBase, operatedBy: "United States", isOverseas: false),
            MilitaryBase(id: "US-AF-014", name: "Lackland AFB", latitude: 29.384, longitude: -98.616, country: "US", branch: .airForce, baseType: .trainingFacility, operatedBy: "United States", isOverseas: false),
            MilitaryBase(id: "US-AF-015", name: "Beale AFB", latitude: 39.136, longitude: -121.437, country: "US", branch: .airForce, baseType: .airBase, operatedBy: "United States", isOverseas: false),
            MilitaryBase(id: "US-AF-016", name: "Creech AFB", latitude: 36.583, longitude: -115.671, country: "US", branch: .airForce, baseType: .airBase, operatedBy: "United States", isOverseas: false),
        ])

        // ═══════════════════════ UNITED STATES - DOMESTIC NAVY/MARINES BASES ═══════════════════════

        b.append(contentsOf: [
            MilitaryBase(id: "US-NAVY-001", name: "Naval Station Norfolk", latitude: 36.946, longitude: -76.303, country: "US", branch: .navy, baseType: .navalBase, operatedBy: "United States", isOverseas: false),
            MilitaryBase(id: "US-NAVY-002", name: "Camp Pendleton", latitude: 33.333, longitude: -117.417, country: "US", branch: .marines, baseType: .marineBase, operatedBy: "United States", isOverseas: false),
            MilitaryBase(id: "US-NAVY-003", name: "Camp Lejeune", latitude: 34.625, longitude: -77.355, country: "US", branch: .marines, baseType: .marineBase, operatedBy: "United States", isOverseas: false),
            MilitaryBase(id: "US-NAVY-004", name: "Naval Base San Diego", latitude: 32.684, longitude: -117.149, country: "US", branch: .navy, baseType: .navalBase, operatedBy: "United States", isOverseas: false),
            MilitaryBase(id: "US-NAVY-005", name: "Naval Station Mayport", latitude: 30.390, longitude: -81.418, country: "US", branch: .navy, baseType: .navalBase, operatedBy: "United States", isOverseas: false),
            MilitaryBase(id: "US-NAVY-006", name: "Naval Air Station Pensacola", latitude: 30.352, longitude: -87.318, country: "US", branch: .navy, baseType: .airBase, operatedBy: "United States", isOverseas: false),
            MilitaryBase(id: "US-NAVY-007", name: "NAS Whidbey Island", latitude: 48.352, longitude: -122.655, country: "US", branch: .navy, baseType: .airBase, operatedBy: "United States", isOverseas: false),
            MilitaryBase(id: "US-NAVY-008", name: "Joint Base Pearl Harbor-Hickam", latitude: 21.348, longitude: -157.940, country: "US", branch: .multiService, baseType: .jointBase, operatedBy: "United States", isOverseas: false),
            MilitaryBase(id: "US-NAVY-009", name: "Naval Submarine Base Kings Bay", latitude: 30.796, longitude: -81.514, country: "US", branch: .navy, baseType: .navalBase, operatedBy: "United States", isOverseas: false),
            MilitaryBase(id: "US-NAVY-010", name: "Naval Base Kitsap", latitude: 47.564, longitude: -122.654, country: "US", branch: .navy, baseType: .navalBase, operatedBy: "United States", isOverseas: false),
        ])

        // ═══════════════════════ UNITED STATES - ICBM MISSILE BASES ═══════════════════════

        b.append(contentsOf: [
            MilitaryBase(id: "US-ICBM-001", name: "Malmstrom AFB", latitude: 47.506, longitude: -111.183, country: "US", branch: .airForce, baseType: .missileSilo, operatedBy: "United States", isOverseas: false),
            MilitaryBase(id: "US-ICBM-002", name: "Minot AFB", latitude: 48.416, longitude: -101.358, country: "US", branch: .airForce, baseType: .missileSilo, operatedBy: "United States", isOverseas: false),
            MilitaryBase(id: "US-ICBM-003", name: "F.E. Warren AFB", latitude: 41.153, longitude: -104.862, country: "US", branch: .airForce, baseType: .missileSilo, operatedBy: "United States", isOverseas: false),
        ])

        // ═══════════════════════ UNITED STATES - INTELLIGENCE/COMMAND ═══════════════════════

        b.append(contentsOf: [
            MilitaryBase(id: "US-CMD-001", name: "The Pentagon", latitude: 38.871, longitude: -77.056, country: "US", branch: .multiService, baseType: .commandCenter, operatedBy: "United States", isOverseas: false),
            MilitaryBase(id: "US-CMD-002", name: "NSA Fort Meade", latitude: 39.109, longitude: -76.772, country: "US", branch: .multiService, baseType: .intelligenceFacility, operatedBy: "United States", isOverseas: false),
            MilitaryBase(id: "US-CMD-003", name: "CIA Langley", latitude: 38.952, longitude: -77.146, country: "US", branch: .multiService, baseType: .intelligenceFacility, operatedBy: "United States", isOverseas: false),
            MilitaryBase(id: "US-CMD-004", name: "NORAD Cheyenne Mountain", latitude: 38.745, longitude: -104.844, country: "US", branch: .multiService, baseType: .commandCenter, operatedBy: "United States", isOverseas: false),
            MilitaryBase(id: "US-CMD-005", name: "Area 51 (Groom Lake)", latitude: 37.233, longitude: -115.811, country: "US", branch: .multiService, baseType: .trainingFacility, operatedBy: "United States", isOverseas: false),
        ])

        // ═══════════════════════ UNITED STATES - OVERSEAS BASES - GERMANY ═══════════════════════

        b.append(contentsOf: [
            MilitaryBase(id: "US-OVRSEAS-001", name: "Ramstein AB", latitude: 49.437, longitude: 7.600, country: "DE", branch: .airForce, baseType: .airBase, operatedBy: "United States", isOverseas: true),
            MilitaryBase(id: "US-OVRSEAS-002", name: "Spangdahlem AB", latitude: 49.973, longitude: 6.693, country: "DE", branch: .airForce, baseType: .airBase, operatedBy: "United States", isOverseas: true),
            MilitaryBase(id: "US-OVRSEAS-003", name: "Landstuhl Regional Med Center", latitude: 49.433, longitude: 7.552, country: "DE", branch: .army, baseType: .trainingFacility, operatedBy: "United States", isOverseas: true),
        ])

        // ═══════════════════════ UNITED STATES - OVERSEAS BASES - ITALY/SPAIN ═══════════════════════

        b.append(contentsOf: [
            MilitaryBase(id: "US-OVRSEAS-004", name: "Aviano AB", latitude: 46.032, longitude: 12.597, country: "IT", branch: .airForce, baseType: .airBase, operatedBy: "United States", isOverseas: true),
            MilitaryBase(id: "US-OVRSEAS-005", name: "Naval Station Rota", latitude: 36.642, longitude: -6.350, country: "ES", branch: .navy, baseType: .navalBase, operatedBy: "United States", isOverseas: true),
            MilitaryBase(id: "US-OVRSEAS-006", name: "NAS Sigonella", latitude: 37.402, longitude: 14.922, country: "IT", branch: .navy, baseType: .airBase, operatedBy: "United States", isOverseas: true),
        ])

        // ═══════════════════════ UNITED STATES - OVERSEAS BASES - UK ═══════════════════════

        b.append(contentsOf: [
            MilitaryBase(id: "US-OVRSEAS-007", name: "RAF Lakenheath", latitude: 52.409, longitude: 0.561, country: "GB", branch: .airForce, baseType: .airBase, operatedBy: "United States", isOverseas: true),
            MilitaryBase(id: "US-OVRSEAS-008", name: "RAF Mildenhall", latitude: 52.362, longitude: 0.486, country: "GB", branch: .airForce, baseType: .airBase, operatedBy: "United States", isOverseas: true),
            MilitaryBase(id: "US-OVRSEAS-009", name: "RAF Croughton", latitude: 51.993, longitude: -1.206, country: "GB", branch: .airForce, baseType: .intelligenceFacility, operatedBy: "United States", isOverseas: true),
        ])

        // ═══════════════════════ UNITED STATES - OVERSEAS BASES - TURKEY/MIDDLE EAST ═══════════════════════

        b.append(contentsOf: [
            MilitaryBase(id: "US-OVRSEAS-010", name: "Incirlik AB", latitude: 37.002, longitude: 35.426, country: "TR", branch: .airForce, baseType: .airBase, operatedBy: "United States", isOverseas: true),
            MilitaryBase(id: "US-OVRSEAS-011", name: "Camp Arifjan", latitude: 28.982, longitude: 48.094, country: "KW", branch: .army, baseType: .armyPost, operatedBy: "United States", isOverseas: true),
            MilitaryBase(id: "US-OVRSEAS-012", name: "Bahrain Naval Support Activity", latitude: 26.197, longitude: 50.592, country: "BH", branch: .navy, baseType: .navalBase, operatedBy: "United States", isOverseas: true),
            MilitaryBase(id: "US-OVRSEAS-013", name: "Al Udeid AB", latitude: 25.117, longitude: 51.315, country: "QA", branch: .airForce, baseType: .airBase, operatedBy: "United States", isOverseas: true),
            MilitaryBase(id: "US-OVRSEAS-014", name: "Al Dhafra AB", latitude: 24.248, longitude: 54.547, country: "AE", branch: .airForce, baseType: .airBase, operatedBy: "United States", isOverseas: true),
        ])

        // ═══════════════════════ UNITED STATES - OVERSEAS BASES - EAST ASIA ═══════════════════════

        b.append(contentsOf: [
            MilitaryBase(id: "US-OVRSEAS-015", name: "Camp Humphreys", latitude: 36.963, longitude: 127.031, country: "KR", branch: .army, baseType: .armyPost, operatedBy: "United States", isOverseas: true),
            MilitaryBase(id: "US-OVRSEAS-016", name: "Osan AB", latitude: 37.091, longitude: 127.030, country: "KR", branch: .airForce, baseType: .airBase, operatedBy: "United States", isOverseas: true),
            MilitaryBase(id: "US-OVRSEAS-017", name: "Kadena AB", latitude: 26.352, longitude: 127.767, country: "JP", branch: .airForce, baseType: .airBase, operatedBy: "United States", isOverseas: true),
            MilitaryBase(id: "US-OVRSEAS-018", name: "MCAS Iwakuni", latitude: 34.145, longitude: 132.236, country: "JP", branch: .marines, baseType: .airBase, operatedBy: "United States", isOverseas: true),
            MilitaryBase(id: "US-OVRSEAS-019", name: "Yokota AB", latitude: 35.748, longitude: 139.349, country: "JP", branch: .airForce, baseType: .airBase, operatedBy: "United States", isOverseas: true),
            MilitaryBase(id: "US-OVRSEAS-020", name: "Naval Base Yokosuka", latitude: 35.284, longitude: 139.671, country: "JP", branch: .navy, baseType: .navalBase, operatedBy: "United States", isOverseas: true),
            MilitaryBase(id: "US-OVRSEAS-021", name: "Camp Hansen", latitude: 26.455, longitude: 127.772, country: "JP", branch: .marines, baseType: .marineBase, operatedBy: "United States", isOverseas: true),
            MilitaryBase(id: "US-OVRSEAS-022", name: "Camp Schwab", latitude: 26.524, longitude: 127.948, country: "JP", branch: .marines, baseType: .marineBase, operatedBy: "United States", isOverseas: true),
        ])

        // ═══════════════════════ UNITED STATES - OVERSEAS BASES - AFRICA/INDIAN OCEAN ═══════════════════════

        b.append(contentsOf: [
            MilitaryBase(id: "US-OVRSEAS-023", name: "Camp Lemonnier", latitude: 11.548, longitude: 43.149, country: "DJ", branch: .multiService, baseType: .armyPost, operatedBy: "United States", isOverseas: true),
            MilitaryBase(id: "US-OVRSEAS-024", name: "Diego Garcia", latitude: -7.313, longitude: 72.411, country: "IO", branch: .navy, baseType: .navalBase, operatedBy: "United States", isOverseas: true),
        ])

        // ═══════════════════════ UNITED STATES - OVERSEAS BASES - ATLANTIC/CARIBBEAN ═══════════════════════

        b.append(contentsOf: [
            MilitaryBase(id: "US-OVRSEAS-025", name: "Thule AB", latitude: 76.531, longitude: -68.703, country: "GL", branch: .airForce, baseType: .airBase, operatedBy: "United States", isOverseas: true),
            MilitaryBase(id: "US-OVRSEAS-026", name: "Guantanamo Bay", latitude: 19.898, longitude: -75.096, country: "CU", branch: .navy, baseType: .navalBase, operatedBy: "United States", isOverseas: true),
            MilitaryBase(id: "US-OVRSEAS-027", name: "Joint Base Elmendorf-Richardson", latitude: 61.250, longitude: -149.807, country: "US", branch: .multiService, baseType: .jointBase, operatedBy: "United States", isOverseas: false),
        ])

        // ═══════════════════════ RUSSIA - WESTERN/MEDITERRANEAN ═══════════════════════

        b.append(contentsOf: [
            MilitaryBase(id: "RU-001", name: "Tartus Naval Base", latitude: 34.889, longitude: 35.887, country: "SY", branch: .navy, baseType: .navalBase, operatedBy: "Russia", isOverseas: true),
            MilitaryBase(id: "RU-002", name: "Khmeimim Air Base", latitude: 35.401, longitude: 35.949, country: "SY", branch: .airForce, baseType: .airBase, operatedBy: "Russia", isOverseas: true),
        ])

        // ═══════════════════════ RUSSIA - CAUCASUS/CENTRAL ASIA ═══════════════════════

        b.append(contentsOf: [
            MilitaryBase(id: "RU-003", name: "102nd Military Base", latitude: 40.795, longitude: 43.842, country: "AM", branch: .army, baseType: .armyPost, operatedBy: "Russia", isOverseas: true),
            MilitaryBase(id: "RU-004", name: "201st Military Base", latitude: 38.574, longitude: 68.774, country: "TJ", branch: .army, baseType: .armyPost, operatedBy: "Russia", isOverseas: true),
            MilitaryBase(id: "RU-005", name: "Kant Air Base", latitude: 42.853, longitude: 74.846, country: "KG", branch: .airForce, baseType: .airBase, operatedBy: "Russia", isOverseas: true),
            MilitaryBase(id: "RU-006", name: "Baikonur Cosmodrome", latitude: 45.620, longitude: 63.305, country: "KZ", branch: .spaceForce, baseType: .trainingFacility, operatedBy: "Russia", isOverseas: true),
        ])

        // ═══════════════════════ RUSSIA - DOMESTIC ═══════════════════════

        b.append(contentsOf: [
            MilitaryBase(id: "RU-007", name: "Sevastopol Naval Base", latitude: 44.616, longitude: 33.525, country: "RU", branch: .navy, baseType: .navalBase, operatedBy: "Russia", isOverseas: false),
            MilitaryBase(id: "RU-008", name: "Kaliningrad Exclave", latitude: 54.704, longitude: 20.500, country: "RU", branch: .multiService, baseType: .armyPost, operatedBy: "Russia", isOverseas: false),
            MilitaryBase(id: "RU-009", name: "Murmansk Northern Fleet", latitude: 68.973, longitude: 33.095, country: "RU", branch: .navy, baseType: .navalBase, operatedBy: "Russia", isOverseas: false),
            MilitaryBase(id: "RU-010", name: "Vladivostok Pacific Fleet", latitude: 43.116, longitude: 131.900, country: "RU", branch: .navy, baseType: .navalBase, operatedBy: "Russia", isOverseas: false),
            MilitaryBase(id: "RU-011", name: "Severomorsk Naval Base", latitude: 69.071, longitude: 33.418, country: "RU", branch: .navy, baseType: .navalBase, operatedBy: "Russia", isOverseas: false),
            MilitaryBase(id: "RU-012", name: "Plesetsk Cosmodrome", latitude: 62.960, longitude: 40.680, country: "RU", branch: .spaceForce, baseType: .trainingFacility, operatedBy: "Russia", isOverseas: false),
        ])

        // ═══════════════════════ CHINA - OVERSEAS ═══════════════════════

        b.append(contentsOf: [
            MilitaryBase(id: "CN-001", name: "PLA Support Base Djibouti", latitude: 11.590, longitude: 43.080, country: "DJ", branch: .navy, baseType: .navalBase, operatedBy: "China", isOverseas: true),
            MilitaryBase(id: "CN-002", name: "Ream Naval Base", latitude: 10.490, longitude: 103.617, country: "KH", branch: .navy, baseType: .navalBase, operatedBy: "China", isOverseas: true),
        ])

        // ═══════════════════════ CHINA - DOMESTIC ═══════════════════════

        b.append(contentsOf: [
            MilitaryBase(id: "CN-003", name: "Hainan Yulin Naval Base", latitude: 18.226, longitude: 109.572, country: "CN", branch: .navy, baseType: .navalBase, operatedBy: "China", isOverseas: false),
            MilitaryBase(id: "CN-004", name: "Dalian Naval Base", latitude: 38.870, longitude: 121.600, country: "CN", branch: .navy, baseType: .navalBase, operatedBy: "China", isOverseas: false),
            MilitaryBase(id: "CN-005", name: "Zhanjiang Naval Base", latitude: 21.271, longitude: 110.395, country: "CN", branch: .navy, baseType: .navalBase, operatedBy: "China", isOverseas: false),
        ])

        // ═══════════════════════ UNITED KINGDOM - DOMESTIC ═══════════════════════

        b.append(contentsOf: [
            MilitaryBase(id: "GB-001", name: "HMNB Portsmouth", latitude: 50.800, longitude: -1.106, country: "GB", branch: .navy, baseType: .navalBase, operatedBy: "United Kingdom", isOverseas: false),
            MilitaryBase(id: "GB-002", name: "HMNB Devonport", latitude: 50.385, longitude: -4.186, country: "GB", branch: .navy, baseType: .navalBase, operatedBy: "United Kingdom", isOverseas: false),
            MilitaryBase(id: "GB-003", name: "HMNB Clyde (Faslane)", latitude: 56.070, longitude: -4.817, country: "GB", branch: .navy, baseType: .navalBase, operatedBy: "United Kingdom", isOverseas: false),
        ])

        // ═══════════════════════ UNITED KINGDOM - OVERSEAS ═══════════════════════

        b.append(contentsOf: [
            MilitaryBase(id: "GB-004", name: "RAF Akrotiri", latitude: 34.590, longitude: 32.988, country: "CY", branch: .airForce, baseType: .airBase, operatedBy: "United Kingdom", isOverseas: true),
            MilitaryBase(id: "GB-005", name: "RAF Gibraltar", latitude: 36.151, longitude: -5.350, country: "GI", branch: .airForce, baseType: .airBase, operatedBy: "United Kingdom", isOverseas: true),
            MilitaryBase(id: "GB-006", name: "Mount Pleasant Falklands", latitude: -51.822, longitude: -59.001, country: "FK", branch: .multiService, baseType: .armyPost, operatedBy: "United Kingdom", isOverseas: true),
        ])

        // ═══════════════════════ FRANCE - DOMESTIC/OVERSEAS ═══════════════════════

        b.append(contentsOf: [
            MilitaryBase(id: "FR-001", name: "Toulon Naval Base", latitude: 43.122, longitude: 5.929, country: "FR", branch: .navy, baseType: .navalBase, operatedBy: "France", isOverseas: false),
            MilitaryBase(id: "FR-002", name: "Base aérienne 104 Al Dhafra", latitude: 24.248, longitude: 54.547, country: "AE", branch: .airForce, baseType: .airBase, operatedBy: "France", isOverseas: true),
            MilitaryBase(id: "FR-003", name: "French Forces Djibouti", latitude: 11.548, longitude: 43.145, country: "DJ", branch: .multiService, baseType: .armyPost, operatedBy: "France", isOverseas: true),
            MilitaryBase(id: "FR-004", name: "Reunion Island Military", latitude: -20.879, longitude: 55.460, country: "RE", branch: .multiService, baseType: .armyPost, operatedBy: "France", isOverseas: true),
        ])

        // ═══════════════════════ TURKEY - OVERSEAS ═══════════════════════

        b.append(contentsOf: [
            MilitaryBase(id: "TR-001", name: "Al-Watiya Air Base", latitude: 31.775, longitude: 12.014, country: "LY", branch: .airForce, baseType: .airBase, operatedBy: "Turkey", isOverseas: true),
            MilitaryBase(id: "TR-002", name: "Turkish Base Northern Cyprus", latitude: 35.280, longitude: 33.395, country: "CY", branch: .army, baseType: .armyPost, operatedBy: "Turkey", isOverseas: true),
            MilitaryBase(id: "TR-003", name: "Turkish Base Mogadishu", latitude: 2.033, longitude: 45.325, country: "SO", branch: .army, baseType: .armyPost, operatedBy: "Turkey", isOverseas: true),
            MilitaryBase(id: "TR-004", name: "Turkish Base Doha", latitude: 25.316, longitude: 51.468, country: "QA", branch: .army, baseType: .armyPost, operatedBy: "Turkey", isOverseas: true),
        ])

        // ═══════════════════════ NATO - COMMAND FACILITIES ═══════════════════════

        b.append(contentsOf: [
            MilitaryBase(id: "NATO-001", name: "NATO HQ Brussels", latitude: 50.879, longitude: 4.424, country: "BE", branch: .multiService, baseType: .commandCenter, operatedBy: "NATO", isOverseas: true),
            MilitaryBase(id: "NATO-002", name: "SHAPE Mons", latitude: 50.503, longitude: 3.834, country: "BE", branch: .multiService, baseType: .commandCenter, operatedBy: "NATO", isOverseas: true),
            MilitaryBase(id: "NATO-003", name: "Allied Joint Force Command Brunssum", latitude: 50.944, longitude: 5.976, country: "NL", branch: .multiService, baseType: .commandCenter, operatedBy: "NATO", isOverseas: true),
        ])

        return b
    }()
}
