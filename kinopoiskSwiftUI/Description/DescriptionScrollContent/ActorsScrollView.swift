//
//  ActorsScrollView.swift
//  kinopoiskSwiftUI
//
//  Created by Dmitry Victorovich on 23.02.2023.
//

import SwiftUI

struct ActorsScrollView: View {
    
    let actors : [(name: String?,
                   englishName: String?,
                   imageUrlSrting: String)]
    let actorCellSize: CGSize
    
    var body: some View {
        ScrollView(.horizontal,  showsIndicators: false) {
            HStack(spacing: 15) {
                Spacer().frame(width: 0)
                ForEach(actors, id: \.name) { person in
                    ActorView(name: person.name,
                              englishName: person.englishName,
                              imageUrlString: person.imageUrlSrting)
                        .frame(width: actorCellSize.width,
                               height: actorCellSize.height)
                }
                Spacer().frame(width: 0)
            }
        }
    }
}

fileprivate struct ActorView: View {
    
    let name: String?
    let englishName: String?
    let imageUrlString: String
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                AsyncImage(url: URL(string: imageUrlString)) { phase in
                    switch phase {
                    case .failure(_):
                        makeDefaultImage(size: CGSize(width: proxy.size.width,
                                                      height: proxy.size.height * 0.75))
                            .opacity(0.5)
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(CGSize(width: proxy.size.width,
                                                height: proxy.size.height * 0.75),
                                         contentMode: .fit)
                            .ignoresSafeArea()
                    case.empty:
                        makeDefaultImage(size: CGSize(width: proxy.size.width,
                                                      height: proxy.size.height * 0.75))
                    @unknown default:
                        fatalError()
                    }
                }
                .cornerRadius(proxy.size.width / 5)
                
                Text(name ?? englishName ?? "")
                    .font(.custom("Trebuchet MS", fixedSize: proxy.size.width / 7))
                    .foregroundColor(Color("darkBlueColor"))
                    .multilineTextAlignment(.center)
            }
        }
    }
    
    @ViewBuilder func makeDefaultImage(size: CGSize) -> some View {
        Image("personPic")
            .resizable()
            .aspectRatio(size,
                         contentMode: .fit)
            .background(Color.gray)
            .opacity(0.5)
    }
}

//struct ActorsScrollView_Previews: PreviewProvider {
//    static var previews: some View {
//        ActorsScrollView()
//    }
//}
