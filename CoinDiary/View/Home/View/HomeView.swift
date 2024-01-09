//
//  HomeView.swift
//  CoinDiary
//
//  Created by 장혜성 on 1/8/24.
//

import SwiftUI

/**
DetailView() 로 이동을 했지만 여전히 소켓통신이 연결되어 있었다.
 - View 의 라이프사이클 onAppear , onDisapper 메서드에서 소켓을 연결/해제를 해주었다.
 - 백그라운드로 갔다가 포그라운드로 왔을 때는??
 - 백그라운드 일때 여전히 소켓통신이 진행 중...
 - onAppear 와 onDisappear 는 View 의 라이프사이클이기 때문에 View 의 생성/소멸 시점에 호출된다.
    따라서 백그라운드/포그라운드로 진입했을 때 로그가 찍히지 않는 것을 확인했다
 - 백그라운드/포그라운드는 App 의 라이프사이클에서 확인 가능 하다.
 - 결국 App 의 라이프사이클과 View 의 라이프사이클 모두에 소켓통신을 연결/해제를 해주는 코드를 작성해서 해결
 */

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
                        .frame(maxHeight: headerMinHeight)
                        .offset(y: (offset > 0 ? -offset : 0))
                }
                .frame(minHeight: headerMinHeight)
                .background(Color(.systemGray6))
                
                LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
                    Section(header: HomeHeaderView()) {
                        ForEach(viewModel.homeTickers, id: \.market.market) { item in
                            // frame 을 지정해둬야 보이는 영역의 ImageView 만 이미지 로드 함
                            
                            NavigationLink(destination: DetailCoinView(coin: item)) {
                                HomeRowView(item: item)
                                    .frame(maxWidth: .infinity)
                                    .background(.white)
                            }
                            .buttonStyle(PlainButtonStyle())   // HomeRowView 내부 텍스트 컬러값 적용

                        }
                    }
                }
            }
            .onAppear {
                print("onAppear")
                WebSocketManager.shared.openWebSocket()
                viewModel.fetchAllMarket()
            }
            .onDisappear {
                print("onDisappear")
                WebSocketManager.shared.closeWebSocket()
            }
            .overlay(
                Rectangle()
                    .foregroundStyle(Color(uiColor: .white))
                    .frame(height: UIApplication.shared.currentUIWindow()?.safeAreaInsets.top)
                    .edgesIgnoringSafeArea(.all)
                    .opacity(offsetY > -headerMinHeight ? 0 : 1)
                , alignment: .top
            )
            .padding(.bottom, 1)
            // onChange 앱 생명주기에 따라 웹소켓 상태제어
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
