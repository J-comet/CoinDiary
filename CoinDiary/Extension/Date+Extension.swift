//
//  Date+Extension.swift
//  CoinDiary
//
//  Created by 장혜성 on 1/10/24.
//

import Foundation

extension Date {
    static func from(year: Int, month: Int, day: Int, hour: Int, minute: Int) -> Date {
        let components = DateComponents(year: year, month: month, day: day, hour: hour, minute: minute)
        return Calendar.current.date(from: components)!
    }
}
