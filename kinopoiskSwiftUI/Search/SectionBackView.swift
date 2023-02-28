//
//  SectionBackView.swift
//  kinopoiskSwiftUI
//
//  Created by Dmitry Victorovich on 25.02.2023.
//

import SwiftUI

struct SectionBackView: View {
    
    let height: CGFloat
    
    var body: some View {
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color("darkBlueColor"), lineWidth: 2)
                .frame(height: height)
                .frame(maxWidth: .infinity)
                .background(.thinMaterial)
                .cornerRadius(15)
                .opacity(0.6)
    }
}

struct SectionBackView_Previews: PreviewProvider {
    static var previews: some View {
        SectionBackView(height: 50)
    }
}
