//
//  SearchVeiw.swift
//  kinopoiskSwiftUI
//
//  Created by Dmitry Victorovich on 18.02.2023.
//

import SwiftUI

struct SearchVeiw: View {

    @StateObject var viewModel : SearchViewModel
    @FocusState var titleIsFocused : Bool
    
    var body: some View {
        ScrollView {
            Spacer(minLength: 100)
            
            NameChoiceView(text: $viewModel.name,
                           shown: $viewModel.titleShown,
                           nothingForSearch: $viewModel.nothingForSearh,
                           titleIsFocused: _titleIsFocused)
            
            YearsOrRatingPickersView(selectableMinValue: $viewModel.minYear,
                                     selectableMaxValue: $viewModel.maxYear,
                                     minValue: viewModel.minYearForChoice,
                                     maxValue: viewModel.maxYearForChoice,
                                     shown: $viewModel.yearsShown,
                                     nothingForSearch: $viewModel.nothingForSearh,
                                     title: "Годы выхода")
                .onTapGesture {
                    titleIsFocused = false
                }
            
            YearsOrRatingPickersView(selectableMinValue: $viewModel.minRating,
                                     selectableMaxValue: $viewModel.maxRating,
                                     minValue: viewModel.minRatingForChoice,
                                     maxValue: viewModel.maxRatingForChoice,
                                     shown: $viewModel.ratingShown,
                                     nothingForSearch: $viewModel.nothingForSearh,
                                     title: "Рейтинг на Кинопоиске")
                .offset(y: viewModel.yearsShown ? -20 : 0)
                .onTapGesture {
                    titleIsFocused = false
                }
            
            SortingChoiceSegmentView(sortingSelected: $viewModel.sorting)
                .offset(y: viewModel.yearsShown ? -20 : 0)
                .offset(y: viewModel.ratingShown ? -10 : 0)
            
            Spacer().frame(height: 30)

            SearchButtonView(didPressed: $viewModel.buttonDidPressed,
                             titleShown: viewModel.titleShown,
                             yearsShown: viewModel.yearsShown,
                             ratingShown: viewModel.ratingShown)
                .offset(y: viewModel.yearsShown ? -20 : 0)
                .offset(y: viewModel.ratingShown ? -10 : 0)
                .offset(x: CGFloat(viewModel.buttonOffsetX))
        }
        .scrollDismissesKeyboard(.immediately)
    }
}

//struct SearchVeiw_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchVeiw(tabSelected: .constant(.search), viewModel: SearchViewModel(selectedTab: .constant(.search)))
//    }
//}
