//
//  DetailInfo.swift
//  CoinDiary
//
//  Created by 장혜성 on 1/10/24.
//

import Foundation

struct DetailInfo: Identifiable {
    let id: String = UUID().uuidString
    let title: String
    let value: String
    var askOrBidColor: String = "000000"
}
