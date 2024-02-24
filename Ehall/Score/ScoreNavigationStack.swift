//
//  ScoreNavigationStack.swift
//  Ehall
//
//  Created by Hank Hogan on 2024/2/13.
//

import SwiftUI

struct ScoreNavigationStack: View {
    @State var isAccountViewPresented = false
    @EnvironmentObject var score: ScoreViewModel
    
    var body: some View {
        NavigationStack {
            Group {
                if score.isAvailabe {
                    ScoreCardGrid(userData: score.scores.data ?? [])
                } else {
                    Rectangle()
                }
            }
            .navigationTitle("Score")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    AccountButton(isAccountViewPresented: $isAccountViewPresented)
                }
            }
            .overlay {
                if !score.isAvailabe {
                    ContentUnavailableView {
                        Label("Not Signed In", systemImage: "tray.fill")
                    } description: {
                        Text("Your Scores will be shown here")
                    }
                    .background()
                }
            }
//            .overlay {
//            }
        }
    }
}

#Preview {
    ScoreNavigationStack()
        .environmentObject(ScoreViewModel())
}
