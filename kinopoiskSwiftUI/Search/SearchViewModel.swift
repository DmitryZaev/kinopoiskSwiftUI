//
//  SearchViewModel.swift
//  kinopoiskSwiftUI
//
//  Created by Dmitry Victorovich on 19.02.2023.
//

import Foundation
import Combine
import SwiftUI

class SearchViewModel: ObservableObject {
    @Published var selectedTab: TabItem?
    
    @Published var name = ""
    @Published var minYear = 2000
    @Published var maxYear : Int
    @Published var minRating = 5
    @Published var maxRating = 10
    
    @Published var titleShown = true
    @Published var yearsShown = false
    @Published var ratingShown = false
    
    @Published var nothingForSearh = false
    
    @Published var buttonOffsetX = 0
    
    var sorting : Sorting = .rating
    
    var collectionViewModel : CollectionViewModel?
    
    let minYearForChoice = 1881
    var maxYearForChoice : Int
    let minRatingForChoice = 0
    let maxRatingForChoice = 10
    let buttonOffsetsX = [-10, 10, 0]
    
    var buttonDidPressed = false {
        didSet {
            checkBoxes { readyToGo in
                if readyToGo {
                    withAnimation(.default) {
                        selectedTab = .collection
                    }
                }
            }
        }
    }
    
    var cancellable: Set<AnyCancellable> = []
    
    init() {
        self.maxYear = Calendar.current.component(.year, from: Date())
        self.maxYearForChoice = Calendar.current.component(.year, from: Date())
    }
    
    private func checkBoxes(completion: (Bool) -> Void) {
        if !titleShown && !yearsShown && !ratingShown {
            
            [true, false, true, false].publisher
                .flatMap(maxPublishers: .max(1)) {
                    Just($0)
                        .delay(for: 0.15, scheduler: RunLoop.main)
                }
                .sink { value in
                    withAnimation(.linear(duration: 0.15)) {
                        self.nothingForSearh = value
                    }
                }
                .store(in: &cancellable)
            
            buttonOffsetsX.publisher
                .flatMap(maxPublishers: .max(1)) {
                    Just($0)
                        .delay(for: 0.1, scheduler: RunLoop.main)
                }
                .sink { value in
                    withAnimation(.linear(duration: 0.1)) {
                        self.buttonOffsetX = value
                    }
                }
                .store(in: &cancellable)
            completion(false)
        } else {
            sendDataToCollection()
            completion(true)
        }
    }
    
    private func sendDataToCollection () {
        if titleShown {
            if name.isEmpty {
                collectionViewModel?.name = ""
                collectionViewModel?.title = "Любой"
            } else {
                collectionViewModel?.name = name
                collectionViewModel?.title = "\"\(name)\""
            }
        } else {
            collectionViewModel?.name = ""
            collectionViewModel?.title = "Любой"
        }
        
        if yearsShown {
            collectionViewModel?.years = String.init(describing: minYear) + "-" + String.init(describing: maxYear)
            guard let years = collectionViewModel?.years else { return }
            collectionViewModel?.title += ", \(years)гг"
        }
        
        if ratingShown {
            collectionViewModel?.rating = String.init(describing: minRating) + "-" + String.init(describing: maxRating)
            guard let rating = collectionViewModel?.rating else { return }
            collectionViewModel?.title += ", рейтинг \(rating)"
        }
        collectionViewModel?.findMovies(sorting: sorting)
    }
}
