//
//  HomeNavigationStack.swift
//  Ehall
//
//  Created by Hank Hogan on 2024/2/13.
//

import SwiftUI

struct HomeNavigationStack: View {
    @State var isAccountViewPresented = false
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject private var score: ScoreViewModel
    @State private var selection = 2

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    NavigationViewHeaderWithImageBlock(date: Date())
                    if score.isAvailabe {
                        highLightsList
                    }
                }
                .navigationBarHidden(true)
            }
            .background(Color.background)
        }
    }
    
    var highLightsList: some View {
        VStack(alignment: .leading) {
            Text("HighLights")
                .font(.title2.bold())
            NavigationLink(destination: EmptyView()) {
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundStyle(Color.white.opacity(0.8))
                        .shadow(color: Color.gray.opacity(0.2), radius: 10)
                    TotalScoreHighLightCard(score: score.scores.maxTotalScore!)
                        .padding(.horizontal)
                        .padding(.vertical, 6)
                }
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding()
    }
    
}

#Preview {
    HomeNavigationStack()
        .environmentObject(PreviewScoreViewModel)
}
