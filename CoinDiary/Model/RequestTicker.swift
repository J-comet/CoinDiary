//
//  RequestTicker.swift
//  CoinDiary
//
//  Created by 장혜성 on 1/9/24.
//

import Foundation

struct RequestTicker: Encodable {
    let ticket = Ticket()
    var codesType: CodesType
    let format = Format()

    init(codesType: CodesType) {
        self.codesType = codesType
    }
}


struct Ticket: Encodable {
    let ticket = "test example"
}

struct CodesType: Encodable {
    let type = "ticker"
    var codes: [String]
}

struct Format: Encodable {
    let format = "DEFAULT"
}
