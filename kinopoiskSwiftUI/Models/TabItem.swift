//
//  TabItem.swift
//  kinopoiskSwiftUI
//
//  Created by Dmitry Victorovich on 17.02.2023.
//

import Foundation

enum TabItem: String, CaseIterable {
    case search      = "Поиск"
    case collection  = "Результы поиска"
    case description = "Описание"
    case favorites   = "Избранное"
    
    var position: Int {
        switch self {
        case .search:      return 0
        case .collection:  return 1
        case .description: return 2
        case .favorites:   return 3
        }
    }
    var imageName: String {
        switch self {
        case .search:      return "searchPic"
        case .collection:  return "collectionPic"
        case .description: return "descriptionPic"
        case .favorites:   return "starPic"
        }
    }
    var rotation: Double {
        switch self {
        case .search:      return -6
        case .collection:  return -3
        case .description: return 3
        case .favorites:   return 6
        }
    }
    var offsetY: Int {
        switch self {
        case .search, .favorites:       return -6
        case .collection, .description: return -12
        }
    }
}
