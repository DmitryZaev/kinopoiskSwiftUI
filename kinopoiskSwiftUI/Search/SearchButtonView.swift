//
//  SearchButtonView.swift
//  kinopoiskSwiftUI
//
//  Created by Dmitry Victorovich on 25.02.2023.
//

import SwiftUI

struct SearchButtonView: View {
    
    @Binding var didPressed: Bool
    let titleShown : Bool
    let yearsShown : Bool
    let ratingShown : Bool
    
    var body: some View {
        Button {
            didPressed.toggle()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .frame(width: 150,
                           height: 50)
                    .tint(titleShown || yearsShown || ratingShown
                          ?
                          LinearGradient(colors: [Color("lightGreenColor"),
                                                  Color("greenColor"),
                                                  Color("lightGreenColor")],
                                         startPoint: .topLeading,
                                         endPoint: .bottomTrailing)
                          :
                            LinearGradient(colors: [Color(uiColor: .lightGray)],
                                           startPoint: .top,
                                           endPoint: .bottom))
                    .shadow(color: Color("lightBlueColor"), radius: 10)
                    .opacity(0.6)
                
                Text("Искать")
                    .font(.custom("Trebuchet MS", fixedSize: 25))
                    .foregroundColor(titleShown || yearsShown || ratingShown ? .blue : .gray)
            }
        }
    }
}

//struct SearchButtonView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchButtonView()
//    }
//}
