//
//  CoinTicker.swift
//  CoinDiary
//
//  Created by 장혜성 on 1/9/24.
//

import Foundation

struct CoinTicker: Codable {
    let code: String
    let highPrice: Double       // 고가
    let lowPrice: Double        // 저가
    let tradePrice: Double      // 현재가
    let accTradePrice: Double  // 누적 거래대금
    
    enum CodingKeys: String, CodingKey {
        case code
        case highPrice = "high_price"
        case lowPrice = "low_price"
        case tradePrice = "trade_price"
        case accTradePrice = "acc_trade_price"
    }
}
