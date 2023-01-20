//
//  WorkoutView.swift
//  Worlog
//
//  Created by Kirills Galenko on 19/01/2023.
//

import SwiftUI

struct WorkoutView: View {
    @EnvironmentObject var settings: GameSettings
    
    var body: some View {
        VStack{
            Text("Score is: \(settings.score)")
            Button("Increase Score") {
                settings.score += 1
            }
            
            Button(action: {
                
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
