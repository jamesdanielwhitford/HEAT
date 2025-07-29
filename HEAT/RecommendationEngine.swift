import Foundation

class RecommendationEngine {
    func analyze(session: WorkoutSession) -> [PlayedTrackData: Double] {
        var scores: [PlayedTrackData: Double] = [:]

        for track in session.playedTracks {
            scores[track] = track.heartRate
        }

        return scores
    }
}
