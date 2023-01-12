//
//  ContentView.swift
//  Worlog
//
//  Created by Kirills Galenko on 09/01/2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ContentViewModel()
    @State private var showResult = false

    var body: some View {
        
        NavigationView{
            VStack {
                
                FormNumericStepper(value: $viewModel.startingPunches,
                                   label: $viewModel.labelStartingPunches)
                FormNumericStepper(value: $viewModel.roundsInSet,
                                   label: $viewModel.labelRoundsInSet)
                FormNumericStepper(value: $viewModel.sets,
                                   label: $viewModel.labelSets)
                
                FormToggle(value: $viewModel.noDoubles,
                           label: $viewModel.labelNoDoubles)
                FormToggle(value: $viewModel.alternateArms,
                           label: $viewModel.labelAlternateArms)
                FormToggle(value: $viewModel.increasePunches, label:
                            $viewModel.labelIncreasePunches)
                
                HStack(alignment: .center) {
                    Group{
                        Button(action: {
                            self.viewModel.initWorkoutGeneration()
                            self.showResult.toggle()
                        }) {
                            Text("Generate")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                        }
                        .buttonStyle(.borderedProminent)
                        .padding(.top)
                        .sheet(isPresented: $showResult, content: {
                            GenerationResultView(rounds: self.viewModel.rounds)
                        })
                    }
                }
                
                Spacer()
            }
            .padding(.horizontal)
            .navigationTitle("Generate form")
        }
    }
}

struct GenerationResultView: View {
    var rounds: [[[Int]]]
    var body: some View{
        List {
            Text("result")
            
            ForEach(rounds.indices, id: \.self) { roundIndex in
                Section(header: Text("Round \(roundIndex + 1)")) {
                    ForEach(rounds[roundIndex].indices, id: \.self) { repIndex in
                        HStack {
                            ForEach(rounds[roundIndex][repIndex].indices, id: \.self) { punchIndex in
                                Text("\(self.rounds[roundIndex][repIndex][punchIndex])")
                            }
                        }
                    }
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

