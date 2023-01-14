//
//  GenerationResultView.swift
//  Worlog
//
//  Created by Kirills Galenko on 14/01/2023.
//

import SwiftUI

struct GenerationResultView: View {
    var rounds: [[[Int]]]
    
    var body: some View{
        List {
            Text("Result")
                .font(.headline)
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

struct GenerationResultView_Previews: PreviewProvider {
    static var previews: some View {
        GenerationResultView(rounds: [[[5, 6], [2, 3], [3, 2], [5, 6], [2, 5]], [[6, 5, 2], [6, 5, 2], [1, 2, 3], [5, 6, 5], [1, 6, 3]], [[1, 4, 3, 6], [6, 1, 2, 3], [4, 3, 4, 1], [2, 5, 4, 1], [5, 2, 1, 6]], [[4, 3, 6, 1, 6], [1, 4, 5, 4, 5], [2, 1, 4, 1, 2], [6, 3, 2, 3, 2], [1, 2, 3, 4, 3]]])
    }
}
