//
//  WorkoutView.swift
//  Worlog
//
//  Created by Kirills Galenko on 19/01/2023.
//

import SwiftUI

struct WorkoutView: View {
    @EnvironmentObject var settings: GameSettings
    @State var timeRemaining = 10
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
        VStack{
            Text("Score is: \(settings.score)")
            Button("Increase Score") {
                settings.score += 1
            }
            

                
            Text("\(timeRemaining)")
                .onReceive(timer) { _ in
                    if timeRemaining > 0 {
                        timeRemaining -= 1
                    }
                }
                
            
            Button("Stop", action: {
                    self.timer.upstream.connect().cancel()
                })

        }
    }
}

struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView()
            .environmentObject(GameSettings())
    }
}
