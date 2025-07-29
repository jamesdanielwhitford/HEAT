import Foundation
import MusicKit

class MusicManager: ObservableObject {
    @Published var isPlaying = false
    @Published var currentTrack: MusicKit.Song? = nil

    private let player = ApplicationMusicPlayer.shared

    func startPlayback() {
        // In a real app, you'd have a playlist or a selection of songs.
        // For now, let's just play a catalog song by its ID.
        Task {
            do {
                let request = MusicCatalogResourceRequest<Song>(matching: \.id, equalTo: "1440789639")
                let response = try await request.response()
                guard let song = response.items.first else { return }
                self.currentTrack = song
                player.queue = [song]
                try await player.play()
                self.isPlaying = true
            } catch {
                print("Error playing music: \(error)")
            }
        }
    }

    func stopPlayback() {
        player.stop()
        isPlaying = false
        currentTrack = nil
    }

    func requestMusicAuthorization() {
        Task {
            _ = await MusicAuthorization.request()
        }
    }

    func createPlaylist(name: String, tracks: [PlayedTrackData]) async throws {
        let newPlaylist = try await MusicLibrary.shared.createPlaylist(name: name, description: "Created by HEAT", authorDisplayName: "HEAT")
        try await addTracksToPlaylist(playlist: newPlaylist, tracks: tracks)
    }

    func addTracksToPlaylist(playlist: Playlist, tracks: [PlayedTrackData]) async throws {
        let trackIds = tracks.map { $0.id.uuidString }
        let request = MusicCatalogResourceRequest<Song>(matching: \.id, memberOf: trackIds.map { MusicItemID($0) })
        let response = try await request.response()
        try await MusicLibrary.shared.add(response.items, to: playlist)
    }
}
