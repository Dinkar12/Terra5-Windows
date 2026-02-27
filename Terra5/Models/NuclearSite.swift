//
//  NuclearSite.swift
//  Terra5
//
//  Worldwide nuclear sites database
//

import Foundation
import MapKit

struct NuclearSite: Identifiable {
    let id: String
    let name: String
    let latitude: Double
    let longitude: Double
    let country: String
    let siteType: SiteType
    let status: Status
    let operatedBy: String
    let capacityMW: Int?
    let nuclearPower: String?

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    enum SiteType: String, CaseIterable {
        case powerPlant = "POWER_PLANT"
        case weaponsStorage = "WEAPONS_STORAGE"
        case icbmBase = "ICBM_BASE"
        case researchReactor = "RESEARCH_REACTOR"
        case enrichmentFacility = "ENRICHMENT_FACILITY"
        case reprocessingPlant = "REPROCESSING_PLANT"
        case wasteStorage = "WASTE_STORAGE"
        case testSite = "TEST_SITE"
        case submarineBase = "SUBMARINE_BASE"
        case commandControl = "COMMAND_CONTROL"

        var displayName: String {
            switch self {
            case .powerPlant: return "Power Plant"
            case .weaponsStorage: return "Weapons Storage"
            case .icbmBase: return "ICBM Base"
            case .researchReactor: return "Research Reactor"
            case .enrichmentFacility: return "Enrichment Facility"
            case .reprocessingPlant: return "Reprocessing Plant"
            case .wasteStorage: return "Waste Storage"
            case .testSite: return "Test Site"
            case .submarineBase: return "Submarine Base"
            case .commandControl: return "Command Control"
            }
        }

        var icon: String {
            switch self {
            case .powerPlant: return "bolt.fill"
            case .weaponsStorage: return "lock.shield.fill"
            case .icbmBase: return "scope"
            case .researchReactor: return "magnifyingglass.circle.fill"
            case .enrichmentFacility: return "gearshape.2.fill"
            case .reprocessingPlant: return "arrow.2.circlepath"
            case .wasteStorage: return "archivebox.fill"
            case .testSite: return "exclamationmark.triangle.fill"
            case .submarineBase: return "water.waves"
            case .commandControl: return "antenna.radiowaves.left.and.right"
            }
        }
    }

    enum Status: String, CaseIterable {
        case operational = "OPERATIONAL"
        case decommissioned = "DECOMMISSIONED"
        case underConstruction = "UNDER_CONSTRUCTION"
        case planned = "PLANNED"
        case shutdown = "SHUTDOWN"
        case historical = "HISTORICAL"

        var displayName: String {
            switch self {
            case .operational: return "Operational"
            case .decommissioned: return "Decommissioned"
            case .underConstruction: return "Under Construction"
            case .planned: return "Planned"
            case .shutdown: return "Shutdown"
            case .historical: return "Historical"
            }
        }

        var icon: String {
            switch self {
            case .operational: return "checkmark.circle.fill"
            case .decommissioned: return "xmark.circle.fill"
            case .underConstruction: return "hammer.fill"
            case .planned: return "paperclip.circle"
            case .shutdown: return "stop.circle.fill"
            case .historical: return "clock.fill"
            }
        }
    }
}

// MARK: - Worldwide Nuclear Sites Database
extension NuclearSite {

    static let sampleSites: [NuclearSite] = {
        var sites: [NuclearSite] = []

        // ═══════════════════════ US NUCLEAR POWER PLANTS (OPERATIONAL) ═══════════════════════

        sites.append(contentsOf: [
            NuclearSite(id: "US-PV-001", name: "Palo Verde", latitude: 33.388, longitude: -112.862, country: "United States", siteType: .powerPlant, status: .operational, operatedBy: "Arizona Public Service", capacityMW: 3937, nuclearPower: nil),
            NuclearSite(id: "US-STP-001", name: "South Texas Project", latitude: 28.795, longitude: -96.048, country: "United States", siteType: .powerPlant, status: .operational, operatedBy: "NRG Energy", capacityMW: 2710, nuclearPower: nil),
            NuclearSite(id: "US-VOG-001", name: "Vogtle", latitude: 33.142, longitude: -81.763, country: "United States", siteType: .powerPlant, status: .operational, operatedBy: "Southern Company", capacityMW: 4684, nuclearPower: nil),
            NuclearSite(id: "US-SEQ-001", name: "Sequoyah", latitude: 35.227, longitude: -85.088, country: "United States", siteType: .powerPlant, status: .operational, operatedBy: "Tennessee Valley Authority", capacityMW: 2329, nuclearPower: nil),
            NuclearSite(id: "US-WB-001", name: "Watts Bar", latitude: 35.603, longitude: -84.793, country: "United States", siteType: .powerPlant, status: .operational, operatedBy: "Tennessee Valley Authority", capacityMW: 2330, nuclearPower: nil),
            NuclearSite(id: "US-BF-001", name: "Browns Ferry", latitude: 34.704, longitude: -87.119, country: "United States", siteType: .powerPlant, status: .operational, operatedBy: "Tennessee Valley Authority", capacityMW: 3494, nuclearPower: nil),
            NuclearSite(id: "US-SUR-001", name: "Surry", latitude: 37.166, longitude: -76.698, country: "United States", siteType: .powerPlant, status: .operational, operatedBy: "Dominion Energy", capacityMW: 1676, nuclearPower: nil),
            NuclearSite(id: "US-NA-001", name: "North Anna", latitude: 38.060, longitude: -77.790, country: "United States", siteType: .powerPlant, status: .operational, operatedBy: "Dominion Energy", capacityMW: 1892, nuclearPower: nil),
            NuclearSite(id: "US-CC-001", name: "Calvert Cliffs", latitude: 38.432, longitude: -76.442, country: "United States", siteType: .powerPlant, status: .operational, operatedBy: "Constellation Energy", capacityMW: 1756, nuclearPower: nil),
            NuclearSite(id: "US-LIM-001", name: "Limerick", latitude: 40.224, longitude: -75.586, country: "United States", siteType: .powerPlant, status: .operational, operatedBy: "Exelon", capacityMW: 2242, nuclearPower: nil),
            NuclearSite(id: "US-PB-001", name: "Peach Bottom", latitude: 39.759, longitude: -76.269, country: "United States", siteType: .powerPlant, status: .operational, operatedBy: "Exelon", capacityMW: 2802, nuclearPower: nil),
            NuclearSite(id: "US-HC-001", name: "Hope Creek", latitude: 39.463, longitude: -75.534, country: "United States", siteType: .powerPlant, status: .operational, operatedBy: "PSEG", capacityMW: 1261, nuclearPower: nil),
            NuclearSite(id: "US-SAL-001", name: "Salem", latitude: 39.463, longitude: -75.534, country: "United States", siteType: .powerPlant, status: .operational, operatedBy: "PSEG", capacityMW: 2326, nuclearPower: nil),
            NuclearSite(id: "US-MIL-001", name: "Millstone", latitude: 41.309, longitude: -72.169, country: "United States", siteType: .powerPlant, status: .operational, operatedBy: "Dominion Energy", capacityMW: 2094, nuclearPower: nil),
            NuclearSite(id: "US-SBK-001", name: "Seabrook", latitude: 42.898, longitude: -70.849, country: "United States", siteType: .powerPlant, status: .operational, operatedBy: "NextEra Energy", capacityMW: 1248, nuclearPower: nil),
            NuclearSite(id: "US-BYR-001", name: "Byron", latitude: 42.075, longitude: -89.282, country: "United States", siteType: .powerPlant, status: .operational, operatedBy: "Constellation Energy", capacityMW: 2347, nuclearPower: nil),
            NuclearSite(id: "US-BRW-001", name: "Braidwood", latitude: 41.240, longitude: -88.230, country: "United States", siteType: .powerPlant, status: .operational, operatedBy: "Constellation Energy", capacityMW: 2389, nuclearPower: nil),
            NuclearSite(id: "US-DRE-001", name: "Dresden", latitude: 41.390, longitude: -88.271, country: "United States", siteType: .powerPlant, status: .operational, operatedBy: "Exelon", capacityMW: 1845, nuclearPower: nil),
            NuclearSite(id: "US-LSL-001", name: "LaSalle", latitude: 41.244, longitude: -88.670, country: "United States", siteType: .powerPlant, status: .operational, operatedBy: "Exelon", capacityMW: 2320, nuclearPower: nil),
            NuclearSite(id: "US-GG-001", name: "Grand Gulf", latitude: 32.008, longitude: -91.048, country: "United States", siteType: .powerPlant, status: .operational, operatedBy: "Entergy", capacityMW: 1443, nuclearPower: nil),
            NuclearSite(id: "US-RB-001", name: "River Bend", latitude: 30.757, longitude: -91.332, country: "United States", siteType: .powerPlant, status: .operational, operatedBy: "Entergy", capacityMW: 974, nuclearPower: nil),
            NuclearSite(id: "US-WF-001", name: "Waterford", latitude: 29.995, longitude: -90.472, country: "United States", siteType: .powerPlant, status: .operational, operatedBy: "Entergy", capacityMW: 1168, nuclearPower: nil),
            NuclearSite(id: "US-WC-001", name: "Wolf Creek", latitude: 38.239, longitude: -95.689, country: "United States", siteType: .powerPlant, status: .operational, operatedBy: "Westar Energy", capacityMW: 1200, nuclearPower: nil),
            NuclearSite(id: "US-CAL-001", name: "Callaway", latitude: 38.762, longitude: -91.781, country: "United States", siteType: .powerPlant, status: .operational, operatedBy: "Ameren", capacityMW: 1236, nuclearPower: nil),
            NuclearSite(id: "US-COOP-001", name: "Cooper", latitude: 40.362, longitude: -95.641, country: "United States", siteType: .powerPlant, status: .operational, operatedBy: "OPPD", capacityMW: 801, nuclearPower: nil),
            NuclearSite(id: "US-CGS-001", name: "Columbia Generating Station", latitude: 46.471, longitude: -119.333, country: "United States", siteType: .powerPlant, status: .operational, operatedBy: "Energy Northwest", capacityMW: 1190, nuclearPower: nil),
            NuclearSite(id: "US-DC-001", name: "Diablo Canyon", latitude: 35.211, longitude: -120.854, country: "United States", siteType: .powerPlant, status: .operational, operatedBy: "PG&E", capacityMW: 2256, nuclearPower: nil),
            NuclearSite(id: "US-CP-001", name: "Comanche Peak", latitude: 32.299, longitude: -97.786, country: "United States", siteType: .powerPlant, status: .operational, operatedBy: "Luminant", capacityMW: 2430, nuclearPower: nil),
            NuclearSite(id: "US-DCK-001", name: "Donald C Cook", latitude: 41.976, longitude: -86.566, country: "United States", siteType: .powerPlant, status: .operational, operatedBy: "AEC", capacityMW: 2194, nuclearPower: nil),
            NuclearSite(id: "US-FER-001", name: "Fermi 2", latitude: 41.963, longitude: -83.258, country: "United States", siteType: .powerPlant, status: .operational, operatedBy: "DTE Energy", capacityMW: 1198, nuclearPower: nil),
            NuclearSite(id: "US-DB-001", name: "Davis-Besse", latitude: 41.597, longitude: -83.086, country: "United States", siteType: .powerPlant, status: .operational, operatedBy: "First Energy", capacityMW: 908, nuclearPower: nil),
            NuclearSite(id: "US-PB-002", name: "Point Beach", latitude: 44.281, longitude: -87.536, country: "United States", siteType: .powerPlant, status: .operational, operatedBy: "NextEra Energy", capacityMW: 1200, nuclearPower: nil),
            NuclearSite(id: "US-PI-001", name: "Prairie Island", latitude: 44.622, longitude: -92.633, country: "United States", siteType: .powerPlant, status: .operational, operatedBy: "Xcel Energy", capacityMW: 1100, nuclearPower: nil),
            NuclearSite(id: "US-MON-001", name: "Monticello", latitude: 45.333, longitude: -93.848, country: "United States", siteType: .powerPlant, status: .operational, operatedBy: "Xcel Energy", capacityMW: 671, nuclearPower: nil),
            NuclearSite(id: "US-TP-001", name: "Turkey Point", latitude: 25.435, longitude: -80.331, country: "United States", siteType: .powerPlant, status: .operational, operatedBy: "FPL", capacityMW: 1760, nuclearPower: nil),
            NuclearSite(id: "US-SL-001", name: "St. Lucie", latitude: 27.349, longitude: -80.246, country: "United States", siteType: .powerPlant, status: .operational, operatedBy: "NextEra Energy", capacityMW: 1714, nuclearPower: nil),
            NuclearSite(id: "US-BRN-001", name: "Brunswick", latitude: 33.959, longitude: -78.010, country: "United States", siteType: .powerPlant, status: .operational, operatedBy: "Duke Energy", capacityMW: 1870, nuclearPower: nil),
            NuclearSite(id: "US-MCG-001", name: "McGuire", latitude: 35.432, longitude: -80.949, country: "United States", siteType: .powerPlant, status: .operational, operatedBy: "Duke Energy", capacityMW: 2258, nuclearPower: nil),
            NuclearSite(id: "US-CAT-001", name: "Catawba", latitude: 35.053, longitude: -81.071, country: "United States", siteType: .powerPlant, status: .operational, operatedBy: "Duke Energy", capacityMW: 2258, nuclearPower: nil),
            NuclearSite(id: "US-SUM-001", name: "Summer", latitude: 34.296, longitude: -81.321, country: "United States", siteType: .powerPlant, status: .operational, operatedBy: "SCEG", capacityMW: 966, nuclearPower: nil),
            NuclearSite(id: "US-OCO-001", name: "Oconee", latitude: 34.794, longitude: -82.899, country: "United States", siteType: .powerPlant, status: .operational, operatedBy: "Duke Energy", capacityMW: 2631, nuclearPower: nil),
            NuclearSite(id: "US-HAT-001", name: "Hatch", latitude: 31.934, longitude: -82.344, country: "United States", siteType: .powerPlant, status: .operational, operatedBy: "Southern Company", capacityMW: 1848, nuclearPower: nil),
            NuclearSite(id: "US-JMF-001", name: "Joseph M Farley", latitude: 31.223, longitude: -85.104, country: "United States", siteType: .powerPlant, status: .operational, operatedBy: "Southern Company", capacityMW: 1776, nuclearPower: nil),
            NuclearSite(id: "US-ROB-001", name: "Robinson", latitude: 34.402, longitude: -80.159, country: "United States", siteType: .powerPlant, status: .operational, operatedBy: "SCEG", capacityMW: 759, nuclearPower: nil),
            NuclearSite(id: "US-HAR-001", name: "Harris", latitude: 35.632, longitude: -78.956, country: "United States", siteType: .powerPlant, status: .operational, operatedBy: "Duke Energy", capacityMW: 983, nuclearPower: nil),
            NuclearSite(id: "US-BV-001", name: "Beaver Valley", latitude: 40.622, longitude: -80.433, country: "United States", siteType: .powerPlant, status: .operational, operatedBy: "FirstEnergy", capacityMW: 1835, nuclearPower: nil),
            NuclearSite(id: "US-SUS-001", name: "Susquehanna", latitude: 41.096, longitude: -76.146, country: "United States", siteType: .powerPlant, status: .operational, operatedBy: "Exelon", capacityMW: 2596, nuclearPower: nil),
            NuclearSite(id: "US-NMP-001", name: "Nine Mile Point", latitude: 43.522, longitude: -76.410, country: "United States", siteType: .powerPlant, status: .operational, operatedBy: "Constellation Energy", capacityMW: 1851, nuclearPower: nil),
            NuclearSite(id: "US-FPA-001", name: "FitzPatrick", latitude: 43.524, longitude: -76.399, country: "United States", siteType: .powerPlant, status: .operational, operatedBy: "Constellation Energy", capacityMW: 852, nuclearPower: nil),
            NuclearSite(id: "US-IP-001", name: "Indian Point", latitude: 41.270, longitude: -73.953, country: "United States", siteType: .powerPlant, status: .shutdown, operatedBy: "Constellation Energy", capacityMW: 0, nuclearPower: nil),
        ])

        // ═══════════════════════ MAJOR INTERNATIONAL NUCLEAR POWER PLANTS ═══════════════════════

        sites.append(contentsOf: [
            // Canada
            NuclearSite(id: "CA-BRU-001", name: "Bruce Power", latitude: 44.324, longitude: -81.599, country: "Canada", siteType: .powerPlant, status: .operational, operatedBy: "Bruce Power", capacityMW: 6384, nuclearPower: nil),
            NuclearSite(id: "CA-DAR-001", name: "Darlington", latitude: 43.872, longitude: -78.718, country: "Canada", siteType: .powerPlant, status: .operational, operatedBy: "Ontario Power Generation", capacityMW: 3524, nuclearPower: nil),

            // United Kingdom
            NuclearSite(id: "UK-HPC-001", name: "Hinkley Point C", latitude: 51.209, longitude: -3.130, country: "United Kingdom", siteType: .powerPlant, status: .underConstruction, operatedBy: "EDF", capacityMW: 3260, nuclearPower: nil),
            NuclearSite(id: "UK-SIZ-001", name: "Sizewell B", latitude: 52.215, longitude: 1.619, country: "United Kingdom", siteType: .powerPlant, status: .operational, operatedBy: "EDF", capacityMW: 1198, nuclearPower: nil),

            // France
            NuclearSite(id: "FR-GRA-001", name: "Gravelines", latitude: 51.015, longitude: 2.104, country: "France", siteType: .powerPlant, status: .operational, operatedBy: "EDF", capacityMW: 5460, nuclearPower: nil),
            NuclearSite(id: "FR-PAL-001", name: "Paluel", latitude: 49.860, longitude: 0.633, country: "France", siteType: .powerPlant, status: .operational, operatedBy: "EDF", capacityMW: 5320, nuclearPower: nil),
            NuclearSite(id: "FR-CAT-001", name: "Cattenom", latitude: 49.406, longitude: 6.217, country: "France", siteType: .powerPlant, status: .operational, operatedBy: "EDF", capacityMW: 5448, nuclearPower: nil),
            NuclearSite(id: "FR-FLA-001", name: "Flamanville", latitude: 49.537, longitude: -1.881, country: "France", siteType: .powerPlant, status: .underConstruction, operatedBy: "EDF", capacityMW: 2660, nuclearPower: nil),
            NuclearSite(id: "FR-TRI-001", name: "Tricastin", latitude: 44.333, longitude: 4.727, country: "France", siteType: .powerPlant, status: .operational, operatedBy: "EDF", capacityMW: 3660, nuclearPower: nil),

            // Japan
            NuclearSite(id: "JP-KK-001", name: "Kashiwazaki-Kariwa", latitude: 37.426, longitude: 138.597, country: "Japan", siteType: .powerPlant, status: .operational, operatedBy: "Tokyo Electric Power", capacityMW: 8212, nuclearPower: nil),
            NuclearSite(id: "JP-FKD-001", name: "Fukushima Daiichi", latitude: 37.421, longitude: 141.033, country: "Japan", siteType: .powerPlant, status: .decommissioned, operatedBy: "Tokyo Electric Power", capacityMW: 0, nuclearPower: nil),

            // Ukraine
            NuclearSite(id: "UA-ZAP-001", name: "Zaporizhzhia", latitude: 47.507, longitude: 34.585, country: "Ukraine", siteType: .powerPlant, status: .shutdown, operatedBy: "Energoatom", capacityMW: 5700, nuclearPower: nil),

            // Russia
            NuclearSite(id: "RU-KOL-001", name: "Kola", latitude: 67.463, longitude: 32.474, country: "Russia", siteType: .powerPlant, status: .operational, operatedBy: "Rosenergoatom", capacityMW: 1760, nuclearPower: nil),
            NuclearSite(id: "RU-LEN-001", name: "Leningrad (Sosnovy Bor)", latitude: 59.834, longitude: 29.034, country: "Russia", siteType: .powerPlant, status: .operational, operatedBy: "Rosenergoatom", capacityMW: 4300, nuclearPower: nil),
            NuclearSite(id: "RU-NVZ-001", name: "Novovoronezh", latitude: 51.274, longitude: 39.214, country: "Russia", siteType: .powerPlant, status: .operational, operatedBy: "Rosenergoatom", capacityMW: 2475, nuclearPower: nil),
            NuclearSite(id: "RU-KUR-001", name: "Kursk", latitude: 51.678, longitude: 35.607, country: "Russia", siteType: .powerPlant, status: .operational, operatedBy: "Rosenergoatom", capacityMW: 4000, nuclearPower: nil),
            NuclearSite(id: "RU-BAL-001", name: "Balakovo", latitude: 52.087, longitude: 47.956, country: "Russia", siteType: .powerPlant, status: .operational, operatedBy: "Rosenergoatom", capacityMW: 4000, nuclearPower: nil),

            // China
            NuclearSite(id: "CN-TAI-001", name: "Taishan", latitude: 21.916, longitude: 112.982, country: "China", siteType: .powerPlant, status: .operational, operatedBy: "China National Nuclear", capacityMW: 3460, nuclearPower: nil),
            NuclearSite(id: "CN-YAJ-001", name: "Yangjiang", latitude: 21.714, longitude: 112.256, country: "China", siteType: .powerPlant, status: .operational, operatedBy: "China National Nuclear", capacityMW: 6000, nuclearPower: nil),
            NuclearSite(id: "CN-HYH-001", name: "Hongyanhe", latitude: 39.793, longitude: 121.476, country: "China", siteType: .powerPlant, status: .operational, operatedBy: "China National Nuclear", capacityMW: 6710, nuclearPower: nil),
            NuclearSite(id: "CN-TIW-001", name: "Tianwan", latitude: 34.687, longitude: 119.459, country: "China", siteType: .powerPlant, status: .operational, operatedBy: "China National Nuclear", capacityMW: 6260, nuclearPower: nil),
            NuclearSite(id: "CN-DAY-001", name: "Daya Bay", latitude: 22.597, longitude: 114.547, country: "China", siteType: .powerPlant, status: .operational, operatedBy: "China National Nuclear", capacityMW: 1968, nuclearPower: nil),
            NuclearSite(id: "CN-LIA-001", name: "Ling Ao", latitude: 22.601, longitude: 114.555, country: "China", siteType: .powerPlant, status: .operational, operatedBy: "China National Nuclear", capacityMW: 3916, nuclearPower: nil),

            // UAE
            NuclearSite(id: "AE-BAR-001", name: "Barakah", latitude: 23.958, longitude: 52.265, country: "United Arab Emirates", siteType: .powerPlant, status: .operational, operatedBy: "ENEC", capacityMW: 5600, nuclearPower: nil),

            // India
            NuclearSite(id: "IN-KUD-001", name: "Kudankulam", latitude: 8.171, longitude: 77.706, country: "India", siteType: .powerPlant, status: .operational, operatedBy: "NPCIL", capacityMW: 2000, nuclearPower: nil),
            NuclearSite(id: "IN-TAR-001", name: "Tarapur", latitude: 19.842, longitude: 72.655, country: "India", siteType: .powerPlant, status: .operational, operatedBy: "NPCIL", capacityMW: 1400, nuclearPower: nil),

            // South Africa
            NuclearSite(id: "ZA-KOE-001", name: "Koeberg", latitude: -33.677, longitude: 18.432, country: "South Africa", siteType: .powerPlant, status: .operational, operatedBy: "Eskom", capacityMW: 1860, nuclearPower: nil),

            // Finland
            NuclearSite(id: "FI-OLK-001", name: "Olkiluoto", latitude: 61.235, longitude: 21.445, country: "Finland", siteType: .powerPlant, status: .operational, operatedBy: "TVO", capacityMW: 4290, nuclearPower: nil),

            // Sweden
            NuclearSite(id: "SE-RIN-001", name: "Ringhals", latitude: 57.264, longitude: 12.113, country: "Sweden", siteType: .powerPlant, status: .operational, operatedBy: "Vattenfall", capacityMW: 3956, nuclearPower: nil),
            NuclearSite(id: "SE-FOR-001", name: "Forsmark", latitude: 60.407, longitude: 18.169, country: "Sweden", siteType: .powerPlant, status: .operational, operatedBy: "Vattenfall", capacityMW: 3210, nuclearPower: nil),

            // Belgium
            NuclearSite(id: "BE-DOE-001", name: "Doel", latitude: 51.326, longitude: 4.259, country: "Belgium", siteType: .powerPlant, status: .operational, operatedBy: "Electrabel", capacityMW: 2911, nuclearPower: nil),
            NuclearSite(id: "BE-TIH-001", name: "Tihange", latitude: 50.534, longitude: 5.272, country: "Belgium", siteType: .powerPlant, status: .operational, operatedBy: "Electrabel", capacityMW: 3016, nuclearPower: nil),

            // Netherlands
            NuclearSite(id: "NL-BOR-001", name: "Borssele", latitude: 51.428, longitude: 3.717, country: "Netherlands", siteType: .powerPlant, status: .operational, operatedBy: "EPZ", capacityMW: 485, nuclearPower: nil),

            // Czech Republic
            NuclearSite(id: "CZ-DUK-001", name: "Dukovany", latitude: 51.086, longitude: 16.149, country: "Czech Republic", siteType: .powerPlant, status: .operational, operatedBy: "CEZ", capacityMW: 2040, nuclearPower: nil),
            NuclearSite(id: "CZ-TEM-001", name: "Temelin", latitude: 49.180, longitude: 14.376, country: "Czech Republic", siteType: .powerPlant, status: .operational, operatedBy: "CEZ", capacityMW: 2116, nuclearPower: nil),

            // Hungary
            NuclearSite(id: "HU-PAK-001", name: "Paks", latitude: 46.572, longitude: 18.854, country: "Hungary", siteType: .powerPlant, status: .operational, operatedBy: "MVM", capacityMW: 2000, nuclearPower: nil),

            // Romania
            NuclearSite(id: "RO-CER-001", name: "Cernavoda", latitude: 44.320, longitude: 28.053, country: "Romania", siteType: .powerPlant, status: .operational, operatedBy: "Nuclearelectrica", capacityMW: 1413, nuclearPower: nil),

            // Argentina
            NuclearSite(id: "AR-ATU-001", name: "Atucha", latitude: -34.062, longitude: -59.210, country: "Argentina", siteType: .powerPlant, status: .operational, operatedBy: "NAC", capacityMW: 1012, nuclearPower: nil),

            // Brazil
            NuclearSite(id: "BR-ANG-001", name: "Angra", latitude: -23.007, longitude: -44.457, country: "Brazil", siteType: .powerPlant, status: .operational, operatedBy: "Eletrobras", capacityMW: 1884, nuclearPower: nil),

            // Mexico
            NuclearSite(id: "MX-LV-001", name: "Laguna Verde", latitude: 19.717, longitude: -96.405, country: "Mexico", siteType: .powerPlant, status: .operational, operatedBy: "CFE", capacityMW: 1552, nuclearPower: nil),
        ])

        // ═══════════════════════ US NUCLEAR WEAPONS SITES ═══════════════════════

        sites.append(contentsOf: [
            NuclearSite(id: "US-PAN-001", name: "Pantex Plant", latitude: 35.317, longitude: -101.946, country: "United States", siteType: .weaponsStorage, status: .operational, operatedBy: "NNSA", capacityMW: nil, nuclearPower: "United States"),
            NuclearSite(id: "US-LA-001", name: "Los Alamos National Lab", latitude: 35.845, longitude: -106.287, country: "United States", siteType: .weaponsStorage, status: .operational, operatedBy: "NNSA", capacityMW: nil, nuclearPower: "United States"),
            NuclearSite(id: "US-LL-001", name: "Lawrence Livermore National Lab", latitude: 37.688, longitude: -121.706, country: "United States", siteType: .weaponsStorage, status: .operational, operatedBy: "NNSA", capacityMW: nil, nuclearPower: "United States"),
            NuclearSite(id: "US-SNL-001", name: "Sandia National Lab", latitude: 35.058, longitude: -106.539, country: "United States", siteType: .weaponsStorage, status: .operational, operatedBy: "NNSA", capacityMW: nil, nuclearPower: "United States"),
            NuclearSite(id: "US-Y12-001", name: "Y-12 National Security Complex", latitude: 35.985, longitude: -84.256, country: "United States", siteType: .enrichmentFacility, status: .operational, operatedBy: "NNSA", capacityMW: nil, nuclearPower: "United States"),
            NuclearSite(id: "US-SRS-001", name: "Savannah River Site", latitude: 33.340, longitude: -81.740, country: "United States", siteType: .weaponsStorage, status: .operational, operatedBy: "NNSA", capacityMW: nil, nuclearPower: "United States"),
            NuclearSite(id: "US-KCNSC-001", name: "Kansas City National Security Campus", latitude: 38.820, longitude: -94.530, country: "United States", siteType: .weaponsStorage, status: .operational, operatedBy: "NNSA", capacityMW: nil, nuclearPower: "United States"),
            NuclearSite(id: "US-NTS-001", name: "Nevada National Security Site", latitude: 37.000, longitude: -116.050, country: "United States", siteType: .testSite, status: .historical, operatedBy: "NNSA", capacityMW: nil, nuclearPower: "United States"),
            NuclearSite(id: "US-HAN-001", name: "Hanford Site", latitude: 46.548, longitude: -119.489, country: "United States", siteType: .weaponsStorage, status: .shutdown, operatedBy: "NNSA", capacityMW: nil, nuclearPower: "United States"),
            NuclearSite(id: "US-INL-001", name: "Idaho National Lab", latitude: 43.515, longitude: -112.951, country: "United States", siteType: .researchReactor, status: .operational, operatedBy: "DOE", capacityMW: nil, nuclearPower: "United States"),
            NuclearSite(id: "US-ORNL-001", name: "Oak Ridge National Lab", latitude: 35.931, longitude: -84.310, country: "United States", siteType: .researchReactor, status: .operational, operatedBy: "DOE", capacityMW: nil, nuclearPower: "United States"),
        ])

        // ═══════════════════════ US NUCLEAR WARHEAD STORAGE ═══════════════════════

        sites.append(contentsOf: [
            NuclearSite(id: "US-KRT-001", name: "Kirtland AFB Underground Weapons Storage", latitude: 35.040, longitude: -106.540, country: "United States", siteType: .weaponsStorage, status: .operational, operatedBy: "AFNWC", capacityMW: nil, nuclearPower: "United States"),
            NuclearSite(id: "US-BAN-001", name: "Bangor (Naval Base Kitsap)", latitude: 47.723, longitude: -122.714, country: "United States", siteType: .submarineBase, status: .operational, operatedBy: "U.S. Navy", capacityMW: nil, nuclearPower: "United States"),
            NuclearSite(id: "US-KGB-001", name: "Kings Bay", latitude: 30.796, longitude: -81.514, country: "United States", siteType: .submarineBase, status: .operational, operatedBy: "U.S. Navy", capacityMW: nil, nuclearPower: "United States"),
            NuclearSite(id: "US-NEL-001", name: "Nellis AFB/Tonopah Test Range", latitude: 38.060, longitude: -116.780, country: "United States", siteType: .weaponsStorage, status: .operational, operatedBy: "AFNWC", capacityMW: nil, nuclearPower: "United States"),
            NuclearSite(id: "US-WHT-001", name: "Whiteman AFB", latitude: 38.727, longitude: -93.548, country: "United States", siteType: .weaponsStorage, status: .operational, operatedBy: "AFNWC", capacityMW: nil, nuclearPower: "United States"),
            NuclearSite(id: "US-BAR-001", name: "Barksdale AFB", latitude: 32.501, longitude: -93.663, country: "United States", siteType: .weaponsStorage, status: .operational, operatedBy: "AFNWC", capacityMW: nil, nuclearPower: "United States"),
            NuclearSite(id: "US-MIN-001", name: "Minot AFB", latitude: 48.416, longitude: -101.358, country: "United States", siteType: .weaponsStorage, status: .operational, operatedBy: "AFNWC", capacityMW: nil, nuclearPower: "United States"),
        ])

        // ═══════════════════════ NATO NUCLEAR SHARING (B61 BOMBS) ═══════════════════════

        sites.append(contentsOf: [
            NuclearSite(id: "BE-KB-001", name: "Kleine Brogel AB", latitude: 51.168, longitude: 5.470, country: "Belgium", siteType: .weaponsStorage, status: .operational, operatedBy: "Royal Belgian Air Force", capacityMW: nil, nuclearPower: "Belgium"),
            NuclearSite(id: "DE-BC-001", name: "Büchel AB", latitude: 50.174, longitude: 7.063, country: "Germany", siteType: .weaponsStorage, status: .operational, operatedBy: "German Air Force", capacityMW: nil, nuclearPower: "Germany"),
            NuclearSite(id: "NL-VOL-001", name: "Volkel AB", latitude: 51.657, longitude: 5.652, country: "Netherlands", siteType: .weaponsStorage, status: .operational, operatedBy: "Royal Netherlands Air Force", capacityMW: nil, nuclearPower: "Netherlands"),
            NuclearSite(id: "IT-AVN-001", name: "Aviano AB", latitude: 46.032, longitude: 12.597, country: "Italy", siteType: .weaponsStorage, status: .operational, operatedBy: "Italian Air Force", capacityMW: nil, nuclearPower: "Italy"),
            NuclearSite(id: "IT-GHD-001", name: "Ghedi AB", latitude: 45.432, longitude: 10.277, country: "Italy", siteType: .weaponsStorage, status: .operational, operatedBy: "Italian Air Force", capacityMW: nil, nuclearPower: "Italy"),
            NuclearSite(id: "TR-INC-001", name: "Incirlik AB", latitude: 37.002, longitude: 35.426, country: "Turkey", siteType: .weaponsStorage, status: .operational, operatedBy: "Turkish Air Force", capacityMW: nil, nuclearPower: "Turkey"),
        ])

        // ═══════════════════════ RUSSIAN NUCLEAR WEAPONS SITES ═══════════════════════

        sites.append(contentsOf: [
            NuclearSite(id: "RU-SAR-001", name: "Sarov (Arzamas-16)", latitude: 54.930, longitude: 43.320, country: "Russia", siteType: .weaponsStorage, status: .operational, operatedBy: "Rosatom", capacityMW: nil, nuclearPower: "Russia"),
            NuclearSite(id: "RU-SNZ-001", name: "Snezhinsk (Chelyabinsk-70)", latitude: 56.085, longitude: 60.731, country: "Russia", siteType: .weaponsStorage, status: .operational, operatedBy: "Rosatom", capacityMW: nil, nuclearPower: "Russia"),
            NuclearSite(id: "RU-MAY-001", name: "Mayak (Chelyabinsk-65)", latitude: 55.713, longitude: 60.808, country: "Russia", siteType: .reprocessingPlant, status: .operational, operatedBy: "Rosatom", capacityMW: nil, nuclearPower: "Russia"),
            NuclearSite(id: "RU-SEV-001", name: "Seversk (Tomsk-7)", latitude: 56.607, longitude: 84.859, country: "Russia", siteType: .enrichmentFacility, status: .operational, operatedBy: "Rosatom", capacityMW: nil, nuclearPower: "Russia"),
            NuclearSite(id: "RU-ZEL-001", name: "Zheleznogorsk (Krasnoyarsk-26)", latitude: 56.248, longitude: 93.524, country: "Russia", siteType: .reprocessingPlant, status: .operational, operatedBy: "Rosatom", capacityMW: nil, nuclearPower: "Russia"),
            NuclearSite(id: "RU-NZ-001", name: "Novaya Zemlya Nuclear Test Site", latitude: 73.350, longitude: 54.950, country: "Russia", siteType: .testSite, status: .historical, operatedBy: "Rosatom", capacityMW: nil, nuclearPower: "Russia"),
            NuclearSite(id: "RU-KOZ-001", name: "Kozelsk ICBM base", latitude: 54.033, longitude: 35.783, country: "Russia", siteType: .icbmBase, status: .operational, operatedBy: "Russian Armed Forces", capacityMW: nil, nuclearPower: "Russia"),
        ])

        // ═══════════════════════ CHINESE NUCLEAR SITES ═══════════════════════

        sites.append(contentsOf: [
            NuclearSite(id: "CN-LOP-001", name: "Lop Nur Nuclear Test Site", latitude: 41.547, longitude: 88.353, country: "China", siteType: .testSite, status: .historical, operatedBy: "CAEP", capacityMW: nil, nuclearPower: "China"),
            NuclearSite(id: "CN-MIA-001", name: "Mianyang (CAEP)", latitude: 31.468, longitude: 104.742, country: "China", siteType: .weaponsStorage, status: .operational, operatedBy: "CAEP", capacityMW: nil, nuclearPower: "China"),
            NuclearSite(id: "CN-LAN-001", name: "Lanzhou Gaseous Diffusion Plant", latitude: 36.058, longitude: 103.810, country: "China", siteType: .enrichmentFacility, status: .operational, operatedBy: "CNNC", capacityMW: nil, nuclearPower: "China"),
            NuclearSite(id: "CN-JIU-001", name: "Jiuquan Atomic Energy Complex", latitude: 39.743, longitude: 98.514, country: "China", siteType: .weaponsStorage, status: .operational, operatedBy: "CNNC", capacityMW: nil, nuclearPower: "China"),
            NuclearSite(id: "CN-YUM-001", name: "Yumen ICBM base area", latitude: 39.800, longitude: 97.500, country: "China", siteType: .icbmBase, status: .operational, operatedBy: "PLA", capacityMW: nil, nuclearPower: "China"),
        ])

        // ═══════════════════════ UK NUCLEAR ═══════════════════════

        sites.append(contentsOf: [
            NuclearSite(id: "UK-AWA-001", name: "AWE Aldermaston", latitude: 51.356, longitude: -1.150, country: "United Kingdom", siteType: .weaponsStorage, status: .operational, operatedBy: "AWE", capacityMW: nil, nuclearPower: "United Kingdom"),
            NuclearSite(id: "UK-AWB-001", name: "AWE Burghfield", latitude: 51.406, longitude: -1.026, country: "United Kingdom", siteType: .weaponsStorage, status: .operational, operatedBy: "AWE", capacityMW: nil, nuclearPower: "United Kingdom"),
            NuclearSite(id: "UK-SEL-001", name: "Sellafield", latitude: 54.421, longitude: -3.492, country: "United Kingdom", siteType: .reprocessingPlant, status: .operational, operatedBy: "Sellafield Ltd", capacityMW: nil, nuclearPower: "United Kingdom"),
            NuclearSite(id: "UK-FAS-001", name: "HMNB Clyde (Faslane)", latitude: 56.070, longitude: -4.817, country: "United Kingdom", siteType: .submarineBase, status: .operational, operatedBy: "Royal Navy", capacityMW: nil, nuclearPower: "United Kingdom"),
            NuclearSite(id: "UK-CUL-001", name: "RNAD Coulport", latitude: 56.055, longitude: -4.882, country: "United Kingdom", siteType: .weaponsStorage, status: .operational, operatedBy: "Royal Navy", capacityMW: nil, nuclearPower: "United Kingdom"),
        ])

        // ═══════════════════════ FRENCH NUCLEAR ═══════════════════════

        sites.append(contentsOf: [
            NuclearSite(id: "FR-VAL-001", name: "CEA Valduc", latitude: 47.480, longitude: 4.843, country: "France", siteType: .weaponsStorage, status: .operational, operatedBy: "CEA", capacityMW: nil, nuclearPower: "France"),
            NuclearSite(id: "FR-ILE-001", name: "Île Longue", latitude: 48.293, longitude: -4.508, country: "France", siteType: .submarineBase, status: .operational, operatedBy: "French Navy", capacityMW: nil, nuclearPower: "France"),
            NuclearSite(id: "FR-LH-001", name: "La Hague", latitude: 49.678, longitude: -1.881, country: "France", siteType: .reprocessingPlant, status: .operational, operatedBy: "Orano", capacityMW: nil, nuclearPower: "France"),
            NuclearSite(id: "FR-PIE-001", name: "Pierrelatte (Tricastin)", latitude: 44.333, longitude: 4.727, country: "France", siteType: .enrichmentFacility, status: .operational, operatedBy: "Orano", capacityMW: nil, nuclearPower: "France"),
        ])

        // ═══════════════════════ INDIA/PAKISTAN/ISRAEL/NORTH KOREA ═══════════════════════

        sites.append(contentsOf: [
            NuclearSite(id: "IN-BARC-001", name: "Bhabha Atomic Research Centre", latitude: 19.009, longitude: 72.925, country: "India", siteType: .researchReactor, status: .operational, operatedBy: "BARC", capacityMW: nil, nuclearPower: "India"),
            NuclearSite(id: "IN-TRO-001", name: "Trombay", latitude: 19.005, longitude: 72.930, country: "India", siteType: .weaponsStorage, status: .operational, operatedBy: "BARC", capacityMW: nil, nuclearPower: "India"),
            NuclearSite(id: "PK-KRL-001", name: "Kahuta", latitude: 33.592, longitude: 73.386, country: "Pakistan", siteType: .enrichmentFacility, status: .operational, operatedBy: "KRL", capacityMW: nil, nuclearPower: "Pakistan"),
            NuclearSite(id: "IL-DIM-001", name: "Dimona Nuclear Research Center", latitude: 31.005, longitude: 35.145, country: "Israel", siteType: .weaponsStorage, status: .operational, operatedBy: "IAEC", capacityMW: nil, nuclearPower: "Israel"),
            NuclearSite(id: "NK-YON-001", name: "Yongbyon Nuclear Center", latitude: 39.796, longitude: 125.756, country: "North Korea", siteType: .researchReactor, status: .shutdown, operatedBy: "North Korean Government", capacityMW: nil, nuclearPower: "North Korea"),
        ])

        // ═══════════════════════ NUCLEAR TEST SITES ═══════════════════════

        sites.append(contentsOf: [
            NuclearSite(id: "US-TRI-001", name: "Trinity Site", latitude: 33.677, longitude: -106.475, country: "United States", siteType: .testSite, status: .historical, operatedBy: "NNSA", capacityMW: nil, nuclearPower: "United States"),
            NuclearSite(id: "US-BIK-001", name: "Bikini Atoll", latitude: 11.583, longitude: 165.383, country: "Marshall Islands", siteType: .testSite, status: .historical, operatedBy: "Historic", capacityMW: nil, nuclearPower: "United States"),
            NuclearSite(id: "US-ENE-001", name: "Enewetak Atoll", latitude: 11.500, longitude: 162.350, country: "Marshall Islands", siteType: .testSite, status: .historical, operatedBy: "Historic", capacityMW: nil, nuclearPower: "United States"),
            NuclearSite(id: "FR-MOR-001", name: "Moruroa Atoll", latitude: -21.833, longitude: -138.933, country: "French Polynesia", siteType: .testSite, status: .historical, operatedBy: "CEA", capacityMW: nil, nuclearPower: "France"),
            NuclearSite(id: "AU-MAR-001", name: "Maralinga", latitude: -30.166, longitude: 131.600, country: "Australia", siteType: .testSite, status: .historical, operatedBy: "Historic", capacityMW: nil, nuclearPower: "United Kingdom"),
            NuclearSite(id: "DZ-REG-001", name: "Reggane", latitude: 26.317, longitude: 0.067, country: "Algeria", siteType: .testSite, status: .historical, operatedBy: "CEA", capacityMW: nil, nuclearPower: "France"),
            NuclearSite(id: "IN-POK-001", name: "Pokhran", latitude: 27.100, longitude: 71.750, country: "India", siteType: .testSite, status: .historical, operatedBy: "DAE", capacityMW: nil, nuclearPower: "India"),
            NuclearSite(id: "PK-RAS-001", name: "Ras Koh Hills", latitude: 28.830, longitude: 64.940, country: "Pakistan", siteType: .testSite, status: .historical, operatedBy: "PAEC", capacityMW: nil, nuclearPower: "Pakistan"),
            NuclearSite(id: "NK-PUN-001", name: "Punggye-ri", latitude: 41.277, longitude: 129.087, country: "North Korea", siteType: .testSite, status: .historical, operatedBy: "North Korean Government", capacityMW: nil, nuclearPower: "North Korea"),
            NuclearSite(id: "KZ-SEM-001", name: "Semipalatinsk Test Site", latitude: 50.440, longitude: 77.760, country: "Kazakhstan", siteType: .testSite, status: .historical, operatedBy: "Historic", capacityMW: nil, nuclearPower: "Soviet Union"),
        ])

        return sites
    }()
}
