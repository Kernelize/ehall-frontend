//
//  AccountButton.swift
//  Ehall
//
//  Created by Hank Hogan on 2024/2/24.
//

import SwiftUI

struct AccountButton: View {
    @Binding var isAccountViewPresented: Bool
    
    var body: some View {
        Button(action: {
            isAccountViewPresented = true
        }) {
            Image(systemName: "person.circle.fill")
                .foregroundColor(.secondary)
                .font(.title)
                .clipShape(Circle())
        }
        .sheet(isPresented: self.$isAccountViewPresented) {
            AccountNavigationStack()
        }
    }
}


struct AccountButton_Previews: PreviewProvider {
    static var previews: some View {
        AccountButton(isAccountViewPresented: .constant(false))
            .previewLayout(.sizeThatFits)
    }
}
