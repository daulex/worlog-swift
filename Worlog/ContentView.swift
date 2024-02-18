//
//  ContentView.swift
//  Worlog
//
//  Created by Kirills Galenko on 09/01/2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var settings = GameSettings()
    @StateObject var state = GameState()
    
    @State private var showResult = false
    @State private var showForm = false
    
    var body: some View {
        NavigationView{
            VStack {
                
                Text("Worlog has generated a comfortable \n \(Int(settings.duration)) minute workout")
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
                    WorkoutSettingsFormView()
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .presentationDetents([.fraction(0.7)])
                })
                Button(action: {
                    self.showResult.toggle()
                }) {
                    Label("View workout", systemImage: "sparkles")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 220)
                }
                .buttonStyle(.borderedProminent)
                .padding(.top)
                .sheet(isPresented: $showResult, content: {
                    GenerationResultView()
                })
                
                
                NavigationLink {
                    WorkoutView()
                } label: {
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
        .environmentObject(settings)
        .environmentObject(state)
        .onAppear{
            settings.initWorkoutGeneration()
            settings.buildStageTypesArray()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

