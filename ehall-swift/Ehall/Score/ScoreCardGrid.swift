//
//  ScoreCardGrid.swift
//  Ehall
//
//  Created by Hank Hogan on 2024/2/13.
//

import SwiftUI

struct ScoreCardGrid: View {
    @State private var searchText = ""
    let userData: [CourseScore]
    private var filteredUserData: [CourseScore] {
        userData.filter {
            searchText == "" || $0.courseName.contains(searchText)
        }
    }

    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 300), spacing: 0)], spacing: 20) {
            if filteredUserData.isEmpty {
                ContentUnavailableView.search
            } else {
                ForEach(filteredUserData) { data in
                    NavigationLink(destination: ScoreDetailView()) {
                        HCard(score: data, backgroundColor: Color("Card \(Int.random(in: 1...5))"))
                            .font(nil)
                            .padding(.leading)
                            .padding(.trailing)
                    }
                    .buttonStyle(ScaledButtonStyle())
                }
            }
        }
        .searchable(text: $searchText)
    }
}

struct FakeScoreCardGrid: View {
    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 300), spacing: 0)], spacing: 20) {
            ForEach(0..<10) { _ in
                FakeHCard(backgroundColor: Color("Card \(Int.random(in: 1...5))"))
                    .font(nil)
                    .padding(.leading)
                    .padding(.trailing)
            }
        }
    }
}

struct ScaledButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.94 : 1)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}
