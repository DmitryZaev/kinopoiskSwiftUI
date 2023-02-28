//
//  CustomTabBarView.swift
//  kinopoiskSwiftUI
//
//  Created by Dmitry Victorovich on 17.02.2023.
//

import SwiftUI


struct CustomTabBarView<Content: View>: View {
    @Namespace private var filmPosition
    
    var viewModel: CustomTabBarViewModel?
    private var content: Content
    
    init(viewModel: CustomTabBarViewModel , @ViewBuilder content: () -> Content) {
        self.viewModel = viewModel
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            content
                .gesture(swipeGesture)
                .preferredColorScheme(.light)
                .transition(.opacity)
            VStack {
                TopBlindView(title: viewModel?.selectedTab?.rawValue ?? "")
                    .frame(height: 82)
                    .ignoresSafeArea()
                Spacer()
                ZStack {
                    TabViewShape()
                        .foregroundStyle(LinearGradient(colors: [Color("lightBlueColor"),
                                                                 Color("blueColor"),
                                                                 Color("lightBlueColor")],
                                                         startPoint: .top,
                                                         endPoint: .bottom))
                        .shadow(color: Color("blueColor"),radius: 20)
                        
                    TabViewShape()
                        .stroke(Color("blueColor"),
                                lineWidth: 1)
                    HStack {
                        GeometryReader { proxy in
                            ForEach(TabItem.allCases, id: \.position) {
                                makeTabItemFor(tab: $0, tabBarSize: proxy.size)
                            }
                        }
                    }
                }
                .frame(height: 82)
                .ignoresSafeArea()
            }
        }
        .ignoresSafeArea(edges: .bottom)
    }
    
    var swipeGesture: some Gesture {
        DragGesture(minimumDistance: 50, coordinateSpace: .global)
            .onEnded { value in
                if value.translation.width > 0 {
                    withAnimation(.default) {
                        moveLeft()
                    }
                } else if value.translation.width < 0 {
                    withAnimation(.default) {
                        moveRigft()
                    }
                }
            }
    }
    
    private func moveLeft() {
        guard let selected = viewModel?.selectedTab else { return }
        switch selected {
        case .search:      break
        case .collection:  viewModel?.selectedTab = .search
        case .description: viewModel?.selectedTab = .collection
        case .favorites:   viewModel?.selectedTab = .description
        }
    }

    private func moveRigft() {
        guard let selected = viewModel?.selectedTab else { return }
        switch selected {
        case .search:      viewModel?.selectedTab = .collection
        case .collection:  viewModel?.selectedTab = .description
        case .description: viewModel?.selectedTab = .favorites
        case .favorites:   break
        }
    }
    
    @ViewBuilder func makeTabItemFor(tab: TabItem, tabBarSize: CGSize) -> some View {
        ZStack {
            Button {
                withAnimation(.default) {
                    viewModel?.selectedTab = tab
                }
            } label: {
                Image(tab.imageName)
                    .resizable()
                    .frame(width: 30,
                           height: 30)
            }
            .scaleEffect(viewModel?.selectedTab == tab ? 1.4 : 1)
            
            if viewModel?.selectedTab == tab {
                Image("filmPic")
                    .resizable()
                    .frame(width: 80, height: 60)
                    .cornerRadius(10)
                    .matchedGeometryEffect(id: "filmPosition", in: filmPosition)
            }
        }
        .foregroundColor(Color("darkBlueColor"))
        .rotationEffect(.degrees(tab.rotation))
        .position(x: (tabBarSize.width / 8) * CGFloat(tab.position * 2 + 1),
                  y: tabBarSize.height / 2 + CGFloat(tab.offsetY))
    }
}
    
fileprivate struct TabViewShape: Shape {
    func path(in rect: CGRect) -> Path {
        let curveShiftY = rect.height / 3
        let smallRadius = rect.height / 10
        
        var path = Path()
        
        path.move(to: CGPoint(x: rect.minX,
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
        path.addQuadCurve(to: CGPoint(x: rect.maxX,
                                      y: rect.maxY),
                          control: CGPoint(x: rect.maxX,
                                           y: rect.midY))
        path.addQuadCurve(to: CGPoint(x: rect.minX,
                                      y: rect.maxY),
                          control: CGPoint(x: rect.midX,
                                           y: rect.maxY - curveShiftY))
        path.addQuadCurve(to: CGPoint(x: rect.minX,
                                      y: rect.minY),
                          control: CGPoint(x: rect.minX,
                                           y: rect.midY))
        return path
    }
}
