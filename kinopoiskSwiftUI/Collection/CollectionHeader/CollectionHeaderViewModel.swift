//
//  CollectionHeaderViewModel.swift
//  kinopoiskSwiftUI
//
//  Created by Dmitry Victorovich on 25.02.2023.
//

import Foundation

class CollectionHeaderViewModel : ObservableObject {
    @Published var headerOpacity : CGFloat = 0
    
    func calculateHeaderOpacityFrom(offset: CGFloat) {
        var newOpacity : CGFloat = 0
        if offset > 80 {
            newOpacity = 0.8
        } else if (0...80).contains(offset) {
            newOpacity = offset / 100
        }
        DispatchQueue.main.async { [weak self] in
            self?.headerOpacity = newOpacity
        }
    }
}
