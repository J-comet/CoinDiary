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
        
        @Published var coin: HomeCoinRow
        
        @Published var detailInfos: [DetailInfo] = []   // 상세 메뉴
        
        deinit {
            print("DetailViewModel DeInit")
//            WebSocketManager.shared.closeWebSocket()
        }
        
        init(coin: HomeCoinRow) {
            self.coin = coin
            print("DetailViewModel Init", coin)
            bind()
            
            initDetailInfos()
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
                print("1234")
                
                
                WebSocketManager.shared.coinTickerSbj
                    .receive(on: DispatchQueue.main)
                    .sink { [weak self] ticker in
                        guard let self else { return }
                        self.coin = HomeCoinRow(market: coin.market, ticker: ticker)
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
        
        private func initDetailInfos() {
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
                value: "\(coin.ticker.accTradeVolume24h)"
            )
            let price24 = DetailInfo(
                title: "누적 거래대금(24시)",
                value: coin.ticker.lowPriceValue
            )
            
            self.detailInfos.append(high)
            self.detailInfos.append(low)
            self.detailInfos.append(volume24)
            self.detailInfos.append(price24)
        }
    }
}

