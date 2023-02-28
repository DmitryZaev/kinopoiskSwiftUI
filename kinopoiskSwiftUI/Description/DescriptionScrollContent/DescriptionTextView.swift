//
//  DescriptionTextView.swift
//  kinopoiskSwiftUI
//
//  Created by Dmitry Victorovich on 23.02.2023.
//

import SwiftUI

struct DescriptionTextView: View {
    
    let text: String
    
    var body: some View {
        HStack {
            Text(text)
                .font(.custom("Chalkboard SE", fixedSize: 20))
                .foregroundColor(Color("darkBlueColor"))
                .padding(.horizontal)
            
            Spacer()
        }
    }
}

//struct DescriptionTextView_Previews: PreviewProvider {
//    static var previews: some View {
//        DescriptionTextView()
//    }
//}
