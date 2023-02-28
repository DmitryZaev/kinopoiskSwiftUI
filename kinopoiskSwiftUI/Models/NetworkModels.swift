//
//  NetworkModels.swift
//  kinopoiskSwiftUI
//
//  Created by Dmitry Victorovich on 19.02.2023.
//

import Foundation

struct SiteAnswer: Codable {
    let docs: [MovieModel]
}

struct MovieModel: Codable {
    let poster:      PosterModel?
    let name:        String?
    let id:          Int?
}

struct PosterModel: Codable {
    let url: String?
}

struct Rating: Codable {
    let kp:   Double?
    let imdb: Double?
}

struct CurentMovieModel: Codable {
    let id:          Int
    let name:        String?
    let description: String?
    let year:        Int?
    let persons:     [PersonModel]?
    let genres:      [GenreModel]?
    let countries:   [CountryModel]?
    let poster:      PosterModel?
    let rating:      Rating?
}

struct GenreModel: Codable {
    let name: String?
}

struct CountryModel: Codable {
    let name: String?
}

struct PersonModel: Codable {
    let photo:        String?
    let name:         String?
    let enName:       String?
    let enProfession: String?
}

