//
//  WorkoutSettingsFormView.swift
//  Worlog
//
//  Created by Kirills Galenko on 19/01/2023.
//

import SwiftUI

struct WorkoutSettingsFormView: View {
    @EnvironmentObject var settings: GameSettings
    @EnvironmentObject var state: GameState
    var body: some View {
        VStack{
            FormNumericStepper(value: $settings.startingPunches,
                               label: Strings.startingPunches )
            FormNumericStepper(value: $settings.roundsInSet,
                               label: Strings.roundsInSet)
            FormNumericStepper(value: $settings.sets,
                               label: Strings.sets)

            HStack {
                Text("\(settings.durationRound) ")
                    .bold()
                Stepper(Strings.roundDuration,
                        value: $settings.durationRound,
                        in: 30...180,
                        step: 5)
            }
            HStack {
                Text("\(settings.durationShortRest) ")
                    .bold()
                Stepper(Strings.shortRest,
                        value: $settings.durationShortRest,
                        in: 10...90,
                        step: 5)
            }
            HStack {
                Text("\(settings.durationLongRest) ")
                    .bold()
                Stepper(Strings.longRest,
                        value: $settings.durationLongRest,
                        in: 1...10,
                        step: 1)
            }
            
            FormToggle(value: $settings.noDoubles,
                       label: Strings.noDoubles)
            FormToggle(value: $settings.alternateArms,
                       label: Strings.alternateArms)
            FormToggle(value: $settings.increasePunches, label:
                        Strings.increasePunches)
            
        }
        .environmentObject(settings)
        .environmentObject(state)
        
    }
}

struct WorkoutSettingsFormView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutSettingsFormView()
            .environmentObject(GameSettings())
    }
}
