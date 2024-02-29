//
//  CourseView.swift
//  Ehall
//
//  Created by Hank Hogan on 2024/2/12.
//

import SwiftUI

struct CourseView: View {
    @State var show = false
    @Namespace var namespace
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    CourseItem()
                    .matchedGeometryEffect(id: "Card", in: namespace, isSource: !show)
                    .frame(width: 335, height: 250)
                    
                    CourseItem()
                    .frame(width: 335, height: 250)
                }
                .frame(maxWidth: .infinity)
            }
            
            if show {
                ScrollView {
                    CourseItem()
                        .matchedGeometryEffect(id: "Card", in: namespace)
                        .frame(height: 300)
                    VStack {
                        ForEach(0..<20) { item in
                            CourseRow()
                        }
                    }
                }
                .background(Color("Background 1"))
                .transition(AnyTransition.opacity.animation(Animation.spring().delay(0.3)))
                .transition(.asymmetric(insertion: AnyTransition.opacity.animation(Animation.spring().delay(0.3)), removal:AnyTransition.opacity.animation(Animation.spring()) ))
                .edgesIgnoringSafeArea(.all)
            }
        }
        .onTapGesture {
            withAnimation(.spring()) {
                show.toggle()
            }
        }
    }
}

#Preview {
    CourseView()
}
