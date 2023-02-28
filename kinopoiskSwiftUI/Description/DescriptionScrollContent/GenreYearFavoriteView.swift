//
//  GenreYearFavoriteView.swift
//  kinopoiskSwiftUI
//
//  Created by Dmitry Victorovich on 23.02.2023.
//

import SwiftUI
import RealmSwift

struct GenreYearFavoriteView: View {
    @ObservedRealmObject var favorites: FavoritesMoviesGroup
    let yearString: String
    let genres: String
    let countries: String
    let movieForSave : FavoriteMovie
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                if !genres.isEmpty {
                    Text(genres)
                        .font(.custom("Chalkboard SE", fixedSize: 17))
                        .foregroundColor(Color("darkBlueColor"))
                    Spacer().frame(height: 10)
                }
                
                Text(yearString)
                    .font(.custom("Chalkboard SE", fixedSize: 17))
                    .foregroundColor(Color("darkBlueColor"))
                
                if !countries.isEmpty {
                    Spacer().frame(height: 10)
                    Text(countries)
                        .font(.custom("Chalkboard SE", fixedSize: 17))
                        .foregroundColor(Color("darkBlueColor"))
                }
            }
            
            Spacer()
            
            Button {
                $favorites.movies.append(movieForSave)
            } label: {
                HStack {
                    Text("В избранное")
                        .font(.custom("Chalkboard SE", fixedSize: 17))
                        .padding(.leading)
                    
                    Image("starPic")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding(.trailing)
                }
                .frame(height: 40)
                .background(.thickMaterial.opacity(0.5))
                .cornerRadius(15)
            }
            .disabled(favorites.movies.contains(where: { movie in
                movie.movieID == movieForSave.movieID
            }))
        }
        .padding(.horizontal)
    }
}

//struct GenreYearFavoriteView_Previews: PreviewProvider {
//    static var previews: some View {
//        GenreYearFavoriteView()
//    }
//}
