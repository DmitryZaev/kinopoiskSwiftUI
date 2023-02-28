//
//  NameChoiceView.swift
//  kinopoiskSwiftUI
//
//  Created by Dmitry Victorovich on 25.02.2023.
//

import SwiftUI

struct NameChoiceView: View {
    @Binding var text: String
    @Binding var shown: Bool
    @Binding var nothingForSearch: Bool
    @FocusState var titleIsFocused : Bool
    
    var body: some View {
        CustomSection(shown: $shown,
                      nothingForSearch: $nothingForSearch,
                      title: "Название") {
            ZStack {
                SectionBackView(height: 50)
                
                TextField("Введите название или его часть",
                          text: $text)
                .frame(height: 50)
                .font(.custom("Trebuchet MS", fixedSize: 20))
                .foregroundColor(Color("darkBlueColor"))
                .autocorrectionDisabled()
                .focused($titleIsFocused)
                .padding(.horizontal)
            }
        }
    }
}

//struct NameChoiceView_Previews: PreviewProvider {
//    static var previews: some View {
//        NameChoiceView(text: .constant("sdfsdf"))
//    }
//}
