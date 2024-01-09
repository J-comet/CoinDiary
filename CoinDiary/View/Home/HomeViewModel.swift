//
//  HomeViewModel.swift
//  CoinDiary
//
//  Created by 장혜성 on 1/9/24.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {
    
    private var cancellable = Set<AnyCancellable>()
    
    private var markets: [Market] = []
    
    @Published var homeTickers: [HomeCoinRow] = []
    
    init() {
//        WebSocketManager.shared.openWebSocket()
//        fetchAllMarket()
        
        WebSocketManager.shared.coinTickerSbj
            .receive(on: DispatchQueue.main)
            .sink { [weak self] ticker in
                guard let self else { return }
                guard let market = markets.filter({ $0.market == ticker.code }).first else { return }
                let newItem = HomeCoinRow(market: market, ticker: ticker)
                
                if let index = homeTickers
                    .firstIndex(where: { $0.market.market == ticker.code }) {
                    homeTickers[index] = newItem
                }
                                
                homeTickers = homeTickers.sorted { $0.ticker.tradePrice > $1.ticker.tradePrice }
            }
            .store(in: &cancellable)
    }
    
    deinit {
        WebSocketManager.shared.closeWebSocket()
    }
    
    func fetchAllMarket() {
        UpbitAPI.fetchMarket()
            .sink { completion in
                print("Completion: \(completion)")
            } receiveValue: { [weak self] markets in
                guard let self else { return }            
                self.markets = markets
                let marketCodes = markets.map { $0.market }
                
//                let testCode = Array(marketCodes[0..<1])
//                let krwCodes = marketCodes.filter { $0.contains("KRW") }
//                WebSocketManager.shared.send(marketCodes: testCode)
                
                let krwCodes = marketCodes.filter { $0.contains("KRW") }
                WebSocketManager.shared.send(marketCodes: krwCodes)
                
                // 처음 실행시 모든 아이템 추가
                let item = markets.map {
                    HomeCoinRow(
                        market: $0,
                        ticker: CoinTicker.EmptyTicker()
                    )
                }
                homeTickers.append(contentsOf: item)
            }
            .store(in: &cancellable)
    }
    
    
    
}
