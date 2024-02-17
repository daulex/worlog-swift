//
//  WorkoutSettingsFormView.swift
//  Worlog
//
//  Created by Kirills Galenko on 19/01/2023.
//

import SwiftUI

struct WorkoutSettingsFormView: View {
    @EnvironmentObject var settings: GameSettings
    var body: some View {
        VStack{
            FormNumericStepper(value: $settings.startingPunches,
                               label: Strings.startingPunches )
                .onChange(of: settings.startingPunches, perform: { newValue in
                    settings.calculateDuration()
                    
                })
            FormNumericStepper(value: $settings.roundsInSet,
                               label: Strings.roundsInSet)
                .onChange(of: settings.roundsInSet, perform: { newValue in
                    settings.calculateDuration()
                    
                })
            FormNumericStepper(value: $settings.sets,
                               label: Strings.sets)
                .onChange(of: settings.sets, perform: { newValue in
                    settings.calculateDuration()
                    
                })
            HStack {
                Text("\(settings.durationRound) ")
                    .bold()
                Stepper(Strings.roundDuration,
                        value: $settings.durationRound,
                        in: 30...180,
                        step: 5)
                .onChange(of: settings.durationRound, perform: { newValue in
                    settings.calculateDuration()
                    
                })
            }
            HStack {
                Text("\(settings.durationShortRest) ")
                    .bold()
                Stepper(Strings.shortRest,
                        value: $settings.durationShortRest,
                        in: 10...90,
                        step: 5)
                .onChange(of: settings.durationShortRest, perform: { newValue in
                    settings.calculateDuration()
                    
                    
                })
            }
            HStack {
                Text("\(settings.durationLongRest) ")
                    .bold()
                Stepper(Strings.longRest,
                        value: $settings.durationLongRest,
                        in: 1...10,
                        step: 1)
                .onChange(of: settings.durationLongRest, perform: { newValue in
                    settings.calculateDuration()
                    
                    
                })
            }
            
            FormToggle(value: $settings.noDoubles,
                       label: Strings.noDoubles)
            FormToggle(value: $settings.alternateArms,
                       label: Strings.alternateArms)
            FormToggle(value: $settings.increasePunches, label:
                        Strings.increasePunches)
            
        }
        .environmentObject(settings)
    }
}

struct WorkoutSettingsFormView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutSettingsFormView()
            .environmentObject(GameSettings())
    }
}
