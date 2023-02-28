//
//  RatingView.swift
//  kinopoiskSwiftUI
//
//  Created by Dmitry Victorovich on 23.02.2023.
//

import SwiftUI

struct RatingView: View {
    let imageName: String
    let rating: String
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                
                Image(imageName)
                    .resizable()
                    .frame(height: proxy.size.height * 0.6)
                    .cornerRadius(10)
                    .padding(.top, 5)
                    .padding(.horizontal, 5)
                
                Spacer().frame(height: 0)
                
                Text("\(rating)/10")
                    .font(.custom("Chalkboard SE", fixedSize: proxy.size.height / 4))
                    .bold()
                    .foregroundColor(Color("darkBlueColor"))
                }
            
        }
        .background(.thickMaterial.opacity(0.8))
        .cornerRadius(15)
    }

}

//struct RatingView_Previews: PreviewProvider {
//    static var previews: some View {
//        RatingView()
//    }
//}
