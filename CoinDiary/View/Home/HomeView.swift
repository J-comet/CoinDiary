//
//  HomeView.swift
//  CoinDiary
//
//  Created by 장혜성 on 1/8/24.
//

import SwiftUI

struct HomeView: View {
    
    @State private var offsetY: CGFloat = CGFloat.zero
    
    var body: some View {
        
        NavigationView {
            ScrollView(.vertical, showsIndicators: true) {
                
                GeometryReader { geometry in
                    let offset = geometry.frame(in: .global).minY
                    setOffset(offset: offset)
                    
                    Image(.coindiaryBackground)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipped()
                        .frame(
                            width: geometry.size.width,
                            height: 250 + (offset > 0 ? offset : 0)
                        )
                        .offset(y: (offset > 0 ? -offset : 0))
                }
                .frame(minHeight: 250)
                
                LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
                    Section(header: HomeHeaderView()) {
                        ForEach(0..<50) { item in
                            // frame 을 지정해둬야 보이는 영역의 ImageView 만 이미지 로드 함
                            Text("sdsdsd")
                                .frame(maxWidth: .infinity)
                                .background(.white)
                        }
                    }
                }
            }
            .overlay(
                Rectangle()
                    .foregroundColor(.white)
                    .frame(height: UIApplication.shared.currentUIWindow()?.safeAreaInsets.top)
                    .edgesIgnoringSafeArea(.all)
                    .opacity(offsetY > -240 ? 0 : 1)
                , alignment: .top
            )
//                        .clipped()   // 상단 safeArea 영역 침범하지 않고 스티키 헤더 사용할 때
//            .edgesIgnoringSafeArea(.top) // 상단 safeArea 영역 무시하기

        }
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
    
    func setOffset(offset: CGFloat) -> some View {
        DispatchQueue.main.async {
            self.offsetY = offset
        }
        return EmptyView()
    }
}

#Preview {
    HomeView()
}
