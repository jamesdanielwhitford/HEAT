import SwiftUI
import MusicKit

struct OnboardingView: View {
    @EnvironmentObject var workoutManager: WorkoutManager
    @EnvironmentObject var musicManager: MusicManager
    @Binding var isOnboarding: Bool
    @State private var showingAlert = false

    var body: some View {
        VStack {
            Text("Welcome to HEAT")
                .font(.largeTitle)
            Text("This app requires access to your Health data and Apple Music library to provide personalized workout recommendations.")
                .multilineTextAlignment(.center)
                .padding()

            Button("Grant HealthKit Access") {
                workoutManager.requestAuthorization()
            }
            .buttonStyle(MaterialButtonStyle(fillColor: .accentColor))

            Button("Grant Apple Music Access") {
                musicManager.requestMusicAuthorization()
            }
            .buttonStyle(MaterialButtonStyle(fillColor: .accentColor))

            Button("Continue") {
                if workoutManager.healthStore.authorizationStatus(for: .workoutType()) == .sharingAuthorized && MusicAuthorization.currentStatus == .authorized {
                    isOnboarding = false
                } else {
                    showingAlert = true
                }
            }
            .padding()
        }
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Permissions Required"),
                message: Text("Please grant both HealthKit and Apple Music permissions to continue."),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}
