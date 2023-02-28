//
//  DescriptionScrollView.swift
//  kinopoiskSwiftUI
//
//  Created by Dmitry Victorovich on 23.02.2023.
//

import SwiftUI

struct DescriptionScrollView: View {
    var favorites: FavoritesMoviesGroup
    @Binding var goToKinopoiskPressed: Bool
    @Binding var contentOffset : CGFloat
    
    let viewSize: CGSize
    
    let title: String
    let genres : String
    let descriptionText : String?
    let ratings : (kpRating: String,
                   imdbRating: String)
    let actors : [(name: String?,
                   englishName: String?,
                   imageUrlSrting: String)]
    let yearString: String
    let countries: String
    let movieID: Int
    let movieForSave: FavoriteMovie
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            let clearViewHeight = viewSize.height * 0.5 + 80 // 80 - высота козырька 
            let ratingsViewHeight = viewSize.height / 11
            Spacer(minLength: clearViewHeight - ratingsViewHeight - 50)
                .background {
                    GeometryReader { proxy in
                        let newOffset = proxy.frame(in: .named("descriptionScroll")).origin.y
                        Color.clear
                            .preference(
                                key: DescriptionScrollOffsetPreferenceKey.self,
                                value: newOffset
                            )
                    }
                }
//Рейтинги
            HStack {
                Spacer()
                RatingView(imageName: "kinopoiskLogo",
                           rating: ratings.kpRating)
                Spacer(minLength: viewSize.width / 2)
                RatingView(imageName: "imdbLogo",
                           rating: ratings.imdbRating)
                Spacer()
            }
            .frame(height: ratingsViewHeight)
            
            Spacer(minLength: 30)
            
            VStack {
                ZStack {
// Колпак скрола
                    ScrollViewCapShape(capHeight: 82)
                        .fill(LinearGradient(colors: [Color("lightBlueColor"),
                                                      Color("purpleColor"),
                                                      Color("purpleColor")],
                                             startPoint: .top,
                                             endPoint: .bottom))
                        .shadow(color: Color("blueColor"), radius: 20)
                    ScrollViewCapShape(capHeight: 82)
                        .stroke(Color("blueColor"), lineWidth: 1)
                    
                    VStack {
// Название
                        Spacer().frame(height: 10)
                        TitleView(title: title)
                        Spacer().frame(height: 20)
// Год, жанры, страны и кнопка в избранное
                        GenreYearFavoriteView(favorites: favorites,
                                              yearString: yearString,
                                              genres: genres,
                                              countries: countries,
                                              movieForSave: movieForSave)
                        Spacer().frame(height: 20)
// Актеры
                        if !actors.isEmpty {
                            ActorsScrollView(actors: actors,
                                             actorCellSize: CGSize(width: viewSize.height / 8,
                                                                   height: viewSize.height / 4))
                        }
// Описание
                        if let descriptionText {
                            DescriptionTextView(text: descriptionText)
                            Spacer().frame(height: 30)
                        }
                        
// Ссылка на сайт
                        ButtonGoToKinopoisk(pressed: $goToKinopoiskPressed)
                        
                        Spacer(minLength: 110)
                    }
                }
            }
            .frame(minHeight: viewSize.height * 0.4)
        }
        .coordinateSpace(name: "descriptionScroll")
        .onPreferenceChange(DescriptionScrollOffsetPreferenceKey.self) { offset in
            guard offset != 0 else { return }
            DispatchQueue.main.async {
                contentOffset = offset
            }
        }
    }
}

fileprivate struct DescriptionScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {}
}

private struct ScrollViewCapShape : Shape {
    
    let capHeight: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let curveShiftY = capHeight / 3
        let smallRadius = capHeight / 10
        
        var path = Path()
        
        path.move(to: CGPoint(x: rect.minX,
                              y: rect.maxY * 2))
        path.addLine(to: CGPoint(x: rect.minX,
                              y: rect.minY - smallRadius))
        path.addQuadCurve(to: CGPoint(x: rect.minX + smallRadius,
                                      y: rect.minY),
                          control: CGPoint(x: rect.minX,
                                           y: rect.minY))
        path.addQuadCurve(to: CGPoint(x: rect.maxX - smallRadius,
                                      y: rect.minY),
                          control: CGPoint(x: rect.midX,
                                           y: rect.minY - curveShiftY))
        path.addQuadCurve(to: CGPoint(x: rect.maxX,
                                      y: rect.minY - smallRadius),
                          control: CGPoint(x: rect.maxX,
                                           y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX,
                                 y: rect.maxY * 2))
        
        return path
    }
}

//struct DescriptionScrollView_Previews: PreviewProvider {
//    static var previews: some View {
//        DescriptionScrollView()
//    }
//}
