//
//  HomeNavigationStack.swift
//  Ehall
//
//  Created by Hank Hogan on 2024/2/13.
//

import SwiftUI

struct HomeNavigationStack: View {
    @State var isAccountViewPresented = false
    
    var body: some View {
        NavigationStack {
            Text("Nothing here now.")
                .navigationTitle("Home")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        AccountButton(isAccountViewPresented: $isAccountViewPresented)
                    }
                }
        }
    }
}

#Preview {
    HomeNavigationStack()
}
