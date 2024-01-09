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
    
    init(coin: HomeCoinRow) {
        self.coin = coin
        print(coin)
    }
    
}
