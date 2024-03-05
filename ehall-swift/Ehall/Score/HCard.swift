//
//  HCard.swift
//  AnimatedApp
//
//  Created by Meng To on 2022-04-14.
//

import SwiftUI
import Shimmer

struct HCard: View {
    @Environment(\.colorScheme) var colorScheme
    
    var score: CourseScore
    var backgroundColor: Color
    
    var body: some View {
        HStack(spacing: 20) {
            VStack(alignment: .leading, spacing: 8) {
                Text(score.courseName)
//                    .customFont(.title2)
                    .foregroundColor(.primary)
                    .font(.title2)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(score.department)
//                    .customFont(.body)
                    .foregroundColor(.secondary)
                    .font(.body)
            }
            Divider()
            ZStack {
                Circle()
                    .foregroundStyle(Color.black)
                    .frame(width: 64, height: 64)
                    .opacity(0.1)
                Text(String(score.totalScore))
                    .foregroundStyle(.primary)
                    .font(.title.bold())
            }
        }
        .padding(30)
        .frame(maxWidth: .infinity, maxHeight: 110)
        .background(backgroundColor)
        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
    }
}

struct FakeHCard: View {
    @Environment(\.colorScheme) var colorScheme
    
    var backgroundColor: Color
    
    var body: some View {
        HStack(spacing: 20) {
            VStack(alignment: .leading, spacing: 8) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.black.opacity(0.2))
                    .frame(height: 24)
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 18)
            }
            Divider()
            ZStack {
                Circle()
                    .foregroundStyle(Color.black)
                    .frame(width: 64, height: 64)
                    .opacity(0.1)
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 30, height: 30)
            }
        }
        .padding(30)
        .frame(maxWidth: .infinity, maxHeight: 110)
        .background(backgroundColor)
        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .shimmering()
    }
}


struct HCard_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HCard(score: PreviewCourseScore, backgroundColor: Color("Card 1"))
            HCard(score: PreviewCourseScore, backgroundColor: Color("Card 2"))
            HCard(score: PreviewCourseScore, backgroundColor: Color("Card 3"))
            HCard(score: PreviewCourseScore, backgroundColor: Color("Card 4"))
            HCard(score: PreviewCourseScore, backgroundColor: Color("Card 5"))
            FakeHCard(backgroundColor: Color("Card 1"))
        }
    }
}
