//
//  SortingChoiceSegmentView.swift
//  kinopoiskSwiftUI
//
//  Created by Dmitry Victorovich on 25.02.2023.
//

import SwiftUI

struct SortingChoiceSegmentView: View {
    
    @Binding var sortingSelected: Sorting
    
    var body: some View {
        VStack {
            HStack {
                Text("Сортировка")
                    .font(.custom("Trebuchet MS", fixedSize: 25))
                    .foregroundColor(Color("darkBlueColor"))
                Spacer()
            }
            Picker("", selection: $sortingSelected) {
                ForEach(Sorting.allCases, id: \.rawValue) {
                    Text($0.rawValue)
                        .tag($0)
                }
            }
            .pickerStyle(.segmented)
            .onAppear {
                UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(named: "lightBlueColor")
                UISegmentedControl.appearance().setTitleTextAttributes([
                    .foregroundColor: UIColor(named: "darkBlueColor") ?? .clear,
                    .font: UIFont(name: "Trebuchet MS", size: 15) ?? .systemFont(ofSize: 15)]
                                                                       , for: .selected)
                UISegmentedControl.appearance().setTitleTextAttributes([
                    .foregroundColor: UIColor.gray,
                    .font: UIFont(name: "Trebuchet MS", size: 13) ?? .systemFont(ofSize: 12)]
                                                                       , for: .normal)
            }
        }
        .padding(.horizontal)
    }
}

//struct SortingChoiceSegmentView_Previews: PreviewProvider {
//    static var previews: some View {
//        SortingChoiceSegmentView()
//    }
//}
