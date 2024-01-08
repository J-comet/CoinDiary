//
//  HomeViewModel.swift
//  CoinDiary
//
//  Created by 장혜성 on 1/9/24.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {
    
    @Published var markets: [Market] = []
    var cancellables = Set<AnyCancellable>()
    
    func fetchAllMarket() {
        UpbitAPI.fetchMarket()
            .sink { completion in
                print("Completion: \(completion)")
            } receiveValue: { [weak self] markets in
                self?.markets = markets
            }
            .store(in: &cancellables)
    }
    
    
}
