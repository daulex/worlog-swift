//
//  WorkoutRoundView.swift
//  Worlog
//
//  Created by Kirills Galenko on 03/06/2023.
//

import SwiftUI

struct WorkoutRoundView: View {
    @EnvironmentObject var settings: GameSettings
    @EnvironmentObject var state: GameState
    
    var body: some View {
        
        Text("\(settings.stagePunches[state.currentStage])")
            .font(.largeTitle)
        
    }
}

struct WorkoutRoundView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutRoundView()
    }
}
