//
//  WorkoutView.swift
//  Worlog
//
//  Created by Kirills Galenko on 19/01/2023.
//

import SwiftUI

struct WorkoutView: View {
    @EnvironmentObject var settings: GameSettings
    

    @State var seconds: Int = 0
    @State var timerIsPaused: Bool = true
    
    @State var timer: Timer? = nil
    
    
    var body: some View {
        VStack{
            Text("Stage  \(settings.currentStage + 1) of \(settings.stageTypes.count) !")
            Text("\(settings.stageTypes[settings.currentStage])" as String)
            
            WorkoutContentView(for: settings.stageTypes[settings.currentStage])
            
            if(settings.currentStage < settings.stageTypes.count - 1){
                Button("Jump to next stage") {
                    if(settings.stageTypes.count - 1 > settings.currentStage){
                        settings.currentStage += 1
                    }
                }
                
            }
            
            Button(action: {
                settings.isRunning = true
            }) {
                Label("Start", systemImage: "play.fill")
                    .font(.headline)
                    .padding()
                    .frame(width: 220)
            }
            .buttonStyle(.borderedProminent)
            .padding(.top)

        }
    }
}

struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView()
            .environmentObject(GameSettings())
    }
}
