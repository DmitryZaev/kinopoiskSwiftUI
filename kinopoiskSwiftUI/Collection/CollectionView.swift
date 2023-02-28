//
//  CollectionView.swift
//  kinopoiskSwiftUI
//
//  Created by Dmitry Victorovich on 19.02.2023.
//

import SwiftUI

struct CollectionView: View {

    @StateObject var viewModel : CollectionViewModel
    
    private let columns: [GridItem] = [
        .init(.flexible()),
        .init(.flexible())
    ]
    
    var body: some View {
        if viewModel.isFindingNow {
            ProgressView()
                .tint(Color("darkBlueColor"))
                .scaleEffect(2)
        } else {
            GeometryReader { proxy in
                ScrollView(.vertical, showsIndicators: false) {
                    if viewModel.moviesArray.isEmpty {
                        Spacer(minLength: proxy.size.height / 2)
                        HStack() {
                            Spacer(minLength: 0)
                            Text(viewModel.errorText)
                                .font(.custom("Trebuchet MS", fixedSize: 25))
                                .foregroundColor(Color("darkBlueColor"))
                            Spacer(minLength: 0)
                        }
                        .ignoresSafeArea()
                    } else {
                        VStack {
                            LazyVGrid(columns: columns,
                                      alignment: .center,
                                      spacing: 20,
                                      pinnedViews: .sectionHeaders) {
                                CollectionSection(selectedMovie: $viewModel.selectedMovie,
                                                  title: viewModel.title,
                                                  movies: viewModel.moviesArray,
                                                  sectionWidth: proxy.size.width,
                                                  headerViewModel: viewModel.headerViewModel)
                                if viewModel.moviesArray.count > 4 {
                                    Spacer(minLength: 80)
                                }
                            }
                        }
                        .background {
                            GeometryReader { proxy in
                                Color.clear
                                    .preference(
                                        key: ScrollOffsetPreferenceKey.self,
                                        value: -proxy.frame(in: .named("scroll")).origin.y
                                    )
                            }
                        }
                    }
                }
                .coordinateSpace(name: "scroll")
                .onPreferenceChange(ScrollOffsetPreferenceKey.self) { offset in
                    DispatchQueue.global().async {
                        viewModel.headerViewModel.calculateHeaderOpacityFrom(offset: offset)
                    }
                }
            }
            .ignoresSafeArea()
            .onDisappear {
                viewModel.errorText = "Сначала надо что-то поискать"
            }
        }
    }
}

fileprivate struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {}
}


//struct CollectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        CollectionView(tabSelected: .constant(TabItem.collection),
//                       viewModel: CollectionViewModel())
//    }
//}
