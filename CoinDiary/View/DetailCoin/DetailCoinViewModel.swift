//
//  DetailViewModel.swift
//  CoinDiary
//
//  Created by 장혜성 on 1/10/24.
//

import SwiftUI
import Combine

extension DetailCoinView {
    
    final class DetailCoinViewModel: ObservableObject, LifeCycleHandlerProtocol {
        
        let lifeCycle = PassthroughSubject<LifeCycle, Never>()
        
        private var cancellables = Set<AnyCancellable>()
        //    let coin: HomeCoinRow
        
        @Published 
        var coin: HomeCoinRow
        
        @Published 
        var detailInfos: [DetailInfo] = []   // 상세 메뉴
        
        @Published
        var chartCoins: [ChartCoin] = []
        
        @Published 
        var minChart: Double = 0.0
        
        @Published
        var maxChart: Double = 0.0
        
        deinit {
            print("DetailViewModel DeInit")
//            WebSocketManager.shared.closeWebSocket()
        }
        
        init(coin: HomeCoinRow) {
            self.coin = coin
            print("DetailViewModel Init", coin)
            bind()
            
            updateDetailInfos()
//            WebSocketManager.shared.openWebSocket()
        }
        
        private func bind() {
            lifeCycle
                .sink(receiveValue: { [weak self] lifeCycle in
                    self?.lifeCycleHandling(lifeCycle)
                })
                .store(in: &cancellables)
        }
        
        private func lifeCycleHandling(_ lifeCycle: LifeCycle) {
            print(lifeCycle)
            switch lifeCycle {
            case .viewDidLoad:
                return
            case .viewWillAppaer:
                fetchMarket()
                return
            case .viewDidAppear:
                
                WebSocketManager.shared.coinTickerSbj
                    .receive(on: DispatchQueue.main)
                    .sink { [weak self] ticker in
                        guard let self else { return }
                        if self.coin.market.market == ticker.code {
                            self.coin = HomeCoinRow(market: coin.market, ticker: ticker)
                            self.chartCoins.append(ChartCoin(date: .now, value: ticker.tradePrice))
                            
                            self.minChart = chartCoins.map { $0.value }.sorted().first ?? 0
                            self.maxChart = chartCoins.map { $0.value }.sorted().last ?? 0
                            
                            updateDetailInfos()
                        }
                    }
                    .store(in: &cancellables)
                return
            case .viewWillDisappear:
                return
            case .viewDidDisappear:
                return
            }
        }
        
        func fetchMarket() {
            WebSocketManager.shared.send(marketCodes: [coin.market.market])
        }
        
        private func updateDetailInfos() {
            
            detailInfos = []
            
            let high = DetailInfo(
                title: "현재 고가",
                value: coin.ticker.highPriceValue,
                askOrBidColor: "ed2939"
            )
            let low = DetailInfo(
                title: "현재 저가",
                value: coin.ticker.lowPriceValue,
                askOrBidColor: "1560bd"
            )
            let volume24 = DetailInfo(
                title: "누적 거래량(24시)",
                value: coin.ticker.accTradePrice24hValue
            )
            let price24 = DetailInfo(
                title: "누적 거래대금(24시)",
                value: coin.ticker.lowPriceValue
            )

//            _detailInfos.projectedValue.append(<#T##elements: [DetailInfo]...##[DetailInfo]#>)
            
            detailInfos.append(high)
            detailInfos.append(low)
            detailInfos.append(volume24)
            detailInfos.append(price24)
        }
    }
}

