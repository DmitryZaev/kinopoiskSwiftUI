//
//  ImageFrom.swift
//  kinopoiskSwiftUI
//
//  Created by Dmitry Victorovich on 21.02.2023.
//

import SwiftUI

struct ImageFrom: View {
    let imageUrlString: String
    let size: CGSize
    let mode: ContentMode
    
    var body: some View {
        if let url = URL(string: imageUrlString) {
            AsyncImage(url: url) { phase in
                switch phase {
                case .failure(_):
                    Image("noImage")
                        .resizable()
                        .aspectRatio(size, contentMode: mode)
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(size, contentMode: mode)
                        .ignoresSafeArea()
                case.empty:
                    ProgressView()
                        .tint(Color("blueColor"))
                @unknown default:
                    fatalError()
                }
            }
        } else {
            Image("noImage")
                .resizable()
                .aspectRatio(size, contentMode: mode)
        }
    }
}
