//
//  ContentView.swift
//  HEAT
//
//  Created by James Whitford on 2025/07/29.
//

import SwiftUI
import HealthKit

struct ContentView: View {
    @EnvironmentObject var workoutManager: WorkoutManager
    @EnvironmentObject var musicManager: MusicManager
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var coordinator: AppCoordinator
    var workoutTypes: [HKWorkoutActivityType] = [.cycling, .running, .walking]

    var body: some View {
        VStack {
            ForEach(workoutTypes) { workoutType in
                NavigationLink(
                    workoutType.name,
                    destination: SessionPagingView(),
                    tag: workoutType,
                    selection: $workoutManager.selectedWorkout
                ).buttonStyle(MaterialButtonStyle(fillColor: .accentColor))
            }
        }
        .navigationTitle("HEAT")
        .onAppear {
            workoutManager.requestAuthorization()
            musicManager.requestMusicAuthorization()
            workoutManager.modelContext = modelContext
            workoutManager.coordinator = coordinator
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension HKWorkoutActivityType: Identifiable {
    public var id: UInt {
        rawValue
    }

    var name: String {
        switch self {
        case .running:
            return "Run"
        case .cycling:
            return "Bike"
        case .walking:
            return "Walk"
        default:
            return ""
        }
    }
}

struct MaterialButtonStyle: ButtonStyle {
    var fillColor: Color

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(fillColor)
            .foregroundColor(.white)
            .cornerRadius(8)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}
