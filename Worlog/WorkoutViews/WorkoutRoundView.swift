//
//  WorkoutRoundView.swift
//  Worlog
//
//  Created by Kirills Galenko on 03/06/2023.
//

import SwiftUI

struct WorkoutRoundView: View {
    @EnvironmentObject var settings: GameSettings
    
    var body: some View {
        Text("Hello, Round!")
        Text("\(settings.stagePunches[settings.currentStage])")
        Text("\(settings.roundDuration)")
    }
}

struct WorkoutRoundView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutRoundView()
    }
}
