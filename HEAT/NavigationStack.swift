import SwiftUI

struct NavigationStack<Content: View>: View {
    @StateObject var coordinator = AppCoordinator()
    let content: (AppCoordinator) -> Content

    var body: some View {
        SwiftUI.NavigationStack(path: $coordinator.path) {
            content(coordinator)
                .navigationDestination(for: WorkoutSummaryRoute.self) { route in
                    SummaryView(workout: route.workout, playedTracks: route.playedTracks)
                }
                .navigationDestination(for: RecommendationRoute.self) { route in
                    RecommendationView(recommendedTracks: RecommendationEngine().analyze(session: route.session))
                }
        }
    }
}
