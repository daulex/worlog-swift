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
    @State private var showForm = false
    
    var body: some View {
        NavigationView{
            VStack {
                Text("Worlog has generated a comfortable \n \(Int(viewModel.workoutDuration)) minute workout")
                    .multilineTextAlignment(.center)
                    .font(.headline)
                    .padding(.bottom)
                Button(action: {
                    self.showForm.toggle()
                }){
                    Label("Customize settings", systemImage: "gear")
                        .padding()
                        .frame(width: 220)
                }
                .buttonStyle(.bordered)
                .sheet(isPresented: $showForm, content: {
                    VStack{
                        FormNumericStepper(value: $viewModel.startingPunches,
                                           label: $viewModel.labelStartingPunches)
                            .onChange(of: viewModel.startingPunches, perform: { newValue in
                                viewModel.calculateWorkoutDuration()
                            })
                        FormNumericStepper(value: $viewModel.roundsInSet,
                                           label: $viewModel.labelRoundsInSet)
                            .onChange(of: viewModel.roundsInSet, perform: { newValue in
                                viewModel.calculateWorkoutDuration()
                            })
                        FormNumericStepper(value: $viewModel.sets,
                                           label: $viewModel.labelSets)
                            .onChange(of: viewModel.sets, perform: { newValue in
                                viewModel.calculateWorkoutDuration()
                            })
                        HStack {
                            Text("\(viewModel.roundDuration) ")
                                .bold()
                            Stepper("\(viewModel.labelRoundDuration)",
                                    value: $viewModel.roundDuration,
                                    in: 30...180,
                                    step: 5)
                            .onChange(of: viewModel.roundDuration, perform: { newValue in
                                viewModel.calculateWorkoutDuration()
                            })
                        }
                        HStack {
                            Text("\(viewModel.restDuration) ")
                                .bold()
                            Stepper("\(viewModel.labelRestDuration)",
                                    value: $viewModel.restDuration,
                                    in: 10...90,
                                    step: 5)
                            .onChange(of: viewModel.restDuration, perform: { newValue in
                                viewModel.calculateWorkoutDuration()
                            })
                        }
                        HStack {
                            Text("\(viewModel.breakDuration) ")
                                .bold()
                            Stepper("\(viewModel.labelBreakDuration)",
                                    value: $viewModel.breakDuration,
                                    in: 1...10,
                                    step: 1)
                            .onChange(of: viewModel.breakDuration, perform: { newValue in
                                viewModel.calculateWorkoutDuration()
                            })
                        }
                        
                        FormToggle(value: $viewModel.noDoubles,
                                   label: $viewModel.labelNoDoubles)
                        FormToggle(value: $viewModel.alternateArms,
                                   label: $viewModel.labelAlternateArms)
                        FormToggle(value: $viewModel.increasePunches, label:
                                    $viewModel.labelIncreasePunches)
                        
                        Button(action: {
                            self.viewModel.initWorkoutGeneration()
                            self.showForm.toggle()
                        }) {
                            Label("Re-Generate", systemImage: "sparkles")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 220)
                        }
                        .buttonStyle(.borderedProminent)
                        .padding(.top)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .presentationDetents([.fraction(0.7)])
                })
                Button(action: {
                    self.viewModel.initWorkoutGeneration()
                    self.showResult.toggle()
                }) {
                    Label("Re-generate", systemImage: "sparkles")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 220)
                }
                .buttonStyle(.borderedProminent)
                .padding(.top)
                .sheet(isPresented: $showResult, content: {
                    GenerationResultView(rounds: self.viewModel.rounds)
                })
                
                Button(action: {
                    self.showResult.toggle()
                }) {
                    Label("Start", systemImage: "play.fill")
                        .font(.headline)
                        .padding()
                        .frame(width: 220)
                }
                .buttonStyle(.bordered)
                .tint(.green)
                .padding(.top)
            }
            .padding(.horizontal)
        }
        .onAppear{
            viewModel.calculateWorkoutDuration()
            viewModel.initWorkoutGeneration()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

