//
//  CourseItem.swift
//  Ehall
//
//  Created by Hank Hogan on 2024/2/12.
//

import SwiftUI

struct CourseItem: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 4.0) {
            Spacer()
            HStack {
                Spacer()
                Image("Illustration 1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Spacer()
            }
            Text("SwiftUI for this").fontWeight(.bold).foregroundColor(.white)
            Text("Hello, world!").font(.footnote).foregroundColor(.white)
        }
        .padding(.all)
        .background(.blue)
        .cornerRadius(20.0)
        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    CourseItem()
}
