//
//  WorkoutLongRestView.swift
//  Worlog
//
//  Created by Kirills Galenko on 03/06/2023.
//

import SwiftUI

struct WorkoutLongRestView: View {
    var body: some View {
        VStack{
            Text("Long rest")
                .font(.largeTitle)
            WorkoutComingUPview()
            
        }
    }
}

struct WorkoutLongRestView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutLongRestView()
    }
}
