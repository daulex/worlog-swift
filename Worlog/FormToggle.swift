//
//  FormToggle.swift
//  Worlog
//
//  Created by Kirills Galenko on 09/01/2023.
//

import SwiftUI

struct FormToggle: View {
    
    @Binding var value: Bool
    @Binding var label: String
    
    var body: some View {
        Toggle(label, isOn: $value)
    }
}

struct FormToggle_Previews: PreviewProvider {
    static var previews: some View {
        FormToggle(
            value: .constant(true),
            label: .constant("Label")
        )
    }
}
