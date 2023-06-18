//
//  WorkoutWarmupView.swift
//  Worlog
//
//  Created by Kirills Galenko on 03/06/2023.
//

import SwiftUI

struct WorkoutWarmupView: View {
    var body: some View {
        VStack{
            Text("Warmup!")
                .font(.largeTitle)
            WorkoutComingUPview()
        }
    }
}

struct WorkoutWarmupView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutWarmupView()
    }
}
