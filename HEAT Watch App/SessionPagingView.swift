import SwiftUI
import HealthKit

struct SessionPagingView: View {
    @EnvironmentObject var workoutManager: WorkoutManager
    @State private var selection: Tab = .metrics

    enum Tab {
        case controls, metrics, nowPlaying
    }

    var body: some View {
        TabView(selection: $selection) {
            ControlsView().tag(Tab.controls)
            MetricsView().tag(Tab.metrics)
            NowPlayingView().tag(Tab.nowPlaying)
        }
        .navigationTitle(workoutManager.selectedWorkout?.name ?? "")
        .navigationBarBackButtonHidden(true)
        .tabViewStyle(
            PageTabViewStyle(indexDisplayMode: .automatic)
        )
        .onChange(of: workoutManager.running) { _, _ in
            displayMetricsView()
        }
        .fullScreenCover(isPresented: $workoutManager.showingSummaryView) {
            if let workout = workoutManager.workout {
                SummaryView(workout: workout, playedTracks: workoutManager.playedTracks)
            }
        }
    }

    private func displayMetricsView() {
        withAnimation {
            selection = .metrics
        }
    }
}

struct SessionPagingView_Previews: PreviewProvider {
    static var previews: some View {
        SessionPagingView()
    }
}
