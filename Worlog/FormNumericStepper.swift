//
//  FormNumericStepper.swift
//  Worlog
//
//  Created by Kirills Galenko on 09/01/2023.
//

import SwiftUI

struct FormNumericStepper: View {
    
    @Binding var value: Int
    @Binding var label: String
    
    let range = 1...8
    
    var body: some View {
        HStack {
            Text("\(value) ")
                .bold()
            Stepper("\(label)", value: $value, in: range)
        }
    }
}

struct FormNumericStepper_Previews: PreviewProvider {
    static var previews: some View {
        FormNumericStepper(
            value: .constant(3),
            label: .constant("Label")
        )
    }
}
