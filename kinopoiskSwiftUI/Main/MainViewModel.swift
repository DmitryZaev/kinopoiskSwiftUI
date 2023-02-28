//
//  MainViewModel.swift
//  kinopoiskSwiftUI
//
//  Created by Dmitry Victorovich on 20.02.2023.
//

import Foundation
import Combine

class MainViewModel: ObservableObject {
    @Published var selectedTab: TabItem?
    let searhViewModel:        SearchViewModel
    let collectionViewModel:   CollectionViewModel
    let descriptionViewModel:  DescriptionViewModel
    let favoritesViewModel:    FavoritesViewModel
    let customTabBarViewModel: CustomTabBarViewModel
    
    private let  networkMatager : NetworkManager
    
    private var anyCancellable: Set<AnyCancellable> = []
    
    init() {
        searhViewModel = SearchViewModel()
        collectionViewModel = CollectionViewModel()
        descriptionViewModel = DescriptionViewModel()
        customTabBarViewModel = CustomTabBarViewModel()
        favoritesViewModel = FavoritesViewModel()
        
        networkMatager = NetworkManager()
        
        searhViewModel.collectionViewModel = collectionViewModel
        collectionViewModel.descriptionViewModel = descriptionViewModel
        favoritesViewModel.descriptionViewModel = descriptionViewModel
        
        collectionViewModel.networkManager = networkMatager
        descriptionViewModel.networkManager = networkMatager
        
        
        searhViewModel.$selectedTab
            .assign(to: &customTabBarViewModel.$selectedTab)
        collectionViewModel.$tabSelected
            .assign(to: &customTabBarViewModel.$selectedTab)
        favoritesViewModel.$tabSelected
            .assign(to: &customTabBarViewModel.$selectedTab)
        
        customTabBarViewModel.selectedTab = .search
        customTabBarViewModel.$selectedTab
            .assign(to: &$selectedTab)
    }
}
