//
//  FavoritesViewModel.swift
//  kinopoiskSwiftUI
//
//  Created by Dmitry Victorovich on 26.02.2023.
//

import Foundation
import SwiftUI

class FavoritesViewModel {
    @Published var tabSelected: TabItem?
    let emptyText = "Тут ничего нет 🤷‍♂️"
    
    var descriptionViewModel : DescriptionViewModel?
    
    func goToDescriptionWith(movieID: Int) {
        descriptionViewModel?.prepareToShow(movieId: movieID)
        withAnimation(.default) {
            tabSelected = .description
        }
    }
}
