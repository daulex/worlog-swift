//
//  WorkoutView.swift
//  Worlog
//
//  Created by Kirills Galenko on 19/01/2023.
//

import SwiftUI

struct WorkoutView: View {
    @EnvironmentObject var settings: GameSettings
    @State var remainingTime: Int = 0
    @State private var isPaused = false
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var currentStage: WorkoutStages {
        settings.stageTypes[settings.currentStage]
    }
    
    var durationForCurrentStage: Int {
        settings.getDurationForStage(currentStage)
    }
    
    var isLastStage: Bool {
        settings.currentStage == settings.stageTypes.count - 1
    }
    
    var body: some View {
        VStack {
            
            Spacer()
            WorkoutContentView(for: currentStage)
            Spacer()
            HStack {
                if !isLastStage {
                    Text("\(remainingTime)")
                        .font(.headline)
                        .padding()
                    Spacer()
                }
                
                if isLastStage {
                    Button(action: {
                        attemptStageChange(0)
                    }) {
                        Image(systemName: "restart")
                    }.padding()
                }
                
                Button(action: {
                    attemptStageChange(-1)
                }) {
                    Image(systemName: "backward.fill")
                }.padding()
                
                if !isLastStage {
                    Button(action: {
                        attemptStageChange(1)
                    }) {
                        Image(systemName: "forward.fill")
                    }.padding()
                    
                    Button(action: {
                        isPaused.toggle()
                    }) {
                        Image(systemName: isPaused ? "play.circle.fill" : "pause.circle.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.blue)
                    }.padding()
                }
            }
            .onReceive(timer) { _ in
                if !isPaused {
                    if remainingTime != 0 {
                        remainingTime -= 1
                    } else {
                        attemptStageChange(1)
                    }
                }
            }
            .padding()
            
            Text("\(settings.currentStage + 1) of \(settings.stageTypes.count)")
            
        }
        .onAppear {
            attemptStageChange(0)
        }
    }
    
    func attemptStageChange(_ direction: Int) {
        if direction == 0 {
            settings.currentStage = 0
        } else {
            let nextStage = settings.currentStage + direction
            if nextStage >= 0 && nextStage < settings.stageTypes.count {
                settings.currentStage = nextStage
            }
        }
        remainingTime = settings.getDurationForStage(settings.stageTypes[settings.currentStage])
    }


}
