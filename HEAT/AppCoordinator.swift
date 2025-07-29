import SwiftUI
import HealthKit

class AppCoordinator: ObservableObject {
    @Published var path = NavigationPath()

    func showWorkoutSummary(workout: HKWorkout, playedTracks: [PlayedTrack]) {
        path.append(WorkoutSummaryRoute(workout: workout, playedTracks: playedTracks))
    }

    func showRecommendations(session: WorkoutSession) {
        path.append(RecommendationRoute(session: session))
    }
}

struct WorkoutSummaryRoute: Hashable {
    static func == (lhs: WorkoutSummaryRoute, rhs: WorkoutSummaryRoute) -> Bool {
        return lhs.workout == rhs.workout && lhs.playedTracks == rhs.playedTracks
    }
    
    let workout: HKWorkout
    let playedTracks: [PlayedTrack]

    func hash(into hasher: inout Hasher) {
        hasher.combine(workout)
        hasher.combine(playedTracks)
    }
}

struct RecommendationRoute: Hashable {
    let session: WorkoutSession
}
