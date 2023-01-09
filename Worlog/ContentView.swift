//
//  ContentView.swift
//  Worlog
//
//  Created by Kirills Galenko on 09/01/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var startingPunches: Int = 2
    @State private var labelStartingPunches = "Starting punches"
    
    @State private var roundsInSet: Int = 5
    @State private var labelRoundsInSet = "Rounds in set"
    
    @State private var sets: Int = 4
    @State private var labelSets = "Sets"
    
    @State private var noDoubles: Bool = false
    @State private var labelNoDoubles = "Force no doubles"
    
    @State private var alternateArms: Bool = true
    @State private var labelAlternateArms = "Alternate arms"
    
    @State private var increasePunches: Bool = true
    @State private var labelIncreasePunches = "Each round increases punches"
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("Generate workout:")
                .font(.largeTitle)
                .multilineTextAlignment(.leading)
            FormNumericStepper(value: $startingPunches, label: $labelStartingPunches)
            FormNumericStepper(value: $roundsInSet, label: $labelRoundsInSet)
            FormNumericStepper(value: $sets, label: $labelSets)
            FormToggle(value: $noDoubles, label: $labelNoDoubles)
            FormToggle(value: $alternateArms, label: $labelAlternateArms)
            FormToggle(value: $increasePunches, label: $labelIncreasePunches)
            
            VStack{
                Button(action: {}) {
                    Text("Generate")
                        .font(.title)
                        .padding(10)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .frame(maxWidth: .infinity)
            }
            .padding(.top, 10)
        }
        .padding(20)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
