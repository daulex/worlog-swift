//
//  WorkoutShortRestView.swift
//  Worlog
//
//  Created by Kirills Galenko on 03/06/2023.
//

import SwiftUI

struct WorkoutShortRestView: View {
    
    var body: some View {
        
        VStack{
            Text("Short rest")
                .font(.largeTitle)
            WorkoutComingUPview()
            
        }
    }
}

struct WorkoutShortRestView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutShortRestView()
    }
}
