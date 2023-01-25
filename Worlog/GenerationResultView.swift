//
//  GenerationResultView.swift
//  Worlog
//
//  Created by Kirills Galenko on 14/01/2023.
//

import SwiftUI

struct GenerationResultView: View {
    
    @EnvironmentObject var settings: GameSettings
    var body: some View{
        List {
            HStack{
                Text("Result")
                    .font(.headline)
                Spacer()
                Button("Re-generate") {
                    settings.initWorkoutGeneration()
                    settings.buildStageTypesArray()
                }
            }
            
            ForEach(settings.rounds.indices, id: \.self) { roundIndex in
                Section(header: Text("Round \(roundIndex + 1)")) {
                    ForEach(settings.rounds[roundIndex].indices, id: \.self) { repIndex in
                        HStack {
                            ForEach(settings.rounds[roundIndex][repIndex].indices, id: \.self) { punchIndex in
                                Text("\(self.settings.rounds[roundIndex][repIndex][punchIndex])")
                            }
                        }
                    }
                }
            }
        }
    }
}

struct GenerationResultView_Previews: PreviewProvider {
    static var previews: some View {
        GenerationResultView()
            .environmentObject(GameSettings())
    }
}
