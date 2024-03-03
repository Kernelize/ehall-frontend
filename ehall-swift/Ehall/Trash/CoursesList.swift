//
//  CoursesList.swift
//  Ehall
//
//  Created by Hank Hogan on 2024/2/12.
//

import SwiftUI

struct CoursesList: View {
    var body: some View {
        #if os(iOS)
        content
            .listStyle(InsetGroupedListStyle())
        #else
        content
            .frame(minWidth: 800, minHeight: 600)
        #endif
    }
    
    var content: some View {
        List(0..<20) { item in
            CourseRow()
//            CourseItem()
        }
        .navigationTitle("Courses")
    }
}

#Preview {
    CoursesList()
}
