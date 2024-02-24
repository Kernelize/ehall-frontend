//
//  DismissButton.swift
//  Ehall
//
//  Created by Hank Hogan on 2024/2/24.
//

import SwiftUI

struct DismissButton: View {
    var title: String
    @Environment(\.presentationMode) var presentationMode:Binding<PresentationMode>
    
    var body: some View {
        Button(title) {
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}


struct DismmissButton_Previews: PreviewProvider {
    static var previews: some View {
        DismissButton(title: "Done")
    }
}
