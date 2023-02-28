//
//  PicturesView.swift
//  kinopoiskSwiftUI
//
//  Created by Dmitry Victorovich on 23.02.2023.
//

import SwiftUI

struct PicturesView: View {
    
    let imageUrlString: String
    let viewHeight : CGFloat
    
    @StateObject var viewModel: PicturesViewModel
    
    var body: some View {
        VStack() {
            Spacer().frame(height: 80)  // отступ под козырек
            
            GeometryReader { imageProxy in
                ZStack() {
                    Color("lightBlueColor")
                    
                        ImageFrom(imageUrlString: imageUrlString ,
                                  size: imageProxy.size,
                                  mode: .fill)
                        
                        .blur(radius: 10)
                    
                    HStack() {
                        Spacer()
                        
                        ImageFrom(imageUrlString: imageUrlString,
                                  size: CGSize(width: imageProxy.size.height * 0.6,
                                               height: imageProxy.size.height),
                                  mode: .fit)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .scaleEffect(viewModel.scale)
                        .onAppear {
                            withAnimation(.spring()) {
                                viewModel.scale = 1
                            }
                        }
                        .onDisappear() {
                            viewModel.scale = 0
                        }
                        
                        Spacer()
                    }
                }
            }
            .frame(height: viewHeight * 0.5 + viewModel.imageHeightShift)
            Spacer()
        }
    }
}

//struct PicturesView_Previews: PreviewProvider {
//    static var previews: some View {
//        PicturesView()
//    }
//}
