//
//  CollectionViewModel.swift
//  kinopoiskSwiftUI
//
//  Created by Dmitry Victorovich on 21.02.2023.
//

import Foundation
import SwiftUI
import Combine

class CollectionViewModel: ObservableObject {
    @Published var tabSelected: TabItem?
    @Published var isFindingNow = false
    
    var networkManager: NetworkManager?
    var descriptionViewModel : DescriptionViewModel?
    let headerViewModel = CollectionHeaderViewModel()
    
    var moviesArray : [(name: String?,
                        imageUrlString: String,
                        id: Int?)] = []
    var errorText = "Сначала надо что-то поискать"
    
    var selectedMovie : Int? {
        didSet {
            guard let selectedMovie else { return }
            sendToDescriptionView(movieId: moviesArray[selectedMovie].id)
            withAnimation(.default) {
                tabSelected = .description
            }
        }
    }
    
    var title = ""
    
    var name: String?
    var years: String?
    var rating: String?
    
    private var anyCancellable : Set<AnyCancellable> = []
    
    func findMovies(sorting: Sorting) {
        isFindingNow = true
        networkManager?.fetchMovie(name: name,
                                   years: years,
                                   rating: rating,
                                   sorting: sorting,
                                   movieId: nil)
        .map { $0 as SiteAnswer }
        .receive(on: RunLoop.main)
        .sink(receiveCompletion: { [unowned self] completion in
            switch completion {
            case .failure(let error):
                print(error.localizedDescription)
                errorText = "Что-то пошло не так"
            case .finished:
                print("data OK")
            }
            isFindingNow = false
        }, receiveValue: { [unowned self] answer in
            
            if answer.docs.isEmpty {
                errorText = "Ничего такого не нашлось"
            } else {
                moviesArray.removeAll()
                answer.docs.forEach { model in
                    moviesArray.append((name: model.name,
                                        imageUrlString: model.poster?.url ?? "",
                                        id: model.id))
                }
            }
        })
        .store(in: &anyCancellable)
    }
    
    func sendToDescriptionView(movieId: Int?) {
        guard let movieId else { return }
        descriptionViewModel?.prepareToShow(movieId: movieId)
    }
}
