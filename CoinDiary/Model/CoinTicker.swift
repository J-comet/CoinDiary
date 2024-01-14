//
//  CoinTicker.swift
//  CoinDiary
//
//  Created by 장혜성 on 1/9/24.
//

import Foundation

enum CoinChangeStatus: String {
    case rise = "RISE"
    case even = "EVEN"
    case fall = "FALL"
    
    var imageName: String {
        return switch self {
        case .rise:
            "arrowtriangle.up.fill"
        case .even:
            ""
        case .fall:
            "arrowtriangle.down.fill"
        }
    }
    
    var txtColor: String {
        return switch self {
        case .rise:
            "ed2939"
        case .even:
            "000000"
        case .fall:
            "1560bd"
        }
    }
}

struct CoinTicker: Codable {
    let code: String
    let highPrice: Double       // 고가
    let lowPrice: Double        // 저가
    let tradePrice: Double      // 현재가
    let accTradePrice: Double  // 누적 거래대금
    let timestamp: CLong         // 타임 스탬프(밀리세컨드)
    let isTradingSuspended: Bool  // 거래 정지 여부
    let accTradePrice24h: Double        // 24시간 누적 거래대금
    let accTradeVolume24h: Double       // 24시간 누적 거래량
    let askBid: String                  // 매수/매도 구분
    let change: String                  // 전일대비 - RISE: 상승 / EVEN: 보합 / FALL: 하락
    let changeRate: Double             // 부호없는 전일 등락율
    
    var highPriceValue: String {
        if highPrice < 1 {
            return "\(round(highPrice * 10000) / 10000)"
        } else {
            let numberFormatter: NumberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            let resultNum = numberFormatter.string(for: highPrice)
            return resultNum ?? "0"
        }
    }
    
    var lowPriceValue: String {
        if lowPrice < 1 {
            return "\(round(lowPrice * 10000) / 10000)"
        } else {
            let numberFormatter: NumberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            let resultNum = numberFormatter.string(for: lowPrice)
            return resultNum ?? "0"
        }
    }
    
    var tradePriceValue: String {
        if tradePrice < 1 {
            return "\(round(tradePrice * 10000) / 10000)"
        } else {
            let numberFormatter: NumberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            let resultNum = numberFormatter.string(for: tradePrice)
            return resultNum ?? "0"
        }
    }
    
    var accTradePriceValue: String {
        let acc = accTradePrice / 1000000
        let convert = Int(round(acc))
        
        if convert < 1 {
            return "\(round(accTradePrice * 1000) / 1000)"
        } else {
            let numberFormatter: NumberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            let resultNum = numberFormatter.string(for: convert) ?? "0"
            return "\(String(describing: resultNum))백만"
        }
    }
    
    var timestampToDate: String {
        let date = Date.init(timeIntervalSinceNow: TimeInterval(timestamp)/1000)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        print(dateFormatter.string(from: date))
        return dateFormatter.string(from: date)
    }
    
    var accTradePrice24hValue: String {
        return "\(round(accTradePrice24h * 10) / 10)"
//        if accTradePrice24h < 1 {
//            return "\(round(accTradePrice24h * 10) / 10)"
//        } else {
//            let numberFormatter: NumberFormatter = NumberFormatter()
//            numberFormatter.numberStyle = .decimal
//            let resultNum = numberFormatter.string(for: accTradePrice24h)
//            return resultNum ?? "0"
//        }
    }
    
    var isTradingDiscription: String {
        return if isTradingSuspended {
            "거래 불가능"
        } else {
            "거래 가능"
        }
    }
    
    // bid = 매수 , ask = 매도
    var isBid: Bool {
        return askBid == "BID" ? true : false
    }
    
    var coinChangeStatus: CoinChangeStatus {
        guard let status = CoinChangeStatus(rawValue: change) else {
            return .even
        }
        return status
    }
    
    var changeRateValue: String {
        if changeRate < 1 {
            return "\(round(changeRate * 10000) / 10000)"
        } else {
            let numberFormatter: NumberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            let resultNum = numberFormatter.string(for: changeRate)
            return resultNum ?? "0"
        }
    }

    
    enum CodingKeys: String, CodingKey {
        case code
        case highPrice = "high_price"
        case lowPrice = "low_price"
        case tradePrice = "trade_price"
        case accTradePrice = "acc_trade_price"
        case timestamp
        case isTradingSuspended = "is_trading_suspended"
        case accTradePrice24h = "acc_trade_price_24h"
        case accTradeVolume24h = "acc_trade_volume_24h"
        case askBid = "ask_bid"
        case change
        case changeRate = "change_rate"
    }
}

extension CoinTicker {
    
    static func EmptyTicker() -> CoinTicker {
        return CoinTicker(
            code: "",
            highPrice: 0,
            lowPrice: 0,
            tradePrice: 0,
            accTradePrice: 0,
            timestamp: 0,
            isTradingSuspended: true,
            accTradePrice24h: 0,
            accTradeVolume24h: 0,
            askBid: "BID",
            change: "EVEN",
            changeRate: 0
        )
    }
    
}
