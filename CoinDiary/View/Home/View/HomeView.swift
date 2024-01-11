//
//  HomeView.swift
//  CoinDiary
//
//  Created by 장혜성 on 1/8/24.
//

import SwiftUI

/**
 * HomeViewModel 에서 상세 코인화면으로 이동시
 - 상세화면에서도 웹소켓통신 중
 - 첫번째시도 : HomeViewModel deinit 에서 소켓연결 끊고 DetailViewModel 에서 재연결
 - deinit 이 init 보다 더 늦게 호출되어 결과적으로 DetailView 에서 소켓연결이 해제되어 실패
 - 두번째시도 : 소켓 연결을 해제하지 않고 DetailCoinView 로 이동 후 웹소켓에 상세 코인의 데이터만 전송해달라고 웹소켓 Send 실행
 - 뒤로가기후 Home 으로 돌아왔을 때는 다시 코인 목록에 대한 데이터를 전송해달라고 웹소켓 Send 실행
 - 이 과정에서 뒤로가기에도 onAppear 는 실행되지 않는 문제가 있어 기존의 UIKit 의 ViewController 생명주기를 사용할 수 있도록 개발
 
 * 포그라운드 / 백그라운드 분기해서 소켓연결관리
 
 
 
 DetailCoinView() 로 이동을 했지만 여전히 소켓통신이 연결되어 있었다.
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
    
    @State private var offsetY: CGFloat = .zero
    
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
                .background(Color(.systemGray6))
            }
            //            .task {
            //                print("HomeView Task")
            //                WebSocketManager.shared.openWebSocket()
            //                viewModel.fetchAllMarket()
            //            }
            //            .onAppear {
            //                print("HomeView onAppear")
            ////                WebSocketManager.shared.openWebSocket()
            //                viewModel.fetchAllMarket()
            //            }
            //            .onDisappear {
            //                print("HomeView onDisappear")
            //                // 상세화면에서도 웹소켓을 계속 진행할 예정이라 close 코드 제거
            ////                WebSocketManager.shared.closeWebSocket()
            //            }
            .onAppear(perform: {
                viewModel.fetchAllMarket()
            })
            .overlay(
                Rectangle()
                    .foregroundStyle(Color(uiColor: .systemGray6))
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
        .lifeCycle(handler: viewModel)
        
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
