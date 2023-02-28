//
//  DescriptionView.swift
//  kinopoiskSwiftUI
//
//  Created by Dmitry Victorovich on 21.02.2023.
//

import SwiftUI

struct DescriptionView: View {
    var favorites: FavoritesMoviesGroup
    @StateObject var viewModel: DescriptionViewModel
    
    var body: some View {
            switch viewModel.dataIsLoading {
            case true:
                ProgressView()
                    .tint(Color("darkBlueColor"))
                    .scaleEffect(2)
            case false:
                GeometryReader { proxy in
                if viewModel.movieID != 0 {
                    PicturesView(imageUrlString: viewModel.pictureUrlString,
                                 viewHeight: proxy.size.height,
                                 viewModel: viewModel.picturesViewModel)
                    
                    DescriptionScrollView(favorites: favorites,
                                          goToKinopoiskPressed: $viewModel.goToKinopoiskPressed,
                                          contentOffset: $viewModel.scrollOffsetedFor,
                                          viewSize: proxy.size,
                                          title: viewModel.title,
                                          genres: viewModel.genres,
                                          descriptionText: viewModel.descriptionText,
                                          ratings: viewModel.ratings,
                                          actors: viewModel.actors,
                                          yearString: viewModel.yearString,
                                          countries: viewModel.countries,
                                          movieID: viewModel.movieID,
                                          movieForSave: viewModel.movieForSave)
                    .onAppear {
                        viewModel.picturesViewModel.minimalOffset = -proxy.size.height / 2
                    }
                    .onDisappear {
                        viewModel.createNewMovieForSave()
                        viewModel.scrollOffsetedFor = 0
                    }
                } else {
                    ScrollView(.vertical, showsIndicators: false) {
                        Spacer(minLength: proxy.size.height / 2)
                        HStack() {
                            Spacer(minLength: 0)
                            Text(viewModel.errorText)
                                .font(.custom("Trebuchet MS", fixedSize: 25))
                                .foregroundColor(Color("darkBlueColor"))
                            Spacer(minLength: 0)
                        }
                    }
                }
            }
            .ignoresSafeArea()
        }
    }
}

struct DescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        DescriptionView(favorites: FavoritesMoviesGroup(), viewModel: DescriptionViewModel())
    }
}
