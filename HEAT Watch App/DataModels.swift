import Foundation
import SwiftData
import MusicKit

@Model
class WorkoutSession {
    var startDate: Date
    var endDate: Date
    var duration: TimeInterval
    var totalDistance: Double
    var totalEnergyBurned: Double
    var averageHeartRate: Double
    @Relationship(deleteRule: .cascade) var playedTracks: [PlayedTrackData]

    init(startDate: Date, endDate: Date, duration: TimeInterval, totalDistance: Double, totalEnergyBurned: Double, averageHeartRate: Double, playedTracks: [PlayedTrackData]) {
        self.startDate = startDate
        self.endDate = endDate
        self.duration = duration
        self.totalDistance = totalDistance
        self.totalEnergyBurned = totalEnergyBurned
        self.averageHeartRate = averageHeartRate
        self.playedTracks = playedTracks
    }
}

@Model
class PlayedTrackData {
    var title: String
    var artist: String
    var timestamp: Date
    var heartRate: Double
    var distance: Double

    init(title: String, artist: String, timestamp: Date, heartRate: Double, distance: Double) {
        self.title = title
        self.artist = artist
        self.timestamp = timestamp
        self.heartRate = heartRate
        self.distance = distance
    }
}
