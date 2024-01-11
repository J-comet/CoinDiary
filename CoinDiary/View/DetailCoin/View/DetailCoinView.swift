//
//  DetailCoinView.swift
//  CoinDiary
//
//  Created by 장혜성 on 1/9/24.
//

import SwiftUI

struct DetailCoinView: View {
    
    // 앱 생명주기
    @Environment(\.scenePhase) var scenePhase
    
    @StateObject var viewModel: DetailCoinViewModel
    
    init(coin: HomeCoinRow) {
        _viewModel = StateObject(wrappedValue: DetailCoinViewModel(coin: coin))
    }
    
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    private let spacing: CGFloat = 30
    
    var body: some View {
        
        ZStack {
            Color.white.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 20) {
                    
                    ChartView(
                        chartCoins: $viewModel.chartCoins,
                        minVal: $viewModel.minChart,
                        maxVal: $viewModel.maxChart
                    )
                    .background {
                        RoundedRectangle(cornerRadius: 10, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                            .fill(.white.shadow(.drop(radius: 2)))
                    }
                    .padding(.init(top: 16, leading: 8, bottom: 0, trailing: 8))
                    
                    HStack {
                        
                        VStack(alignment: .leading) {
                            HStack {
                                Text(viewModel.coin.market.english)
                                    .font(.title3)
                                    .bold()
                                
                                Text("(\(viewModel.coin.market.market))")
                                    .font(.caption)
                                    .foregroundStyle(Color(.lightGray))
                            }
                            
                            Text(viewModel.coin.ticker.tradePriceValue)
                                .font(.title2)
                                .bold()
                                .foregroundStyle(
                                    viewModel.coin.ticker.isBid ? Color(hex: "ed2939") : Color(hex: "1560bd")
                                )
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(viewModel.coin.ticker.isTradingSuspended ? .orange : .green)
                                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 30)
                            
                            Text(viewModel.coin.ticker.isTradingDiscription)
                                .bold()
                                .font(.callout)
                                .foregroundStyle(.white)
                        }
                        
                        Spacer()
                        Spacer()
                    }
                    .padding()
                    
                    Divider()
                    
                    LazyVGrid(columns: columns,
                              alignment: .leading,
                              spacing: spacing,
                              pinnedViews: [],
                              content: {
                        
                        ForEach(viewModel.detailInfos, id: \.id) { item in
                            VStack(alignment: .leading) {
                                Text(item.title)
                                    .font(.subheadline)
                                    .foregroundStyle(Color(.lightGray))
                                
                                Text(item.value)
                                    .font(.callout)
                                    .bold()
                                    .foregroundStyle(Color(hex: item.askOrBidColor))
                            }
                        }
                        
                    })
                    .padding()
                    
                }
                .toolbar {
    //                ToolbarItemGroup(placement: .topBarLeading) {
    //                    Button {
    //                        showChart.toggle()
    //                    } label: {
    //                        Image(systemName: "star.fill")
    //                    }
    //                }
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        
                        Image(
                            systemName:
                                viewModel.isBookmark ? "bookmark.fill" : "bookmark"
                        )
                        .foregroundColor(
                            viewModel.isBookmark ? Color(hex: "1560bd") : Color(.lightGray)
                        )
                        .wrapToButton {
                            // 현재 저장되어 있는지 체크 후 ADD or Remove 해주기
                            viewModel.updateCoinBookmarkStatus()
                            print("클릭")
                        }
                    }
                }
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(viewModel.coin.market.korean)
            .navigationBarBackButtonTitleHidden()
        }
//        .task {
//            print("HomeView Task")
//            WebSocketManager.shared.openWebSocket()
//            viewModel.fetchMarket()
//        }
        .lifeCycle(handler: viewModel)
        .onChange(of: scenePhase) { oldValue, newValue in
            switch newValue {
            case .active:
                WebSocketManager.shared.openWebSocket()
                viewModel.fetchMarket()
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
//        .onAppear {
//            print("DetailCoinView onAppear")
////            WebSocketManager.shared.openWebSocket()
//            viewModel.fetchMarket()
//        }
//        .onDisappear {
//            print("DetailCoinView onDisappear")
//            // 뒤로 갔을 때 메인화면에서도 웹소켓을 계속 진행할거라 주석처리
////            WebSocketManager.shared.closeWebSocket()
//        }
    }
}

#Preview {
    DetailCoinView(coin: HomeCoinRow(market: Market(market: "마켓", korean: "한국어", english: "영어")))
}
