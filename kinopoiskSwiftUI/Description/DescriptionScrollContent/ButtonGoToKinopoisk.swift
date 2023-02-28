//
//  ButtonGoToKinopoisk.swift
//  kinopoiskSwiftUI
//
//  Created by Dmitry Victorovich on 23.02.2023.
//

import SwiftUI

struct ButtonGoToKinopoisk: View {
    
    @Binding var pressed: Bool
    
    var body: some View {
        Button {
            pressed = true
        } label: {
            Text("Открыть в Кинопоиск   ")
                .font(.custom("Chalkboard SE", fixedSize: 20))
                .frame(height: 40)
                .background(LinearGradient(colors: [Color("darkOrangeColor"),
                                                    Color("lightOrangeColor"),
                                                    Color("darkOrangeColor")],
                                           startPoint: .topLeading,
                                           endPoint: .bottomTrailing))
                .cornerRadius(15)
                .shadow(radius: 5)
        }
    }
}

//struct ButtonGoToKinopoisk_Previews: PreviewProvider {
//    static var previews: some View {
//        ButtonGoToKinopoisk()
//    }
//}
