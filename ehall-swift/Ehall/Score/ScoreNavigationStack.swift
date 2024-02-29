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
    
    @State private var selectedCourseID: UserScore.Data?
    @State private var topmostCourseID: UserScore.Data?
    @Namespace private var namespace

    var body: some View {
        NavigationStack {
            container
        }
    }
    
    var container: some View {
        ScrollView {
            content
        }
    }
    
    var content: some View {
        Group {
            if score.isAvailabe {
                ScoreCardGrid(userData: score.scores.data ?? [])
            } else {
                Spacer()
//                myContentUnavailableView
                Spacer()
            }
        }
        .navigationTitle("Score")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                AccountButton(isAccountViewPresented: $isAccountViewPresented)
            }
        }
    }
    
    var myContentUnavailableView: some View {
        ContentUnavailableView {
            Label("Not Signed In", systemImage: "tray.fill")
        } description: {
            Text("Your Scores will be shown here")
        }
        .background()
    }
}

#Preview {
    ScoreNavigationStack()
        .environmentObject(ScoreViewModel())
}
