//
//  CollectionSectionView.swift
//  kinopoiskSwiftUI
//
//  Created by Dmitry Victorovich on 21.02.2023.
//

import SwiftUI

struct CollectionSection: View {
    
    @Binding var selectedMovie : Int?
    
    let title : String
    let movies : [(name: String?,
                   imageUrlString: String,
                   id: Int?)]
    
    let sectionWidth: CGFloat
    private var cellWidth: CGFloat {
        return sectionWidth / 2 - 20
    }
    
    let headerViewModel : CollectionHeaderViewModel
    
    var body: some View {
        
        Section(content: {
                ForEach(0...(movies.count - 1), id: \.self) { item in
                    GeometryReader { proxy in
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color("darkBlueColor"), lineWidth: 2)
                                .background(.thinMaterial)
                                .cornerRadius(15)
                            
                            VStack(alignment: .center ) {
                                GeometryReader { pictureProxy in
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 13)
                                            .stroke(Color("darkBlueColor"), lineWidth: 1)
                                        
                                        ImageFrom(imageUrlString: movies[item].imageUrlString,
                                                  size: pictureProxy.size,
                                                  mode: .fill)
                                        .cornerRadius(13)
                                    }
                                }
                                .frame(height: cellWidth * 1.3)
                                .padding(.top, 10)
                                
                                Spacer()
                                
                                Text(movies[item].name ?? "Неизвестно")
                                    .font(.custom("Trebuchet MS", fixedSize: 18))
                                    .foregroundColor(Color("darkBlueColor"))
                                
                                Spacer()
                            }
                            .padding(.horizontal, 10)
                        }
                        .onTapGesture {
                            withAnimation(.default) {
                                selectedMovie = item
                            }
                        }
                    }
                    .frame(width: cellWidth,
                           height:  cellWidth * 1.7)
            }
        }, header: {
            CollectionHeaderView(title: title,
                                 viewModel: headerViewModel)
        })
    }
}



