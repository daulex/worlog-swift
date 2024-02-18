//
//  WorkoutComingUPview.swift
//  Worlog
//
//  Created by Kirills Galenko on 18/06/2023.
//

import SwiftUI

struct WorkoutComingUPview: View {
    @EnvironmentObject var settings: GameSettings
    @EnvironmentObject var state: GameState
    var body: some View {
        if settings.stagePunches.indices.contains(state.currentStage + 1) {
            VStack{
                Text("Coming up")
                Text("\(settings.stagePunches[state.currentStage + 1])")
                    .font(.largeTitle)
            }
            .padding()
        }
    }
}
