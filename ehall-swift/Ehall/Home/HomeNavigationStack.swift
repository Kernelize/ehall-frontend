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
        ScrollView {
            VStack {
                NavigationViewHeaderWithImageBlock(date: Date())
            }
        }
    }
}

#Preview {
    HomeNavigationStack()
        .environmentObject(ScoreViewModel())
}
