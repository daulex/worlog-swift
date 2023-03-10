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
                Text("\(settings.roundDuration) ")
                    .bold()
                Stepper("\(settings.labelRoundDuration)",
                        value: $settings.roundDuration,
                        in: 30...180,
                        step: 5)
                .onChange(of: settings.roundDuration, perform: { newValue in
                    settings.calculateDuration()
                    
                })
            }
            HStack {
                Text("\(settings.restDuration) ")
                    .bold()
                Stepper("\(settings.labelRestDuration)",
                        value: $settings.restDuration,
                        in: 10...90,
                        step: 5)
                .onChange(of: settings.restDuration, perform: { newValue in
                    settings.calculateDuration()
                    
                    
                })
            }
            HStack {
                Text("\(settings.breakDuration) ")
                    .bold()
                Stepper("\(settings.labelBreakDuration)",
                        value: $settings.breakDuration,
                        in: 1...10,
                        step: 1)
                .onChange(of: settings.breakDuration, perform: { newValue in
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
