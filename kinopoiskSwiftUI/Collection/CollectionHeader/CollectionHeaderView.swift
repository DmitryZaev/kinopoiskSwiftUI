//
//  CollectionHeaderView.swift
//  kinopoiskSwiftUI
//
//  Created by Dmitry Victorovich on 25.02.2023.
//

import SwiftUI

struct CollectionHeaderView : View {
    
    let title: String
    @StateObject var viewModel: CollectionHeaderViewModel
    
    var body: some View {
        ZStack {
            HeaderShape()
                .foregroundColor(Color("lightBlueColor"))
                .opacity(viewModel.headerOpacity)
            HeaderShape()
                .stroke(Color("blueColor"), lineWidth: 1)
                .opacity(viewModel.headerOpacity)
            VStack {
                Spacer(minLength: 110)
                Text(title)
                    .lineLimit(1)
                    .font(.custom("Trebuchet MS", fixedSize: 23))
                    .foregroundColor(Color("darkBlueColor"))
                    .padding(.horizontal, 2)
            }
        }
        .frame(height: 120)
    }
}

fileprivate struct HeaderShape: Shape {
    func path(in rect: CGRect) -> Path {
        let radius = rect.height / 5
        let shiftY = radius / 3

        var path = Path()

        path.move(to: CGPoint(x: rect.maxX,
                              y: rect.minY - rect.height * 5))
        path.addLine(to: CGPoint(x: rect.maxX,
                                 y: rect.maxY - radius))
        path.addQuadCurve(to: CGPoint(x: rect.maxX - radius,
                                      y: rect.maxY + shiftY),
                          control: CGPoint(x: rect.maxX,
                                           y: rect.maxY + shiftY))
        path.addLine(to: CGPoint(x: rect.minX + radius,
                                 y: rect.maxY + shiftY))
        path.addQuadCurve(to: CGPoint(x: rect.minX,
                                      y: rect.maxY - radius),
                          control: CGPoint(x: rect.minX,
                                           y: rect.maxY + shiftY))
        path.addLine(to: CGPoint(x: rect.minX,
                                 y: rect.minY - rect.height * 5))
        path.closeSubpath()
        return path
    }
}

//struct CollectionHeaderView_Previews: PreviewProvider {
//    static var previews: some View {
//        CollectionHeaderView()
//    }
//}
