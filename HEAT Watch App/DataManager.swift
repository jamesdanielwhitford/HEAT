import Foundation
import HealthKit
import MusicKit

struct PlayedTrack: Identifiable {
    let id = UUID()
    let track: Song
    let timestamp: Date
    let heartRate: Double
    let distance: Double
}

struct WorkoutMetric {
    let heartRate: Double
    let distance: Double
}
