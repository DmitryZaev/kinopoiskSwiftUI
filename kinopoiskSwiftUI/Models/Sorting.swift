//
//  Sorting.swift
//  kinopoiskSwiftUI
//
//  Created by Dmitry Victorovich on 25.02.2023.
//

import Foundation

enum Sorting: String, CaseIterable {
    case rating = "По рейтингу"
    case name   = "По алфавиту"
    case year   = "По году выхода"
    
    var sortField : String {
        switch self {
        case .rating: return "rating.kp"
        case .name:   return "name"
        case .year:   return "year"
        }
    }
    
    var sortType: String {
        switch self {
        case .rating: return "-1"
        case .name:   return "1"
        case .year:   return "-1"
        }
    }
}
