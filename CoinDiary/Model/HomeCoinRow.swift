//
//  HomeCoinRow.swift
//  CoinDiary
//
//  Created by 장혜성 on 1/9/24.
//

import Foundation

struct HomeCoinRow {
    var market: Market
    var ticker: CoinTicker = CoinTicker(code: "", highPrice: 0, lowPrice: 0, tradePrice: 0, accTradePrice: 0)
}
