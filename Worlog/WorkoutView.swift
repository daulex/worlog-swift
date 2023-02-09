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
            Text("Score is: \(settings.score)")
            Button("Increase Score") {
                settings.score += 1
            }
            
            
            Text("\(seconds)")
            if timerIsPaused {
                HStack {
                    Button(action:{
                        self.restartTimer()
                        print("RESTART")
                    }){
                        Image(systemName: "arrow.counterclockwise")
                            .padding(.all)
                    }
                    .padding(.all)
                    Button(action:{
                        self.startTimer()
                        print("START")
                    }){
                        Image(systemName: "play.fill")
                            .padding(.all)
                    }
                    .padding(.all)
                }
            } else {
                Button(action:{
                    print("STOP")
                    self.stopTimer()
                }){
                    Image(systemName: "pause.fill")
                        .padding(.all)
                }
                .padding(.all)
            }
            
        }
    }
    
    func startTimer(){
        timerIsPaused = false
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ tempTimer in
            self.seconds = self.seconds + 1
        }
    }
    
    func stopTimer(){
        timerIsPaused = true
        timer?.invalidate()
        timer = nil
    }
    func restartTimer(){
        seconds = 0
    }
    
}

struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView()
            .environmentObject(GameSettings())
    }
}
