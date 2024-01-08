//
//  Market.swift
//  CoinDiary
//
//  Created by 장혜성 on 1/9/24.
//

import Foundation

struct Market: Hashable, Codable {
    let market: String
    let korean: String
    let english: String
    
    enum CodingKeys: String, CodingKey {
        case market
        case korean = "korean_name"
        case english = "english_name"
    }
}
