//
//  CustomSectionView.swift
//  kinopoiskSwiftUI
//
//  Created by Dmitry Victorovich on 19.02.2023.
//

import SwiftUI

struct CustomSection<Content: View>: View {
    @Binding var shown : Bool
    @Binding var nothingForSearh : Bool
    
    let title: String
    private var content: Content
    
    init(shown: Binding<Bool>, nothingForSearch : Binding<Bool>, title: String, @ViewBuilder content: () -> Content) {
        _shown = shown
        _nothingForSearh = nothingForSearch
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    withAnimation(.default) {
                        shown.toggle()
                    }
                } label: {
                    if shown {
                        Image(systemName: "checkmark.square")
                            .resizable()
                    } else {
                        Image(systemName: "square")
                            .resizable()
                            .foregroundColor(nothingForSearh ? .red : Color("darkBlueColor"))
                            .scaleEffect(nothingForSearh ? 1.4 : 1)
                    }
                }
                .frame(width: 25, height: 25)
                Spacer().frame(width: 15)
                
                Text(title)
                    .font(.custom("Trebuchet MS", fixedSize: 25))
                    .onTapGesture {
                        withAnimation(.spring()) {
                            shown.toggle()
                        }
                    }
                Spacer()
            }
            .foregroundColor(Color("darkBlueColor"))
            
            if shown {
                content
                    .transition(.scale(scale: 0, anchor: .top).combined(with: .opacity))
            }
        }
        .padding()
    }
}
