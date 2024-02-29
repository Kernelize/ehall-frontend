//
//  Blob.swift
//  Ehall
//
//  Created by Hank Hogan on 2024/2/24.
//

import SwiftUI

struct Blob: View {
    
    //MARK: Internal Constant
    
    struct InternalConstant {
        static let gradient = Gradient(colors: [.pink, .blue])
    }
    
    //MARK: Properties
    
    @State private var appear: Bool = false
    
    var body: some View {
        TimelineView(.animation) { timeline in
            let now = timeline.date.timeIntervalSinceReferenceDate
            let angle = Angle.degrees(now.remainder(dividingBy: 3) * 60)
            let firstSet = cos(angle.radians)
            let angle2 = Angle.degrees(now.remainder(dividingBy: 6) * 10)
            let secondSet = cos(angle2.radians)
            
            Canvas { context, size in
                context.fill(path(in: CGRect(x: 0, y: 0, width: size.width, height: size.height),
                                  firstSet: firstSet, secondSet: secondSet),
                             with: .linearGradient(InternalConstant.gradient,
                                                   startPoint: CGPoint(x: 0, y: 0),
                                                   endPoint: CGPoint(x: size.width, y: size.height)))
            }
            .frame(width: 400, height: 420)
            .rotationEffect(.degrees(appear ? 360 : 0))
            .animation(.linear(duration: 20).repeatForever(autoreverses: false), value: appear)
        }
        .onAppear {
            appear = true
        }
    }
    
    //MARK: Private Methotds
    
    private func path(in rect: CGRect, firstSet: Double, secondSet: Double) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.9923*width, y: 0.42593*height))
        path.addCurve(to: CGPoint(x: 0.6355*width * secondSet, y: height),
                      control1: CGPoint(x: 0.92554*width * secondSet, y: 0.77749*height * secondSet),
                      control2: CGPoint(x: 0.91864*width * secondSet, y: height))
        path.addCurve(to: CGPoint(x: 0.08995*width, y: 0.60171*height),
                      control1: CGPoint(x: 0.35237*width * firstSet, y: height),
                      control2: CGPoint(x: 0.2695*width, y: 0.77304*height))
        path.addCurve(to: CGPoint(x: 0.34086*width, y: 0.06324*height * firstSet),
                      control1: CGPoint(x: -0.0896*width, y: 0.43038*height),
                      control2: CGPoint(x: 0.00248*width, y: 0.23012*height * firstSet))
        path.addCurve(to: CGPoint(x: 0.9923*width, y: 0.42593*height),
                      control1: CGPoint(x: 0.67924*width, y: -0.10364*height * firstSet),
                      control2: CGPoint(x: 1.05906*width, y: 0.07436*height * secondSet))
        path.closeSubpath()
        return path
    }
}

//MARK: - PreviewProvider

struct BlobView_Previews: PreviewProvider {
    static var previews: some View {
        Blob()
    }
}
