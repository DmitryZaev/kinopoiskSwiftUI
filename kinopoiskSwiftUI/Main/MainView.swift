//
//  MainView.swift
//  kinopoiskSwiftUI
//
//  Created by Dmitry Victorovich on 16.02.2023.
//

import SwiftUI
import RealmSwift

struct MainView: View {
    
    @StateObject private var mainViewModel = MainViewModel()
    @ObservedResults(FavoritesMoviesGroup.self) private var favoritesGroups
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color("lightOrangeColor"),
                                    Color("purpleColor")],
                           startPoint: .top,
                           endPoint: .bottom)
            
            if let selected = mainViewModel.selectedTab {
                CustomTabBarView(viewModel: mainViewModel.customTabBarViewModel) {
                    switch selected {
                    case .search:
                        SearchVeiw(viewModel: mainViewModel.searhViewModel)
                    case .collection:
                        CollectionView(viewModel: mainViewModel.collectionViewModel)
                    case .description:
                        if let favoriteGroup = favoritesGroups.first {
                            DescriptionView(favorites: favoriteGroup,
                                            viewModel: mainViewModel.descriptionViewModel)
                        }
                    case .favorites:
                        if let favoriteGroup = favoritesGroups.first {
                            FavoritesView(favorites: favoriteGroup,
                                          viewModel: mainViewModel.favoritesViewModel)
                        } 
                    }
                }
                .onAppear {
                    if favoritesGroups.first == nil {
                        $favoritesGroups.append(FavoritesMoviesGroup())
                    }
                }
            }
        }
        .ignoresSafeArea()
    }
}



//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView(mainViewModel: MainViewModel(selectedTab: .constant(.search)))
//    }
//}
