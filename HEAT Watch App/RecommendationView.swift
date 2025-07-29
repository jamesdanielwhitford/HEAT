import SwiftUI

struct RecommendationView: View {
    @EnvironmentObject var musicManager: MusicManager
    let recommendedTracks: [PlayedTrackData: Double]

    var body: some View {
        List {
            ForEach(recommendedTracks.sorted(by: { $0.value > $1.value }), id: \.key) { track, score in
                VStack(alignment: .leading) {
                    Text(track.title)
                    Text(track.artist)
                    Text("Score: \(score, specifier: "%.2f")")
                }
            }
        }
        .navigationTitle("Boosted Tracks")
        .toolbar {
            Button("Create Playlist") {
                Task {
                    try await musicManager.createPlaylist(name: "HEAT Boost", tracks: recommendedTracks.keys.map { $0 })
                }
            }
        }
    }
}
