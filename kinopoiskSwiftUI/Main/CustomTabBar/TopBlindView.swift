//
//  TopBlindView.swift
//  kinopoiskSwiftUI
//
//  Created by Dmitry Victorovich on 18.02.2023.
//

import SwiftUI

struct TopBlindView: View {
    
    let title : String
    
    var body: some View {
        ZStack {
            TopBlindShape()
                .foregroundStyle(LinearGradient(colors: [Color("blueColor"),
                                                         Color("lightBlueColor")],
                                                 startPoint: .top,
                                                 endPoint: .bottom))
                .shadow(color: Color("blueColor"), radius: 20)
            TopBlindShape()
                .stroke(Color("blueColor"),
                        lineWidth: 1)
            VStack {
                Spacer()
                Text(title)
                    .font(.custom("Chalkboard SE", fixedSize: 30))
                    .foregroundColor(Color("darkBlueColor"))
            }
        }
    }
}

fileprivate struct TopBlindShape: Shape {
    func path(in rect: CGRect) -> Path {
        let curveShiftY = rect.height / 3
        let smallRadius = rect.height / 10
        
        var path = Path()
        
        path.move(to: CGPoint(x: rect.minX,
                              y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX,
                                 y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX,
                                 y: rect.maxY + smallRadius))
        path.addQuadCurve(to: CGPoint(x: rect.maxX - smallRadius,
                                      y: rect.maxY),
                          control: CGPoint(x: rect.maxX,
                                           y: rect.maxY))
        path.addQuadCurve(to: CGPoint(x: rect.minX + smallRadius,
                                      y: rect.maxY),
                          control: CGPoint(x: rect.midX,
                                           y: rect.maxY + curveShiftY))
        path.addQuadCurve(to: CGPoint(x: rect.minX,
                                      y: rect.maxY + smallRadius),
                          control: CGPoint(x: rect.minX,
                                           y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

