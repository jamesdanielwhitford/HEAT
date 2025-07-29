import XCTest
@testable import HEAT

class RecommendationEngineTests: XCTestCase {

    func testRecommendationEngine() {
        let engine = RecommendationEngine()

        let track1 = PlayedTrackData(title: "Track 1", artist: "Artist 1", timestamp: Date(), heartRate: 150, distance: 100)
        let track2 = PlayedTrackData(title: "Track 2", artist: "Artist 2", timestamp: Date(), heartRate: 180, distance: 120)
        let track3 = PlayedTrackData(title: "Track 3", artist: "Artist 3", timestamp: Date(), heartRate: 160, distance: 110)

        let session = WorkoutSession(
            startDate: Date(),
            endDate: Date(),
            duration: 3600,
            totalDistance: 330,
            totalEnergyBurned: 500,
            averageHeartRate: 163,
            playedTracks: [track1, track2, track3]
        )

        let recommendations = engine.analyze(session: session)

        XCTAssertEqual(recommendations.count, 3)
        XCTAssertEqual(recommendations[track1], 150)
        XCTAssertEqual(recommendations[track2], 180)
        XCTAssertEqual(recommendations[track3], 160)
    }
}
