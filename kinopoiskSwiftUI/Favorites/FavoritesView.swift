//
//  FavoritesView.swift
//  kinopoiskSwiftUI
//
//  Created by Dmitry Victorovich on 26.02.2023.
//

import SwiftUI
import RealmSwift

struct FavoritesView: View {
    @ObservedRealmObject var favorites: FavoritesMoviesGroup
    var viewModel : FavoritesViewModel
    
    var body: some View {
        if favorites.movies.isEmpty {
            GeometryReader { proxy in
                ScrollView {
                    Spacer(minLength: proxy.size.height / 2)
                    HStack {
                        Spacer()
                        Text(viewModel.emptyText)
                            .font(.custom("Trebuchet MS", fixedSize: 25))
                            .foregroundColor(Color("darkBlueColor"))
                        Spacer()
                    }
                }
            }
        } else {
            List {
                Spacer(minLength: 90)
                    .listRowBackground(Color.clear)
                    .listRowSeparatorTint(Color("darkBlueColor"))

                ForEach(0..<favorites.movies.count, id: \.self) { index in
                    GeometryReader { proxy in
                        HStack {
                            ImageFrom(imageUrlString: favorites.movies[index].imageUrlString,
                                      size: CGSize(width: proxy.size.height * 0.7,
                                                   height: proxy.size.height),
                                      mode: .fit)
                            .cornerRadius(10)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("blueColor"), lineWidth: 0.5)
                            }

                            VStack(alignment: .leading) {
                                Spacer().frame(height: 5)
                                HStack {
                                    Text(favorites.movies[index].name)
                                        .font(.custom("Chalkboard SE", fixedSize: 17))
                                        .foregroundColor(Color("darkBlueColor"))
                                        .lineLimit(2)
                                }
                                Spacer()
                                HStack {
                                    Spacer()
                                    Text(favorites.movies[index].genres)
                                        .font(.custom("Chalkboard SE", fixedSize: 15))
                                        .foregroundColor(Color("darkBlueColor"))
                                }
                                Spacer().frame(height: 5)
                            }
                            .padding(.horizontal)
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            viewModel.goToDescriptionWith(movieID: favorites.movies[index].movieID)
                        }
                    }
                    .frame(height: 100)
                    .listRowBackground(Color.clear)
                    .listRowSeparatorTint(Color("darkBlueColor"))
                    .swipeActions(edge: .trailing) {
                        Button {
                            $favorites.movies.remove(at:index)
                        } label: {
                            Image(systemName: "nosign")
                        }
                        .tint(.red)
                    }
                    
                }
                if favorites.movies.count > 5 {
                    Spacer(minLength: 100)
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
        }
    }
}


struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView(favorites: FavoritesMoviesGroup._rlmDefaultValue(), viewModel: FavoritesViewModel())
    }
}
