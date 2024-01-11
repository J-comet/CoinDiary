//
//  HomeCoinRow.swift
//  CoinDiary
//
//  Created by 장혜성 on 1/9/24.
//

import Foundation

struct HomeCoinRow: Codable {
    var market: Market
    var ticker: CoinTicker = CoinTicker.EmptyTicker()    
}
