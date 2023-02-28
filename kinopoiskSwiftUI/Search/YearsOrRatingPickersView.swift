//
//  YearsOrRatingPickersView.swift
//  kinopoiskSwiftUI
//
//  Created by Dmitry Victorovich on 25.02.2023.
//

import SwiftUI

struct YearsOrRatingPickersView: View {
    
    @Binding var selectableMinValue: Int
    @Binding var selectableMaxValue: Int
    let minValue: Int
    let maxValue: Int
    @Binding var shown: Bool
    @Binding var nothingForSearch: Bool
    let title: String
    
    var body: some View {
        CustomSection(shown: $shown,
                      nothingForSearch: $nothingForSearch,
                      title: title) {
            HStack {
                LeftOrRightPicker(selectableValue: $selectableMinValue,
                                  min: minValue,
                                  max: selectableMaxValue)
                Text("-")
                    .frame(height: 50)
                    .font(.title)
                    .foregroundColor(Color("darkBlueColor"))
                LeftOrRightPicker(selectableValue: $selectableMaxValue,
                                  min: selectableMinValue,
                                  max: maxValue)
            }
            .offset(y: -10)
        }
    }
    
    @ViewBuilder private func LeftOrRightPicker(selectableValue: Binding<Int>, min: Int, max: Int) -> some View {
        ZStack {
            SectionBackView(height: 80)
            
            Picker("", selection: selectableValue) {
                ForEach(min...max, id:  \.self) { item in
                    Text(String.init(describing: item))
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .font(.custom("Trebuchet MS", fixedSize: 20))
                        .foregroundColor(Color("darkBlueColor"))
                }
            }
            .pickerStyle(.wheel)
            .frame(height: 100)
        }
    }
}

//struct YearsOrRatingPickersView_Previews: PreviewProvider {
//    static var previews: some View {
//        YearsOrRatingPickersView()
//    }
//}
