//
//  DetailViewModel.swift
//  CoinDiary
//
//  Created by 장혜성 on 1/10/24.
//

import Foundation
import Combine

final class DetailViewModel: ObservableObject {
    
    private var cancellable = Set<AnyCancellable>()
    let coin: HomeCoinRow
    
    @Published var detailInfos: [DetailInfo] = []
    
    init(coin: HomeCoinRow) {
        self.coin = coin
        print(coin)
        
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
