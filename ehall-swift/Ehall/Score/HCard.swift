//
//  HCard.swift
//  AnimatedApp
//
//  Created by Meng To on 2022-04-14.
//

import SwiftUI

struct HCard: View {
    @Environment(\.colorScheme) var colorScheme
    
    var score: CourseScore
    var backgroundColor: Color {
        switch colorScheme {
        case .dark:
            Color(red: 25 / 255, green: 30 / 255, blue: 60 / 255)
        case .light:
            Color(red: 164 / 255, green: 196 / 255, blue: 250 / 255)
        default:
            Color(red: 240 / 255, green: 243 / 255, blue: 253 / 255)
        }
    }
    
    var body: some View {
        HStack(spacing: 20) {
            VStack(alignment: .leading, spacing: 8) {
                Text(score.courseName)
//                    .customFont(.title2)
                    .font(.title2)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(score.department)
//                    .customFont(.body)
                    .font(.body)
            }
            Divider()
            Text(String(score.totalScore))
                .font(.title)
                .bold()
        }
        .padding(30)
        .frame(maxWidth: .infinity, maxHeight: 110)
        .foregroundColor(.white)
        .background(backgroundColor)
        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
    }
}

struct HCard_Previews: PreviewProvider {
    static var previews: some View {
        HCard(score: PreviewCourseScore)
    }
}
