import SwiftUI
import MusicKit

struct NowPlayingView: View {
    @EnvironmentObject var musicManager: MusicManager

    var body: some View {
        VStack {
            if let currentTrack = musicManager.currentTrack {
                Text(currentTrack.title)
                Text(currentTrack.artistName)
            } else {
                Text("Not Playing")
            }
        }
    }
}

struct NowPlayingView_Previews: PreviewProvider {
    static var previews: some View {
        NowPlayingView()
    }
}
