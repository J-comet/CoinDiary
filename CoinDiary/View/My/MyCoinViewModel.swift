//
//  MyCoinViewModel.swift
//  CoinDiary
//
//  Created by 장혜성 on 1/11/24.
//

import Foundation
import Combine

extension MyCoinView {

    final class MyCoinViewModel: ObservableObject, LifeCycleHandlerProtocol {
        
        let lifeCycle = PassthroughSubject<LifeCycle, Never>()
        
        private var cancellables = Set<AnyCancellable>()
        
        @Published var myCoinTickers: [HomeCoinRow] = []
        
        deinit {
            print("MyCoinViewModel DeInit")
            WebSocketManager.shared.closeWebSocket()
        }
        
        init() {
            print("MyCoinViewModel Init")
            bind()
            fetchMarket()
        }
        
        private func bind() {
            lifeCycle
                .sink(receiveValue: { [weak self] lifeCycle in
                    self?.lifeCycleHandling(lifeCycle)
                })
                .store(in: &cancellables)
            
            WebSocketManager.shared.coinTickerSbj
                .receive(on: DispatchQueue.main)
                .sink { [weak self] ticker in
                    guard let self else { return }
                    guard let myCoin = UserDefaults.bookmarkCoins.filter({ $0.market.market == ticker.code }).first else {
                        return
                    }
//                    print("newItem - 4")

                    let newItem = HomeCoinRow(market: myCoin.market, ticker: ticker)

                    if let index = myCoinTickers
                        .firstIndex(where: { $0.market.market == ticker.code }) {
                        myCoinTickers[index] = newItem
                    }
                }
                .store(in: &cancellables)
        }
        
        private func lifeCycleHandling(_ lifeCycle: LifeCycle) {
            print("MyCoinViewModel.lifeCycle = \(lifeCycle)")
            switch lifeCycle {
            case .viewDidLoad:
                return
            case .viewWillAppaer:
                fetchMarket()
                return
            case .viewDidAppear:
                return
            case .viewWillDisappear:
                return
            case .viewDidDisappear:
                WebSocketManager.shared.closeWebSocket()
                return
            }
        }
        
        func fetchMarket() {
            print("저장된 북마크 코인리스트 조회")
                        
            // Publishing changes from within view updates is not allowed, this will cause undefined behavior.
            // 에러 방지하기 위해 DispatchQueue 사용
            DispatchQueue.main.async {
                self.myCoinTickers = UserDefaults.bookmarkCoins
                let codes = UserDefaults.bookmarkCoins.map { $0.market.market }
                WebSocketManager.shared.send(marketCodes: codes)
            }
        }
    }
}
