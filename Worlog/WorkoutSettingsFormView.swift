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
                               label: $settings.labelStartingPunches)
                .onChange(of: settings.startingPunches, perform: { newValue in
                    settings.calculateDuration()
                    
                })
            FormNumericStepper(value: $settings.roundsInSet,
                               label: $settings.labelRoundsInSet)
                .onChange(of: settings.roundsInSet, perform: { newValue in
                    settings.calculateDuration()
                    
                })
            FormNumericStepper(value: $settings.sets,
                               label: $settings.labelSets)
                .onChange(of: settings.sets, perform: { newValue in
                    settings.calculateDuration()
                    
                })
            HStack {
                Text("\(settings.durationRound) ")
                    .bold()
                Stepper("\(settings.labelRoundDuration)",
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
                Stepper("\(settings.labelShortRest)",
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
                Stepper("\(settings.labelLongRest)",
                        value: $settings.durationLongRest,
                        in: 1...10,
                        step: 1)
                .onChange(of: settings.durationLongRest, perform: { newValue in
                    settings.calculateDuration()
                    
                    
                })
            }
            
            FormToggle(value: $settings.noDoubles,
                       label: $settings.labelNoDoubles)
            FormToggle(value: $settings.alternateArms,
                       label: $settings.labelAlternateArms)
            FormToggle(value: $settings.increasePunches, label:
                        $settings.labelIncreasePunches)
            
//            Button(action: {
//                self.settings.initWorkoutGeneration()
//                self.settings.calculateDuration()
//                self.showForm.toggle()
//            }) {
//                Label("Re-Generate", systemImage: "sparkles")
//                    .font(.headline)
//                    .foregroundColor(.white)
//                    .padding()
//                    .frame(width: 220)
//            }
//            .buttonStyle(.borderedProminent)
//            .padding(.top)
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
