//
//  HEATApp.swift
//  HEAT Watch App
//
//  Created by James Whitford on 2025/07/29.
//

import SwiftUI
import SwiftData

@main
struct HEAT_Watch_AppApp: App {
    @StateObject var workoutManager = WorkoutManager()
    @StateObject var musicManager = MusicManager()
    @AppStorage("isOnboarding") var isOnboarding: Bool = true

    var body: some Scene {
        WindowGroup {
            if isOnboarding {
                OnboardingView(isOnboarding: $isOnboarding)
                    .environmentObject(workoutManager)
                    .environmentObject(musicManager)
            } else {
                NavigationStack { coordinator in
                    ContentView()
                        .environmentObject(workoutManager)
                        .environmentObject(musicManager)
                        .environmentObject(coordinator)
                }
            }
        }
        .modelContainer(for: [WorkoutSession.self, PlayedTrackData.self])
    }
}


