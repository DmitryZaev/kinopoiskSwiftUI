//
//  TitleView.swift
//  kinopoiskSwiftUI
//
//  Created by Dmitry Victorovich on 23.02.2023.
//

import SwiftUI

struct TitleView: View {
    
    let title: String
    
    var body: some View {
        Text(title)
            .font(.custom("Chalkboard SE", fixedSize: 30))
            .bold()
            .kerning(2)
            .foregroundColor(Color("darkBlueColor"))
            .multilineTextAlignment(.center)
            .shadow(radius: 5)
            .padding(.horizontal)
    }
}

//struct TitleView_Previews: PreviewProvider {
//    static var previews: some View {
//        TitleView()
//    }
//}
