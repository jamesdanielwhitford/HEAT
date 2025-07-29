import SwiftUI
import HealthKit

struct SummaryView: View {
    @EnvironmentObject var workoutManager: WorkoutManager
    @EnvironmentObject var coordinator: AppCoordinator
    @Environment(\.dismiss) var dismiss
    private let recommendationEngine = RecommendationEngine()

    let workout: HKWorkout
    let playedTracks: [PlayedTrack]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                SummaryMetricView(title: "Total Time",
                                  value: workout.duration.format(using: [.hour, .minute, .second]))
                SummaryMetricView(title: "Total Distance",
                                  value: Measurement(value: workoutManager.distance, unit: UnitLength.meters).formatted(.measurement(width: .abbreviated, usage: .road, numberFormatStyle: .number.precision(.fractionLength(2)))))
                SummaryMetricView(title: "Total Energy",
                                  value: Measurement(value: workoutManager.activeEnergy, unit: UnitEnergy.kilocalories).formatted(.measurement(width: .abbreviated, usage: .workout, numberFormatStyle: .number.precision(.fractionLength(0)))))
                SummaryMetricView(title: "Avg. Heart Rate",
                                  value: workoutManager.averageHeartRate.formatted(.number.precision(.fractionLength(0))) + " bpm")

                Text("Played Tracks")
                    .font(.headline)

                ForEach(playedTracks, id: \.self) { track in
                    Text(track.track.title)
                }

                Button("View Recommendations") {
                    coordinator.showRecommendations(session: WorkoutSession(startDate: workout.startDate, endDate: workout.endDate, duration: workout.duration, totalDistance: workoutManager.distance, totalEnergyBurned: workoutManager.activeEnergy, averageHeartRate: workoutManager.averageHeartRate, playedTracks: playedTracks.map { PlayedTrackData(title: $0.track.title, artist: $0.track.artistName, timestamp: $0.timestamp, heartRate: $0.heartRate, distance: $0.distance) }))
                }

                Button("Done") {
                    dismiss()
                }
            }
            .scenePadding()
        }
        .navigationTitle("Summary")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SummaryMetricView: View {
    var title: String
    var value: String

    var body: some View {
        Text(title)
            .foregroundStyle(.primary)
        Text(value)
            .font(.system(.title2, design: .rounded).lowercaseSmallCaps())
            .foregroundStyle(.primary)
        Divider()
    }
}

extension TimeInterval {
    func format(using units: NSCalendar.Unit) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = units
        formatter.unitsStyle = .abbreviated
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: self) ?? ""
    }
}
