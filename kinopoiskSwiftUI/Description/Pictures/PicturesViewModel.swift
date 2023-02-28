//
//  PicturesViewModel.swift
//  kinopoiskSwiftUI
//
//  Created by Dmitry Victorovich on 25.02.2023.
//

import Foundation

class PicturesViewModel: ObservableObject {
    @Published var scale: CGFloat = 0
    @Published var imageHeightShift: CGFloat = 0
    
    var minimalOffset: CGFloat = 0
    
    func calculateImagesHeightShift(scrollOffset: CGFloat) {
        if scrollOffset > minimalOffset {
            self.imageHeightShift = scrollOffset
        }
    }
}
