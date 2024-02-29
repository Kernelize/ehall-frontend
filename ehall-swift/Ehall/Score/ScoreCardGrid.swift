//
//  ScoreCardGrid.swift
//  Ehall
//
//  Created by Hank Hogan on 2024/2/13.
//

import SwiftUI

struct ScoreCardGrid: View {
    @State private var searchText = ""
    let userData: [UserScore.Data]
    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 300), spacing: 0)], spacing: 20) {
            ForEach(userData) { data in
                Button {
                    
                } label: {
                    ScoreCard(data: data)
                        .padding(.leading)
                        .padding(.trailing)
                }
                .buttonStyle(ScaledButtonStyle())
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
