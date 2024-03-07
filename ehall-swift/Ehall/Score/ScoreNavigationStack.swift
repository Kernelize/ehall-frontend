//
//  ScoreNavigationStack.swift
//  Ehall
//
//  Created by Hank Hogan on 2024/2/13.
//

import SwiftUI

struct ScoreNavigationStack: View {
    @State var isOnBoardingViewPresented = false
    @EnvironmentObject var score: ScoreViewModel
    
    @State private var selectedCourseID: CourseScore?
    @State private var topmostCourseID: CourseScore?
    @Namespace private var namespace

    var body: some View {
        NavigationStack {
            ZStack {
                container
            }
        }
    }
    
    var container: some View {
        ScrollView {
            content
        }
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 0) {
            Group {
                if score.isAvailabe {
                    ScoreCardGrid(userData: score.scores)
                } else if score.isInfoAvailable {
                    FakeScoreCardGrid()
                    .task {
                        while await score.getScore() == false {}
                    }
                } else {
                    ContentUnavailableView {
                        // 1
                        Label("Not Logged In", systemImage: "person.crop.circle.badge.questionmark")
                    } description: {
                        Text("Log in to view your scores.")
                    } actions: {
                        // 2
                        Button("Log In") {
                            self.isOnBoardingViewPresented = true
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
            }
        }
        .navigationTitle("Score")
        .fullScreenCover(isPresented: $isOnBoardingViewPresented) {
            OnBoardingView()
        }
//        .toolbar {
//            ToolbarItem(placement: .topBarTrailing) {
//                AccountButton(isAccountViewPresented: $isAccountViewPresented)
//            }
//        }
            
    }
}

#Preview {
    ScoreNavigationStack()
        .environmentObject(ScoreViewModel())
}

#Preview {
    ScoreNavigationStack()
        .environmentObject(PreviewScoreViewModel)
}
