//
//  WorkoutView.swift
//  Worlog
//
//  Created by Kirills Galenko on 19/01/2023.
//

import SwiftUI

struct WorkoutView: View {
    @EnvironmentObject var settings: GameSettings
    

    @State private var remainingTime: Int = 0

    @State private var isPaused = true
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    var body: some View {
        VStack{
            if(settings.currentStage < settings.stageTypes.count - 1){
                
                VStack {
                    Text("\(remainingTime)")
                        .font(.largeTitle)
                        .padding()
                    
                    Button(action: {
                        isPaused.toggle()
                    }) {
                        Text(isPaused ? "Resume" : "Pause")
                            .font(.title)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .onReceive(timer) { _ in
                    if !isPaused {
                        if remainingTime > 1 {
                            remainingTime -= 1
                        } else {
                            if(settings.stageTypes.count - 1 > settings.currentStage){
                                remainingTime = 10
                                settings.currentStage += 1
                            } else {
                                isPaused.toggle()
                            }
                        }
                        
                    }
                }
            }
    
    
            Text("Stage  \(settings.currentStage + 1) of \(settings.stageTypes.count) !")
            Text("\(settings.stageTypes[settings.currentStage])" as String)
            
            
            WorkoutContentView(for: settings.stageTypes[settings.currentStage])
            
            HStack{

                Button(action:{
                    if(settings.currentStage > 0){
                        settings.currentStage -= 1
                    }
                }){
                    Label("Prev", systemImage: "backward.fill")
                }
                Spacer()
                Button(action:{
                    if(settings.stageTypes.count - 1 > settings.currentStage){
                        settings.currentStage += 1
                    }
                }){
                    Label("Next", systemImage: "forward.fill")
                }
                
            }
            
            
        }
        .onAppear {
                remainingTime = settings.durationShortRest
            }
    }
}

struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView()
            .environmentObject(GameSettings())
    }
}
