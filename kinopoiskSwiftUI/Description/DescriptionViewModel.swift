//
//  DescriptionViewModel.swift
//  kinopoiskSwiftUI
//
//  Created by Dmitry Victorovich on 22.02.2023.
//

import Foundation
import Combine

class DescriptionViewModel: ObservableObject {
    @Published var dataIsLoading = false
    
    var title = ""
    var pictureUrlString = ""
    var genres = ""
    var descriptionText : String?
    var ratings : (kpRating: String,
                   imdbRating: String) = ("", "")
    var actors : [(name: String?,
                   englishName: String?,
                   imageUrlSrting: String)] = []
    var yearString = ""
    var countries = ""
    var movieID: Int = 0
    
    var errorText = "Сначала надо выбрать фильм"
    
    var networkManager : NetworkManager?
    let picturesViewModel = PicturesViewModel()
    
    private var anyCancellable : Set<AnyCancellable> = []
    
    var scrollOffsetedFor : CGFloat = 0 {
        didSet {
            picturesViewModel.calculateImagesHeightShift(scrollOffset: scrollOffsetedFor)
        }
    }
    
    var movieForSave = FavoriteMovie()
    
    var goToKinopoiskPressed = false {
        didSet {
            guard goToKinopoiskPressed else { return }
            goToKinopoisk()
        }
    }
    
    func prepareToShow(movieId: Int) {
        guard movieId != self.movieID else { return }
        dataIsLoading = true
        networkManager?.fetchMovie(name: nil,
                                   years: nil,
                                   rating: nil,
                                   sorting: nil,
                                   movieId: movieId)
        .map { $0 as CurentMovieModel }
        .receive(on: RunLoop.main)
        .sink(receiveCompletion: { [unowned self] completion in
            switch completion {
            case .failure(let error):
                print(error.localizedDescription)
                errorText = "Что-то пошло не так"
                movieID = 0
            case .finished:
                print("movie OK")
            }
            dataIsLoading = false
        }, receiveValue: { [unowned self] answer in
            title = answer.name ?? "Нет названия"
            
            pictureUrlString = answer.poster?.url ?? ""
            
            var genresArray = [String]()
            answer.genres?.forEach{ genre in
                if let genreName = genre.name {
                    genresArray.append(genreName)
                }
            }
            genres = genresArray.joined(separator: ", ")
            
            var countriesArray = [String]()
            answer.countries?.forEach{ country in
                if let countryName = country.name {
                    countriesArray.append(countryName)
                }
            }
            countries = countriesArray.joined(separator: ", ")
            
            descriptionText = answer.description
            
            ratings.kpRating = String(format: "%.1f", answer.rating?.kp ?? 0.0)
            ratings.imdbRating = String(format: "%.1f", answer.rating?.imdb ?? 0.0)
            
            actors.removeAll()
            answer.persons?.filter { $0.enProfession == "actor" }
                .forEach { person in
                    actors.append((name: person.name,
                                   englishName: person.enName,
                                   imageUrlSrting: person.photo ?? ""))
                }
            
            getYearString(year: answer.year)
            
            movieID = answer.id
            createNewMovieForSave()
        })
        .store(in: &anyCancellable)
    }
    
    func createNewMovieForSave() {
        movieForSave = FavoriteMovie()
        movieForSave.name = title
        movieForSave.imageUrlString = pictureUrlString
        movieForSave.genres = genres
        movieForSave.movieID = movieID
    }
    
    private func getYearString(year: Int?) {
        yearString.removeAll()
        yearString = "Год выхода"
        if let year {
            yearString += ": \(String.init(describing: year))"
        } else {
            yearString += " неизвестен"
        }
    }
    
    private func goToKinopoisk() {
        networkManager?.openInKinopoisk(id: movieID)
    }
}
