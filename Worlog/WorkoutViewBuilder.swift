//
//  WorkoutViewBuilder.swift
//  Worlog
//
//  Created by Kirills Galenko on 03/06/2023.
//

import SwiftUI

@ViewBuilder
func WorkoutContentView(for stageType: WorkoutStages) -> some View {
    switch stageType {
    case .warmup:
        WorkoutWarmupView()
    case .round:
        WorkoutRoundView()
    case .shortRest:
        WorkoutShortRestView()
    case .longRest:
        WorkoutLongRestView()
    case .finished:
        WorkoutFinishedView()
    }
}
