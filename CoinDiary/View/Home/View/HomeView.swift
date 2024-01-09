//
//  HomeView.swift
//  CoinDiary
//
//  Created by 장혜성 on 1/8/24.
//

import SwiftUI

struct HomeView: View {
    
    // 앱 생명주기
    @Environment(\.scenePhase) var scenePhase
    
    private let headerMinHeight: CGFloat = 140
    
    @StateObject var viewModel = HomeViewModel()
    
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
                            height: headerMinHeight + (offset > 0 ? offset : 0)
                        )
                        .offset(y: (offset > 0 ? -offset : 0))
                }
                .frame(minHeight: headerMinHeight)
                .background(Color(.systemGray6))
                
                LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
                    Section(header: HomeHeaderView()) {
                        ForEach(viewModel.homeTickers, id: \.market) { item in
                            // frame 을 지정해둬야 보이는 영역의 ImageView 만 이미지 로드 함

                            HomeRowView(item: item)
                                .frame(maxWidth: .infinity)
                                .background(.white)                                
                        }
                    }
                }
            }
            .overlay(
                Rectangle()
                    .foregroundStyle(Color(uiColor: .systemGray6))
                    .frame(height: UIApplication.shared.currentUIWindow()?.safeAreaInsets.top)
                    .edgesIgnoringSafeArea(.all)
                    .opacity(offsetY > -headerMinHeight ? 0 : 1)
                , alignment: .top
            )
            // 앱생명주기에 따라 웹소켓 상태제어
            .onChange(of: scenePhase) { oldValue, newValue in
                switch newValue {
                case .active:
                    WebSocketManager.shared.openWebSocket()
                    viewModel.fetchAllMarket()
                    print("active")
                case .inactive:
                    print("inactive")
                case .background:
                    print("background")
                    WebSocketManager.shared.closeWebSocket()
                @unknown default:
                    print("error")
                }
            }
//                        .clipped()   // 상단 safeArea 영역 침범하지 않고 스티키 헤더 사용할 때
//            .edgesIgnoringSafeArea(.top) // 상단 safeArea 영역 무시하기

        }
//        .task {
//            viewModel.fetchAllMarket()
//        }
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
