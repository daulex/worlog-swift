//
//  WorkoutComingUPview.swift
//  Worlog
//
//  Created by Kirills Galenko on 18/06/2023.
//

import SwiftUI

struct WorkoutComingUPview: View {
    @EnvironmentObject var settings: GameSettings
    var body: some View {
        if settings.stagePunches.indices.contains(settings.currentStage + 1) {
            VStack{
                Text("Coming up")
                Text("\(settings.stagePunches[settings.currentStage + 1])")
                    .font(.largeTitle)
            }
            .padding()
        }
    }
}
